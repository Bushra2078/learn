Your shopping list web app needs a way to uniquely identify its users, and provide them a personal space to store the products.

Authentication is way to verify the identity of an user that is trying to access an information system. We'll now look into authentication and how you can implement it in Azure Static Web Apps.

## Identity providers

Azure Static Web Apps streamlines the authentication experience by managing authentication with the following providers:

- Azure Active Directory
- GitHub
- Facebook
- Google
- Twitter

All authentication providers are enabled by default. We'll see later how you can restrict an authentication provider with a custom route rule.

## System folder

The `/.auth` system folder provides access to all authentication-related APIs. You can use these endpoints to implement a full authentication workflow in your app, including logging in and out, and accessing user information.

### Login

The following table lists the provider-specific login route you can use in your app.

| Identity provider      | Login route             |
|------------------------|-------------------------|
| Azure Active Directory | `/.auth/login/aad`      |
| Facebook               | `/.auth/login/facebook` |
| GitHub                 | `/.auth/login/github`   |
| Google                 | `/.auth/login/google`   |
| Twitter                | `/.auth/login/twitter`  |

For example, to login with GitHub you can include a login link in your web app with the following snippet:

```html
<a href="/.auth/login/github">Login</a>
```

If you want an user to return to a specific page after login, you can also provide an URL in `post_login_redirect_uri` query string parameter, for example:

```html
<a href="/.auth/login/github?post_login_redirect_uri=/products">Login</a>
```

### Logout

The `/.auth/logout` route logs users out from the web app. You can add a link to your site navigation to allow the user to log out as shown in the following example.

```html
<a href="/.auth/logout">Log out</a>
```

Like with login, you can can provide an URL to redirect to after logging out using the `post_logout_redirect_uri` query string parameter:

```html
<a href="/.auth/logout?post_logout_redirect_uri=/home">Log out</a>
```

## Access user information

You can access authentication-related user information either via a direct-access endpoint or a special header in API functions.

If you send a `GET` request to the `/.auth/me` route, you'll receive a JSON object with the data for the currently logged in user. Requests from unauthenticated users returns `null`.

The following example is a example response object:

```json
{
  "identityProvider": "github",
  "userId": "d75b260a64504067bfc5b2905e3b8182",
  "userDetails": "github-user-example",
  "userRoles": [ "anonymous", "authenticated" ]
}
```

### API functions

All API functions available in Azure Static Web Apps have access to the same user information as your client application. The user data is passer to functions in the `x-ms-client-principal` HTTP header. The data is serialized as a JSON object and encoded in [Base64](https://www.wikipedia.org/wiki/Base64).

The following example function shows how to read and return user information.

```javascript
module.exports = async function (context, req) {
  const header = req.headers["x-ms-client-principal"];
  const encoded = Buffer.from(header, "base64");
  const decoded = encoded.toString("ascii");

  context.res = {
    body: {
      userInfo: JSON.parse(decoded)
    }
  };
};
```

## Next steps

Next we'll implement a complete authentication workflow in our app.
