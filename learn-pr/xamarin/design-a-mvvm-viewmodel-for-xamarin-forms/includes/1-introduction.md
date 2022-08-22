> [!NOTE]
> This Learn Module is for Xamarin. If you're looking for Learn Modules on .NET MAUI, [please go here](/learn/browse/?expanded=dotnet&products=dotnet-maui).

The Model-View-ViewModel (MVVM) pattern is a *software design pattern*. Design patterns are sets of rules and templates that help make application code better or more consistent. You use the MVVM pattern to help separate the app's behavior logic from the user interface-rendering code, and to do so in a way that supports unit testing.

Say your company produces management software for human resources departments. They use the software to manage and review details about the employees of the company. The existing system is web-based. You were asked to create a mobile app that can be used with the same back-end APIs that the web system uses. You know that the back-end APIs and the web front end are thoroughly covered by unit tests. And you want to maintain that standard for the mobile app. You heard that the MVVM pattern can help design mobile apps for maximum testability, so you plan to try it out.

MVVM itself is a design pattern that's the basis for many frameworks and programming tool-kits. Most of those frameworks also provide other things, like navigation and messaging abstractions, that help MVVM promote unit testing. We'll concentrate on the basics of the pattern in this discussion because frameworks can widely vary in their implementations.

In this module, we'll learn the parts of the MVVM pattern and the responsibilities of the model, view, and viewmodel. We'll then write code in a viewmodel to handle application behavior in a way that's isolated from the UI libraries (even from Xamarin.Forms itself).


[!include[](../../../includes/install-vs-mobile-workload.md)]

## Learning objectives

In this module, you will:

- Identify when to use the Model-View-ViewModel pattern
- Use a viewmodel to drive visual behavior
- Improve code testability through data-bindable properties

## Prerequisites

[!include[](../../../includes/prerequisites.md)]
