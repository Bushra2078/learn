Imagine you're a software developer for an online retailer named *:::no-loc text="eShopOnContainers":::*. The retailer's online storefront is a cloud-native, microservices-based ASP.NET Core app. Management has asked you to enhance the team's agile development practices by implementing a **C**ontinuous **I**ntegration and **C**ontinuous **D**eployment (CI/CD) pipeline. CI/CD is the practice of using automation to build, test, configure, and deploy from the build environment through all environments.

You've decided to implement [GitHub Actions](https://help.github.com/actions/getting-started-with-github-actions/about-github-actions) to fulfill the requirement.

This module guides you through the process of implementing a CI/CD pipeline using GitHub Actions. You'll begin with a simplified, revamped version of [:::no-loc text="eShopOnContainers":::](https://github.com/dotnet-architecture/eShopOnContainers)&mdash;the companion reference app for the guide [.NET Microservices: Architecture for Containerized .NET Applications](/dotnet/architecture/microservices). This new reference app version includes a discount coupon feature that can be used at checkout time in the shopping basket.

[!INCLUDE[Use your own Azure subscription](../../includes/microservices/your-own-az-subscription.md)]

## Learning objectives

In this module, you will:

- Create an Azure service principal to authenticate GitHub Actions to a container registry.
- Securely store sensitive information used by the GitHub Actions.
- Implement a GitHub Action to build the container image for a microservice.
- Modify and commit the microservice code to trigger a build.
- Implement a GitHub Action to deploy a container to a Kubernetes cluster.
- Modify and commit a Helm chart to trigger a deployment.
- Revert the microservice to a previous deployment.

## Prerequisites

- Conceptual knowledge of DevOps practices at the beginner level
- Conceptual knowledge of containers and AKS at the beginner level
- Access to an Azure subscription with **Owner** privilege
- Access to a GitHub account
