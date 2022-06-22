Employees are typically expected to use many applications to accomplish tasks. For most of the applications, Employees have to sign in and consent to the application's permissions before they can use the application. Sometimes when the employee isn't able to consent to an application and doesn't know how to get approval from their administrator, they opt to create logins in the application's site with their personal work accounts. Since these logins aren't easy to track, it's recommended that all employees use their work accounts with Single Sign-On to access new applications.

To encourage employees to follow the recommended way of accessing new applications, an administrator can configure admin consent workflow to enable the employee to request admin consent right from the consent screen when the employee is unable to grant consent by themselves.

## Example scenario

Suppose you work as an IT admin for a retail company that focuses on integrating applications for the employees in your organization. To be as secure as possible, you haven't allowed users to grant access to any applications in their tenant, which means only administrators can grant access to adding an application. Sometimes, your coworkers send you emails asking you to add applications they would like to use with their work accounts. You can't keep up with the requests, and you’re having to research the permissions and information about each application. You hear about admin consent workflow, which can field and track requests in the Azure portal and give trusted and up to date information for each application.

## What we'll be doing

Admin consent workflow provides a secure way for administrators to onboard new applications into their organizations while still supporting the users through the process.

In this module, a locally created single page application is used to demonstrate the admin consent workflow. However, you can use your own custom application if you already have one.

You'll undertake the following tasks in this learn module:

- **Create a single page application and register it as an Azure AD application** - Download a code sample to quickly set up the application locally. Register this application in Azure AD to acquire an access token for users to sign in with Azure AD.
- **Configure and test the admin consent workflow** - Sign in to the Azure portal and enable admin consent workflow. Add designated reviewers to review consent requests.
- **Review admin consent request** - Designated reviewer signs in to the Azure portal to view and act on the pending admin consent requests.

## What is the main goal?

Upon completion of this module. the learner will be able configure a workflow that enables users to request admin consent when they're unable to consent to the application's permissions. The workflow enables designated reviewers to view and act on the request from a single location in the Azure portal.
