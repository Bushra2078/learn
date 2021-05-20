In this module, you've learned how you can use self-service password reset (SSPR) in Azure Active Directory (Azure AD) to allow users to reset their forgotten or expired passwords. An administrator doesn't have to do the password reset. SSPR is secured by authentication methods of your choice. These methods can include a mobile authentication app, a code sent to you by an SMS text message, or security questions. 

SSPR helps reduce the amount of work required from administrators. It also minimizes the productivity impact for users when they forget their password.

## Clean up

Remember to clean up after you've finished.

- Delete the user you created in Azure AD. Go to **Azure Active Directory** > **Manage** > **Users**. Select the user, and select **Delete user**.
- Turn off self-service password reset. Go to **Azure Active Directory** > **Manage** > **Password reset**. Under **Self service password reset enabled**, select **None**.

If you created a Premium trial Azure AD tenant for this module, you can delete the tenant 30 days after the trial has expired.

## Learn more

- [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr)
- [How it works: Azure AD self-service password reset](/azure/active-directory/authentication/concept-sspr-howitworks)
- [Deploy Azure AD self-service password reset](/azure/active-directory/authentication/howto-sspr-deployment)