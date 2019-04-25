Andy is going to work with Mara and add unit tests to the automated build that Mara created with Azure Pipelines. Regression bugs are creeping into their code and breaking the leaderboard's filtering functionality. Specifically, the wrong game mode keeps appearing.

The following image illustrates Amita's problem. When Amita selects "Milky Way" to show only scores from that game map, she gets results from other game maps such as Andromeda.

![The leaderboard showing incorrect results](../media/4-leaderboard-bug.png)

Both Andy and Mara want to catch the error before it reaches Amita, the tester. Unit tests are a great way to automatically test for regression bugs.

Andy also thinks that adding the unit tests now will give them a head start as they improve the _Space Game_ web app. The application uses a document database to store high scores and player profiles. Right now, it uses local test data. Later, they plan to connect the app to a live database.

There are a number of unit test frameworks available for C# applications. Mara chooses NUnit because it's popular with the community and she's used it before.

Here's the unit test you'll work with, along with Mara and Andy.

```csharp
[TestCase("Milky Way")]
[TestCase("Andromeda")]
[TestCase("Pinwheel")]
[TestCase("NGC 1300")]
[TestCase("Messier 82")]
public void FetchOnlyRequestedGameRegion(string gameRegion)
{
    const int PAGE = 0; // take the first page of results
    const int MAX_RESULTS = 10; // sample up to 10 results

    // Form the query predicate.
    // This expression selects all scores for the provided game region.
    Expression<Func<Score, bool>> queryPredicate = score => (score.GameRegion == gameRegion);

    // Fetch the scores.
    Task<IEnumerable<Score>> scoresTask = _scoreRepository.GetItemsAsync(
        queryPredicate, // the predicate defined above
        score => 1, // we don't care about the order
        PAGE,
        MAX_RESULTS
    );
    IEnumerable<Score> scores = scoresTask.Result;

    // Verify that each score's game region matches the provided game region.
    Assert.That(scores, Is.All.Matches<Score>(score => score.GameRegion == gameRegion));
}
```

You can filter the leaderboard by any combination of game type and game map.

This test queries the leaderboard for high scores and verifies that each result matches the provided game map.

In an NUnit test method, `TestCase` provides inline data to use to test that method. Here, NUnit calls the `FetchOnlyRequestedGameRegion` unit test method like this:

```csharp
FetchOnlyRequestedGameRegion("Milky Way");
FetchOnlyRequestedGameRegion("Andromeda");
FetchOnlyRequestedGameRegion("Pinwheel");
FetchOnlyRequestedGameRegion("NGC 1300");
FetchOnlyRequestedGameRegion("Messier 82");
```

Notice the call to the `Assert.That` method at the end of the test. An _assertion_ is a condition or statement that you declare to be true. If the condition turns out to be false, that could indicate a bug in your code. NUnit runs each test method using the inline data you specify and records the result as a passing or failing test.

Many unit test frameworks provide verification methods that resemble natural language. This helps make tests easy to read and maps the test to the application's requirements.

Consider the assertion made in this example.

```csharp
Assert.That(scores, Is.All.Matches<Score>(score => score.GameRegion == gameRegion));
```

You might read this line as:

> _Assert that the game region of each returned score matches the provided game region._

Here's the process you'll follow.

1. Fetch a branch from Microsoft's GitHub repository that contains the unit tests.
1. Run the tests locally to verify that they pass.
1. Add tasks to your pipeline configuration to run the tests and collect the results.
1. Push the branch to your GitHub repository.
1. Watch your Azure Pipelines project automatically build the application and run the tests.

## Fetch the branch from GitHub

Here you'll fetch the `unit-tests` branch from GitHub and checkout, or switch to, that branch.

This branch contains the _Space Game_ project you worked with in the previous modules and an Azure Pipelines configuration to start with.

1. From Visual Studio Code, open the integrated terminal.
1. Run the following `git checkout` command to create a branch named `unit-tests` using what's called a _tracking branch_ from Microsoft's repository.

    ```bash
    git checkout --track upstream/unit-tests
    ```

    Here, `upstream` refers to Microsoft's GitHub repository. You typically don't use the `--track` flag very often, but here you use it to get starter code from Microsoft's repository. Shortly, you'll push this branch up to your GitHub repository, known as `origin`.

    Your project's Git configuration understands the `upstream` remote because you set up that relationship when you forked the project from Microsoft's repository.
1. As an optional step, open **azure-pipelines.yml** from Visual Studio code and familiarize yourself with the initial configuration.
    The configuration resembles the basic one you created in the [Create a build pipeline with Azure Pipelines](/learn/modules/create-a-build-pipeline-azure-pipelines/6-create-the-pipeline?azure-portal=true) module. It builds only the application's Release configuration.

## Run the tests locally

It's a good idea to run all tests locally before you submit any tests to the pipeline. Here you'll do that.

1. From Visual Studio Code, open the integrated terminal.
1. Run `dotnet build` to build each project in the solution.

    ```bash
    dotnet build --configuration Release
    ```

1. Run the following `dotnet test` command to run the unit tests.

    ```bash
    dotnet test --configuration Release --no-build
    ```

    The `--no-build` flag specifies not to build the project before running it. You don't need to build the project because you built it in the previous step.

    You see that all five tests pass.

    ```output
    Starting test execution, please wait...

    Total tests: 5. Passed: 5. Failed: 0. Skipped: 0.
    Test Run Successful.
    Test execution time: 1.0939 Seconds
    ```

    In this example, the tests took about one second to run.

    Notice that there were five total tests. Although we define just one test method, `FetchOnlyRequestedGameRegion`, that test is run five times, once for each game map as specified in the `TestCase` inline data.

1. Run the tests a second time. This time, provide the `--logger` option to write the results to a log file.

    ```bash
    dotnet test Tailspin.SpaceGame.Web.Tests --configuration Release --no-build --logger trx
    ```

    You see from the output that a .trx file is created in the **TestResults** directory.

    A TRX file is an XML document that contains the results of a test run. It's a popular format for NUnit tests because Visual Studio and other tools can help you visualize the results.

    Later, you'll see how Azure Pipelines can help you visualize and track your tests results as they run through the pipeline.

    > [!NOTE]
    > TRX files are not meant to be included in source control. A **.gitignore** file enables you specify which temporary and other files you want Git to ignore. The project's **.gitignore** file is already set up to ignore anything in the **TestResults** directory.

1. As an optional step, open **DocumentDBRepository_GetItemsAsyncShould.cs** from the **Tailspin.SpaceGame.Web.Tests** folder in Visual Studio Code and examine the test code. Even if you're not interested in building .NET Core apps specifically, you might find it useful because it resembles code you might see in other unit test frameworks.

## Add tasks to your pipeline configuration

Here you'll configure the build pipeline to run your unit tests and collect the results.

1. From Visual Studio Code, modify **azure-pipelines.yml** like this.

    ```yml
    pool:
      vmImage: 'Ubuntu-16.04'
      demands:
        - npm

    variables:
      buildConfiguration: 'Release'
      wwwrootDir: 'Tailspin.SpaceGame.Web/wwwroot'
      dotnetSdkVersion: '2.1.505'

    steps:
    - task: DotNetCoreInstaller@0
      displayName: 'Use .NET Core SDK $(dotnetSdkVersion)'
      inputs:
        version: '$(dotnetSdkVersion)'

    - task: Npm@1
      displayName: 'Run npm install'
      inputs:
        verbose: false

    - script: './node_modules/.bin/node-sass $(wwwrootDir) --output $(wwwrootDir)'
      displayName: 'Compile Sass assets'

    - task: gulp@1
      displayName: 'Run gulp tasks'

    - script: 'echo "$(Build.DefinitionName), $(Build.BuildId), $(Build.BuildNumber)" > buildinfo.txt'
      displayName: 'Write build info'
      workingDirectory: $(wwwrootDir)

    - task: DotNetCoreCLI@2
      displayName: 'Restore project dependencies'
      inputs:
        command: 'restore'
        projects: '**/*.csproj'

    - task: DotNetCoreCLI@2
      displayName: 'Build the project - $(buildConfiguration)'
      inputs:
        command: 'build'
        arguments: '--no-restore --configuration $(buildConfiguration)'
        projects: '**/*.csproj'

    - task: DotNetCoreCLI@2
      displayName: 'Run unit tests - $(buildConfiguration)'
      inputs:
        command: 'test'
        arguments: '--no-build --configuration $(buildConfiguration)'
        publishTestResults: true
        projects: '**/*.Tests.csproj'

    - task: DotNetCoreCLI@2
      displayName: 'Publish the project - $(buildConfiguration)'
      inputs:
        command: 'publish'
        projects: '**/*.csproj'
        publishWebProjects: false
        arguments: '--no-build --configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory)/$(buildConfiguration)'
        zipAfterPublish: true

    - task: PublishBuildArtifacts@1
      displayName: 'Publish Artifact: drop'
      condition: succeeded()
    ```

    This version introduces this `DotNetCoreCLI@2` build task.

    ```yml
    - task: DotNetCoreCLI@2
      displayName: 'Run unit tests - $(buildConfiguration)'
      inputs:
        command: 'test'
        arguments: '--no-build --configuration $(buildConfiguration)'
        publishTestResults: true
        projects: '**/*.Tests.csproj'
    ```

    This build task runs the `dotnet test` command.

    Notice that this task does not specify the `--logger trx` argument that you used when you ran the tests manually. The `publishTestResults` argument adds that for you. This argument tells the pipeline to generate the TRX file to a temporary directory, accessible through the `$(Agent.TempDirectory)` built-in variable. It also publishes the task results to the pipeline.

    The `projects` argument specifies all C# projects that match "**/*.Tests.csproj". The "\*\*" part matches all directories and the "\*.Tests.csproj" part matches all projects whose file name ends with ".Tests.csproj". The `unit-tests` branch contains just one unit test project, **Tailspin.SpaceGame.Web.Tests.csproj**. But specifying a pattern enables you to run additional test projects without the need to modify your build configuration.

## Push the branch to GitHub

Here you'll push your changes to GitHub and see the pipeline run. Recall that you're currently on the `unit-tests` branch.

1. From the integrated terminal, add **azure-pipelines.yml** to the index, commit the changes, and push the branch up to GitHub.

    ```bash
    git add azure-pipelines.yml
    git commit -m "Run and publish unit tests"
    git push origin unit-tests
    ```

## Watch Azure Pipelines run the tests

Here you'll see the tests run in the pipeline and then visualize the results from Azure Test Plans. Azure Test Plans provides all the tools you need to successfully test your applications. You can create and run manual test plans, generate automated tests and collect feedback from stakeholders.

<!-- TODO: We really haven't talked about Azure Test Plans yet. Add it to the knowledge unit? -->

1. From Azure DevOps, trace the build through each of the steps.

    You see that the **Run unit tests - Release** task runs the unit tests just as you did manually from the command line.

    ![Azure Pipelines showing running unit tests](../media/4-pipeline-task.png)

1. After the build completes, click the **Summary** tab.

    You see that the test run is included in the progression.

    ![Azure Pipelines showing the Summary tab](../media/4-summary-report.png)

1. Click the link that refers to the pass rate to access the test failure report.

    The report is empty because there were no failures. Open the status filter and select **Passed** to see both failed and passed tests.

    ![Filtering both failed and passing unit tests](../media/4-test-failures-filter.png)

    At the bottom of the page, you see details about each individual test. If the test run included failures, you can select a failed test to learn more about the failure.

1. From Azure DevOps, select **Test Plans**. Then select **Runs**.

    ![Opening Azure Test Plans](../media/4-test-plans-runs.png)

    You see the most recent test runs, including the one you just ran.

1. Double click the most recent test run.

    You see a summary of the results.

    ![Test results summary in Azure Test Plans](../media/4-test-run-results.png)

    In this example, all five tests have passed. If any tests failed, you could navigate to the build task to get additional details.

    You can also download the .trx file so you can examine it through Visual Studio or another visualization tool.

Although Mara and Andy have only added one test, it's a good start and fixes the immediate problem. Now, the team has a place to add more tests and run them as they improve their process.

## Merge your branch into master

Mara and Andy are happy with their results, so they decide to merge the `unit-tests` branch to `master`. In practice, you would do the same. But for brevity, we'll skip that process for now.