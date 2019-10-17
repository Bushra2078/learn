In this section, you follow along with Amita and Andy as they talk about how to incorporate Selenium UI tests into the release pipeline. They begin by walking through the tests that Amita normally performs manually. Then they map Amita's manual steps to automated test cases.

## Run UI tests manually

Amita is waiting for Andy to show up. Andy is going to help Amita write a UI test that will be added to the _Test_ stage of the pipeline. He sees Amita scribbling in her notebook, crossing something out, muttering, and then tearing out the page. "Hi," he says. "You don't look happy."

**Amita:** I'm not happy. I'm trying to figure out how to write an automated test but I don't know where to start. I don't code. I feel like I'm obsolete.

**Andy:** Wow, I really don't think it's that bad. For one thing, we'll always need someone who can keep the user's perspective in mind. There's no way to automate that. For another, no one starts out knowing how to do this. We were all beginners at some point. Hopefully, I can make the learning process a bit easier.

I think the best way to start is to automate something you already do all the time, manually. Pick a UI test. Then, let's walk through it and write down the steps. Next, we'll figure out how to automate those steps. What test should we pick?

Amita takes a deep breath.

**Amita:** Let's automate the modal window tests. When I click on certain things, like the **Download game** button for example, I want to verify that the correct modal window appears. Then, when I click away from the modal window, I want to verify that the modal window disappears and that the main window is active again.

**Andy:** That sounds like a great place to start. You run the test and I'll write down the procedure.

Mara opens her Windows laptop and launches Google Chrome. She goes to the web app and verifies that the home page comes up.

> [!TIP]
> For reference, Microsoft hosts a version of the [Space Game](http://tailspin-spacegame-web.azurewebsites.net?azure-portal=true) website. Go there if you want to follow along with Amita's manual tests. Otherwise, you can just read along.

**Andy:** OK. What do you check next?

**Amita:** I check that when I click the **Download game** button, the correct modal window appears.

Amita clicks the **Download game** button and sees the modal window appear.

![A browser showing the Download game modal window on the Space Game website](../media/4-website-download-game-modal.png)

**Andy:** Great. What modal windows do you check next?

**Amita:** Next, I check the game screens. There are four of them. After that, I click the top player on the leaderboard and verify that the player's profile appears.

Amita clicks on each of the four thumbnail images to show the example game screens.

![A browser showing the game screen modal window on the Space Game website](../media/4-website-game-screens.png)

Next, Amita clicks on the top player on the leaderboard and sees the player's profile.

![A browser showing the leaderboard modal window on the Space Game website](../media/4-website-leaderboard.png)

**Amita:** That covers the modal window tests. I run these tests on Windows because that's how most players visit our site. I run the tests on Chrome, and when I have time I also run them on Firefox and Edge.

If I had the time, I would run everything again on macOS and Linux, just to ensure we're compatible with any operating system our users visit the site from. But there are many other tests that I need to run.

## Get the XPath expressions for the HTML elements

Here, you follow along with Amita and Andy as they collect the XPath expressions for the buttons that Amita clicks and the resulting modal windows. XPath is a query language that lets you locate an XML element and retrieve information about it. XPath also works with HTML.

**Andy:** I can see why these tests take so long and can be so frustrating. You're going to love automating them, I promise. Here's what we'll do.

We'll get the XPath expression for each button you click as well as the modal window that appears. The automated tests that we write can use these expressions to know which buttons to click and which modal windows to expect.

Let's start by getting the XPath expression for the **Download game** button.

> [!NOTE]
> You can follow these steps if you'd like to, or just read along. We'll provide all of the XPath expressions you need in the next section, when you run the automated tests.

1. In Google Chrome, go to the _Space Game_ home page.
1. Right-click the **Download game** button, then select **Inspect**.

    You see the developer tools window open. The HTML code for the **Download game** button is highlighted.

    ![A browser showing the developer tools window and a selected HTML element](../media/4-website-inspect-button.png)

1. Right click on the highlighted text, point to **Copy** and then select **Copy XPath**.
1. Paste the text into a document somewhere. We'll use it later.

    The XPath expression for the **Download game** button is `/html/body/div/div/section[2]/div[2]/a`.

1. Click the **Download game** button, then repeat steps 2-4 to get the XPath expression for the modal window that appears.
1. Repeat the process for the four game screens and the top player on the leaderboard.

Amita opens Microsoft Word and adds a table that contains the XPath expression for each link and the XPath expression for the corresponding modal window. To keep things basic, she records:

* The **Download game** button.
* Just one of the game screens.
* The top player on the leaderboard.

Here's what her table looks like:

> [!div class="mx-tableFixed"]
> | Feature                  | Link XPath                                                             | Modal XPath                            |
> |--------------------------|------------------------------------------------------------------------|----------------------------------------|
> | **Download game** button | `/html/body/div/div/section[2]/div[2]/a`                               | `//*[@id=\"pretend-modal\"]/div/div`   |
> | First game screen        | `/html/body/div/div/section[3]/div/ul/li[1]/a`                         | `/html/body/div[1]/div/div[2]`         |
> | Top leaderboard player   | `/html/body/div/div/section[4]/div/div/div[1]/div[2]/div[2]/div/a/div` | `//*[@id=\"profile-modal-1\"]/div/div` |

## Plan the automated tests

**Amita:** OK. We have the XPath expression for each button I click and the resulting modal window. What's next?

**Andy:** I think we're ready to write our tests. Here's what we'll do:

1. Create an NUnit project that includes Selenium. The project will exist along with the source code for the app.
1. Write a test case that uses automation to click the specified link and that verifies that the expected modal window appears.
1. Use the XPath data we saved to specify the parameters to the test case method. This creates a sequence, or series, of tests.
1. Configure the tests to run on Chrome, Firefox and Edge. This creates a matrix of tests.
1. Run the tests and watch each web browser come up automatically.
1. Watch as Selenium automatically runs through the series of tests for each browser.
1. See in the console window that all the tests pass.

**Amita:** I'll be excited to see how quickly the tests run. Can we try this now?

**Andy:** Absolutely. Let's move over to my laptop where I have the app code ready.