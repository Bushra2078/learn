Your users can use the My Apps portal to view and start the cloud-based applications they have access to. By default, all the applications a user can access are listed together on a single page. To better organize this page for your users, if you have a Microsoft Entra ID P1 or P2 license you can set up collections. With a collection, you can group together applications that are related (for example, by job role, task, or project) and display them on a separate tab. A collection essentially applies a filter to the applications a user can already access, so the user sees only those applications in the collection that have been assigned to them.

## Create and admin application collection

Admin collections are managed through the Azure portal. For example, if you assign users or groups as an owner, then they can only manage the collection through the Azure portal.

1. Open the Azure portal and sign in as an admin.
1. Go to **Microsoft Entra ID** then select **Enterprise Applications**.
1. Under **Manage**, select **App Launchers**.
1. Select **New collection**.
    
    
     -  In the New collection page, enter a Name for the collection (we recommend not using "collection" in the name. Then enter a Description.
1. Select the **Applications tab**. Select **+ Add application** to open the Add applications page.
    
    
     -  Select all the applications you want to add to the collection, or use the Search box to find applications.
1. When you're finished adding applications, select **Add**.
    
    
     -  The list of selected applications appears. You can use the arrows to change the order of applications in the list.
1. Select the **Owners tab**. Select **+ Add users and groups**, to open the Add users and groups page
1. Select the users or groups you want to assign ownership to.
1. When you're finished selecting users and groups, choose **Select**.
1. Select Review + Create. The properties for the new collection appear.

## My apps portal

You can also use the [My Apps](https://myapps.microsoft.com) portal (`https://myapps.microsoft.com`) to add app collections. My Apps is a web-based portal that is used for managing and launching applications in Microsoft Entra ID. To work with applications in My Apps, use an organizational account in Microsoft Entra ID and obtain access granted by the Microsoft Entra administrator. My Apps is separate from the Azure portal and doesn't require users to have an Azure subscription or Microsoft 365 subscription.

Users access the My Apps portal to:

 -  Discover applications to which they have access
 -  Request new applications that the organization supports for self-service
 -  Create personal collections of applications
 -  Manage access to applications

By default, all applications are listed together on a single page. Collections can be used to group together related applications and present them on a separate tab, making them easier to find. For example, use collections to create logical groupings of applications for specific job roles, tasks, projects, and so on. Every application to which a user has access appears in the default Apps collection, but a user can remove applications from the collection.

### Create a collection using the My Apps portal

Follow these steps to create a collection.

1. Open the **[My Apps](https://myapps.microsoft.com) portal**.
1. Select the ellipsis (...) on the apps screen.
1. Choose **Manage collections.**
1. Select **Create collection.**
1. Select the **+ Add apps** option to add all the apps you want in the collection.
1. After picking your apps, select the **Add selected apps** button.
1. Give the collection a name and choose **Create collection**.
