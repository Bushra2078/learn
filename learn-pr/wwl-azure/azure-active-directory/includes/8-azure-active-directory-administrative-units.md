
An administrative unit is an Azure AD resource that can be a container for other Azure AD resources. An administrative unit can contain only users and groups. Administrative units restrict permissions in a role to any portion of your organization that you define. You could, for example, use administrative units to delegate the Helpdesk Administrator role to regional support specialists, so they can manage users only in the region that they support.

> [!NOTE]
> To use administrative units, you need an Azure Active Directory Premium license for each administrative unit admin, and Azure Active Directory Free licenses for administrative unit members.

![Screenshot of the Administratrive Units user interface in Azure AD.  Shows that you can Add Users, Groups, and Set up Roles for your Administrative Unit.](../media/administrative-units-dialog.png)

## Available roles

| Role | Description |
| :--- | :--- |
| Authentication Administrator | Has access to view, set, and reset authentication method information for any non-admin user in the assigned administrative unit only. |
| Groups Administrator | Can manage all aspects of groups and groups settings, such as naming and expiration policies, in the assigned administrative unit only. |
| Helpdesk Administrator | Can reset passwords for non-administrators and Helpdesk administrators in the assigned administrative unit only. |
| License Administrator | Can assign, remove, and update license assignments within the administrative unit only. |
| Password Administrator | Can reset passwords for non-administrators and Password Administrators within the assigned administrative unit only. |
| User Administrator | Can manage all aspects of users and groups, including resetting passwords for limited admins within the assigned administrative unit only. |
