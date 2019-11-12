Cosmos DB provides a highly scalable document store suitable for holding a wide range of document types. The SQL API enables you to write applications that can easily query and maintain documents. 

In the sample scenario, you're using Cosmos DB to store the details of students, and the course grades they achieved. You've written and tested code to create student objects in memory. You now need to add functionality to save these documents to Cosmos DB, and to query documents held in Cosmos DB.

In this exercise, you'll extend the JavaScript app you wrote previously. You'll add code that saves student documents to the Cosmos DB container you created in the first exercise of this module. You'll add a query capability that enables users to find the course grades achieved by a specified student in a given academic year. Then you'll see the grades received by students who took a particular course.

This exercise runs on your desktop computer, and uses an Azure sandbox for your resources.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Configure a connection to Cosmos DB

The first task is to enable your application to connect to the Cosmos DB account you created in the first exercise.

1. Start VS Code if it isn't already running, and open the **grades** folder, holding the **studentgrades.js** file.

2. On the **Terminal** menu, click **New Terminal** if you don't currently have a terminal window open.

3. In the **Terminal** window, run the following command to install the Cosmos DB package for JavaScript:

    ```bash
    npm install @azure/cosmos
    ```

4. Add the following code to the studentgrades.js file, immediately above the **Student** class. This object wraps the connection, database, and container information you'll use to access documents in the Cosmos DB database:

    ```javascript
    var config = {
        connectionString: "YOUR CONNECTION STRING WILL GO HERE SHORTLY",
        database: "SchoolDB",
        container: "StudentCourseGrades"
    }
    ```

5. In the toolbar on the left side of VS Code, select the **Azure** icon.

6. In the **Cosmos DB** pane, , if you aren't already connected, click **Sign in to Azure**. Sign in with the same credentials you used to set up the sandbox. In the command palette, type **Azure**, and then select **Azure: Select Subscriptions**. Select **Concierge Subscription**, and then click **OK**.

    ![Screenshot of Cosmos DB pane in VS Code. The user is about to sign in to Azure](../media/7-azure-sign-in.png)

7. Expand your Azure account, right-click the **\<*your name or initials*\>school** Cosmos DB account, and then click **Copy Connection String**.

    ![Screenshot of Cosmos DB pane in VS Code. The user is copying the connection string for the Cosmos DB account to the clipboard](../media/7-connection.png)

8. Paste the connection string for your Cosmos DB account where indicated in the **connectionString** property of the **config** object in your code.

9. Add the following code between the **config** object and the **Student** class:

    ```javascript
    var cosmos = require("@azure/cosmos");

    const client = new cosmos.CosmosClient(config.connectionString);
    const databaseid = config.database;
    const containerid = config.container;
    const containerref = client.database(databaseid).container(containerid);
    const containerdata = containerref.items;
    ```

    The `require` statement loads the types and functions in the **cosmos** package.

    You use the **CosmosClient** object to connect to your Cosmos DB account. Use the connection string that you specified in the **config.js** script. The **containerref** object is a reference to the **StudentGrades** container in the **SchoolDB** database in your Cosmos DB account. You'll use the **containerdata** object to access the documents in this container.

10. Save the file.

## Maintain student documents in a container

You'll now use the Cosmos DB client to insert, update, and delete student documents in the database.

1. Add the following function to your code, directly above the **Student** class:

    ```javascript
    function isOK(statusCode) {
        return statusCode >= 200 && statusCode <= 299;
    }
    ```

    This function takes an HTTP status code, and returns **true** if the code is in the 200 range. Codes in this range typically indicate that an operation was successful.

2. Add the function shown below to the script, after the **isOK** function:

    ```javascript
    async function addStudent(student) {
        const { item, statusCode } = await containerdata.create(student).catch();
        isOK(statusCode) && process.stdout.write(`Added student with id: ${item.id}\n`);
    }
    ```

    This function takes a **Student** object and adds it to the container in the Cosmos DB database. If the insert was successful, the function displays a message indicating that the student document was added.

    > [!NOTE]
    > If the **create** method returns an HTTP status code outside of the 200-299 range, it throws an exception. The empty **catch** handler is intended to catch and discard this exception as it's handled by the **isOK** statement.

3. Add the **updateStudent** function shown below to the script, after the **addStudent** function:

    ```javascript
    async function updateStudent(student) {
        const { item, statusCode } = await containerdata.upsert(student).catch();;
        isOK(statusCode) && process.stdout.write(`Updated student with id: ${item.id}\n`);
    }
    ```

    This function uses the **upsert** operation of the container to update the student document with the data provided in the **student** parameter. You use this function to modify a student document.

4. Add the function shown below to the script, after the **updateStudent** function:

    ```javascript
    async function deleteStudent(student) {
        const { item, statusCode } = await containerref.item(student.id, student.StudentID).delete().catch();
        isOK(statusCode) && process.stdout.write(`Deleted student with id: ${item.id}\n`);
    }
    ```

    This function removes the document for the specified student from the container in the Cosmos DB database.

## Query and retrieve student documents from a container

In this task, you'll add a function that retrieve a student document using its ID. You'll also create a more generalized function that finds all students that have taken a particular course.

1. Add the function shown below to the script, after the **deleteStudent** function:

    ```javascript
    async function getStudent(studentID) {
        const { resource, statusCode } = await containerref.item(studentID, studentID).read().catch();;
        if (isOK(statusCode)) {
            process.stdout.write(`Student data: ${resource.id}: ${resource.Forename}, ${resource.Lastname}\n`);
            resource.CourseGrades.forEach (function(coursegrade) {
                process.stdout.write(`${coursegrade.Course}:${coursegrade.Grade}\n`);
            });
            return new Student(resource.StudentID, resource.Forename, resource.Lastname);
        }
        return null;
    }
    ```

    This function fetches a student document, given the id and the studentID (the partition key). The details of the student are displayed. The `forEach` loop displays the grades for each course the student has taken, listed in the **CourseGrades** array for the student. The function returns a **Student** object using the details retrieved from the database. If no matching student is found, the function returns a null reference.

2. Add the following function, after the **getStudent** function:

    ```javascript
    async function queryStudents(courseName) {
        const studentquery = {
            query: "SELECT s.id, s.Forename, s.Lastname, c.Course, c.Grade \
                    FROM students s JOIN c IN s.CourseGrades \
                    WHERE c.Course = @coursename",
            parameters: [
                {
                    name: "@coursename",
                    value: courseName
                }
            ]
        };

        const { resources } = await containerdata.query(studentquery).fetchAll();
        for (let queryResult of resources) {
            let resultString = JSON.stringify(queryResult);
            process.stdout.write(`\nQuery returned ${resultString}\n`);
        }
    }
    ```

    This function uses the **query** function of the container to find the documents for all students who have taken the course specified in the function argument. The function displays the details of each student, and the grade achieved.

## Test the cosmosgrades app

You can now create and run a test harness that verifies that your code creates student documents correctly.

1. Replace the existing **test** function near the end of the script with the code shown below. Note that this is an asynchronous function:

    ```javascript
    async function test() {
        process.stdout.write("\n\nTesting addStudent and getStudent\n\n");

        let student1 = getStudentData();
        await addStudent(student1).then(
            () => getStudent(student1.StudentID)
        );

        process.stdout.write("\n\n");

        let student2 = getStudentData();
        await addStudent(student2).then(
            () => getStudent(student2.StudentID)
        );

        process.stdout.write("\n\n");

        process.stdout.write("\n\nTesting updateStudent\n\n");
        student1.addGrade("Physics", "A");
        student1.addGrade("Chemistry", "C");
        await updateStudent(student1).then(
            () => getStudent(student1.StudentID)
        );

        process.stdout.write("\n");

        student2.addGrade("Physics", "B");
        student2.addGrade("Mathematics", "D");
        await updateStudent(student2).then(
            () => getStudent(student2.StudentID)
        );

        process.stdout.write("\n\n");

        process.stdout.write("\n\nTesting queryStudents\n\n");
        process.stdout.write("Students who have taken Physics\n");
        await queryStudents("Physics");

        process.stdout.write("\n\nStudents who have taken Computer Science\n");
        await queryStudents("Computer Science");

        // Delete the students created in the first exercise
        process.stdout.write("\n\nTesting deleteStudent\n\n");
        let oldStudent = await getStudent("S101");
        if (oldStudent) {
            await deleteStudent(oldStudent).then(
                () => getStudent(oldStudent.StudentID)
            );
        }

        oldStudent = await getStudent("S102");
        if (oldStudent) {
            await deleteStudent(oldStudent).then(
                () => getStudent(oldStudent.StudentID)
            );
        }

        process.stdout.write("\n\nDone\n");
    }
    ```

    This code tests each of the functions you've created. It does the following tasks:

    1. It creates two students, and adds them to the container using the **addStudent** function. The test verifies that the students were created using the **getStudent** function.

    2. It assigns grades for each course to both students, then updates the student documents in the Cosmos DB container with the **updateStudent** function. The **getStudent** function is run to retrieve and display the details of each student. These details should now include the course grade data.

    3. It runs the **queryStudents** function to display the grades for all students who have taken each course.

    4. It removes student documents from the container in Cosmos DB with the **deleteStudent** function. The students removed are those created manually, in the first exercise in this module. The **getStudent** function is used to retrieve the student data afterwards. In both cases, the documents should no longer be present, and nothing will be displayed.

2. Save the file.

3. On the **View** menu, click **Terminal** to display the terminal window.

4. In the Terminal window, run the **studentgrages** script:

    ```bash
    node studentgrades.js
    ```

    The messages **Testing addStudent** and **getStudent** appear in the terminal window.

5. At the first set of prompts, enter the values shown in the following table:

    | Prompt  | Value  |
    |---|---|
    | Please enter the student's ID | S501 |
    | Enter the student's forename: | ABC |
    | Enter the student's last name: | DEF |

    The following messages should appear. This is the data displayed by the **getStudent** function, after the course has been added to the Cosmos DB container by the **addStudent** function:

    ```text
    Added student with id: S501
    Student data: S501: ABC, DEF
    ```

6. At the next set of prompts, enter the following values:

    | Prompt  | Value  |
    |---|---|
    | Please enter the student's ID | S502 |
    | Enter the student's forename: | TUV |
    | Enter the student's last name: | XYZ |

    The following message should appear, indicating that the document for this student has also been added to the Cosmos DB container.

    ```text
    Added student with id: S502
    Student data: S502: TUV, XYZ
    ```

7. You should then see the following sequence of messages as the remaining functionality is tested:

    ```text
    Testing updateStudent

    Updated student with id: S501
    Student data: S501: ABC, DEF
    Physics:A
    Chemistry:C

    Updated student with id: S502
    Student data: S502: TUV, XYZ
    Physics:B
    Mathematics:D

    STUFF HERE TO SORT OUT

    Done
    ```

    **START ABOVE**

8. Close the debug terminal window.

## Verify the documents in the Cosmos DB database

You'll now query the documents in the database directly, using the Azure Cosmos DB extension for VS Code. You'll verify that the documents created by the app have been stored in the database.

1. In the **Cosmos DB** pane, expand your Azure account, expand the **\<your name or initials\>school** Cosmos DB account, expand the **SchoolDB** database, expand the **StudentCourseGrades** container, right-click **Documents**, and then click **Refresh**.

    ![Screenshot of Cosmos DB pane in VS Code. The user has selected the **Refresh** command](../media/7-cosmosdb-refresh.png)

2. Expand the **Documents** folder. You should see the four documents that you created in the first exercise (**C101**, **C102**, **SU001**, and **SU002**), together with the four documents created by the cosmosgrades.js app:

    ![Screenshot of Cosmos DB pane in VS Code showing the documents in the **StudentCourseGrades** container](../media/7-cosmosdb-documents.png)

3. Click the **CS201** document. It should look similar to this:

    ```json
    {
        "id": "CS201",
        "CourseName": "Computer Science",
        "AcademicYear": "2019",
        "_rid": "VHU7AIjfokgLAAAAAAAAAA==",
        "_self": "dbs/VHU7AA==/colls/VHU7AIjfokg=/docs/VHU7AIjfokgLAAAAAAAAAA==/",
        "_etag": "\"9f004e6d-0000-1000-0000-5d9f15620000\"",
        "_attachments": "attachments/",
        "_ts": 1570706786
    }
    ```

    The contents of the **id**, **CourseName**, and **AcademicYear** fields should match the input you provided for course **CS201** when you ran the app.

    If time allows, also examine the **CS202** document.

4. Click the **SU998** student document. You should see the details of the student, including the grades for each course in the **CourseGrades** array:

    ```json
    {
        "id": "SU998",
        "AcademicYear": "2019",
        "Name": {
            "Forename": "Eeeeee",
            "Lastname": "Ffffff"
        },
        "CourseGrades": [
            {
                "Course": "Computer Science",
                "Grade": "A"
            },
            {
                "Course": "Statistics",
                "Grade": "C"
            }
        ],
        "_rid": "VHU7AIjfokgNAAAAAAAAAA==",
        "_self": "dbs/VHU7AA==/colls/VHU7AIjfokg=/docs/VHU7AIjfokgNAAAAAAAAAA==/",
        "_etag": "\"9f000e78-0000-1000-0000-5d9f158a0000\"",
        "_attachments": "attachments/",
        "_ts": 1570706826
    }
    ```

You've now used VS Code to create a Node.js application that can query, insert, update, and delete documents in a Cosmos DB database.
