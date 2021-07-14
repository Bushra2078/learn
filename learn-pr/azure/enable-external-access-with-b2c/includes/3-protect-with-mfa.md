It's important to secure your healthcare application as much as possible. The application deals with sensitive information about patients and their health. Make sure this sensitive data is never exposed inappropriately. To do that, add a second layer of security to the healthcare application by enabling multi-factor authentication for users.

In this unit, you'll learn about multi-factor authentication. You'll also see how to enable and disable it for your Azure Active Directory B2C (Azure AD B2C) application.

## Multi-factor authentication

You can add another authentication layer to secure your data and applications.

Before you allow access to the application, use multi-factor authentication to have the user complete additional challenges. These challenges fit into three general categories:

- Something the user knows
- Something the user owns
- Something the user is

  ![MFA challenges.](../media/3-mfa-challenges.svg)

A secret password or a secret answer to a security question should be something that only the user *knows*. Users also have devices that can be classified as something they *own*. For example, a user with a mobile phone would receive a text message on that phone with a secret code for one-time use. You could also make successful authentication contingent on the user by using biometrics. Biometric information is something the user *is*. For example, you could make authentication rely on the user's fingerprint or voice.

Different forms of second-factor methods are supported in Azure. They include:

- A mobile application, such as Microsoft Authenticator, on which the user receives a uniquely generated one-time code.
- A phone call in which the user receives a one-time code.
- A text message in which the user receives a one-time code.

Use these different methods to accommodate your users' needs. For example, for accessibility reasons, some users might prefer to receive a phone call rather than a text message.

## Enable multi-factor authentication

You enable multi-factor authentication for your Azure AD B2C application by using the Azure portal. When you create user sign-in and sign-up flows, you enable multi-factor authentication by turning on a toggle. If necessary, use the same toggle to disable multi-factor authentication in your flow.

![Enable MFA in user flow.](../media/3-enable-mfa-user-flow.png)
