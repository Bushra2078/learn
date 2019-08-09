The Tailspin team is feeling good. Their CD pipeline has really sped up their release process. Both Tim and Amita are happy about having automated tests that make their jobs easier. In general, they're seeing fewer delays and fewer bugs. But there is, as always, a problem. Let's drop in on their team meeting, where Tim is talking.

**Tim:** It's so hard to keep everyone happy. Irwin thinks it takes too long to get new features out to users. I can't do anything until management approves the release and, right now, there's no smooth way to roll it out once they give the okay. Not only does it take a long time but it's messy, it's manual, and there's down time. The whole process can take five days. I know that's too long but what am I supposed to do?" He takes a big gulp of coffee. "Maybe if I just drink more of this the solution will come to me.

**Andy:** Coffee is essential to all effective problem solving, no doubt. I also think that what we're talking about is called a *deployment pattern*.

A deployment pattern is an automated way to do the cut-over, where we move the software from the final testing stage to live production. Picking the right pattern definitely addresses your problems, like minimizing down time. Another advantage is that a deployment pattern would give us a chance to run tests that should really happen in production.

Here are the possibilities that Azure DevOps gives us:

*He starts writing on the white board.*

* Blue-Green deployment
* Canary releases
* Feature toggles
* Dark launches
* A/B testing
* Progressive exposure deployment

## Blue-green deployments

A blue-green deployment reduces risk and downtime by running two identical environments. These environments are called blue and green. At any time, only one of the environments is live. Let's say blue is live. As we prepare a new release, we would do our final tests in the green environment. Once the software is working in the green environment, we would just switch the router so that all incoming requests go to the green environment. Blue-green deployment also gives us a fast way to do a rollback. If anything goes wrong we simply switch the router back to the blue environment.

![Diagram of applications swapping IP addresses](../media/2-blue-green-deployment.png)

## Canary releases

A canary release is a way to identify potential problems as soon as possible without exposing all our users to the issue at once. The idea is that we would expose a new feature only to a small subset of users before making it available to everyone. We would monitor what happens when we release the the feature. If the canary release has problems, we can apply a fix. After the canary release is known to be stable, we can move it to the actual production environment.

![Diagram of load balancer sending some traffic to a canary version](../media/2-canary-deployment.png)

## Feature toggles

Feature toggles let us "flip a switch” at runtime. We can deploy new software without exposing any other new or changed functionality to our users. Mara and I would build new features behind a toggle. When a release occurs, the feature is “off” so it's not impacting the production software. Depending on how we configure the toggle, we can flip the switch to "on" and expose it how we want. For example, we could expose it to a small, select number of users to see how they react. We could expose it to a random sample of users. We could simply let it go live to everyone. Also, I'm not sure if this isn't more of a convenience for Mara and me. The big advantage to feature toggles is that it helps us avoid too much branching. Merging branches can be painful.

![Diagram of coded if statement for on or off feature](../media/2-feature-toggles.png)

## Dark launches

A dark launch is similar to a canary release or switching a feature toggle. Rather than expose a new feature to everyone, we would release it to a small set of users. Those users don't know they're being used as test users and we wouldn't even highlight the new feature to them. That's why it's a dark launch. The Software is gradually or unobtrusively released to users so we can get feedback and test performance.

![Diagram of load balancer sending some traffic to the new feature](../media/2-dark-launches.png)

## A/B testing

A/B testing compares two versions of a webpage or app against each other to determine which one performs better. A/B testing is like an experiment we would run. We would show two or more variations of a page to users at random,and then use statistical analysis to decide which variation performs better for our goals.

![Diagram of two apps and the analytics](../media/2-a-b-testing.png)

## Progressive exposure deployment

Progressive exposure deployment is sometimes called ring-based deployment. It's another way of limiting the impact changes have on users while making sure those changes are valid in a production environment. Rings are basically an extension of the canary stage. The canary release releases to a stage to measure impact. Adding another ring is essentially the same thing. With a ring-based deployment, we would deploy changes to risk-tolerant customers first, and then progressively roll out to a larger set of customers.

![Diagram of a progression of larger groups](../media/2-progressive-exposure-deployment.png)

## Implementing the Blue-Green deployment

Andy looks at Tim.

**Andy:** That's a lot, I know. Do you want to take some time to think about it, or you and I could...

**Tim:** Blue-green

Everyone in the room laughs.

**Mara:** Is that the coffee talking?

**Tim:** Feature toggles involve a change in how you and Andy work. Let's do one thing at a time. The methods that gradually expose a feature require statistical analysis or feature toggles. A blue-green deployment is something I can control. Switching a router is straightforward. It's easy and it sounds safe. This way management has an environment to evaluate. Then when they give the okay, we can easily switch. Let's start there.

So the question is, how do we do this with our pipeline?

### What is a deployment slot

**Andy:** Since we're using Azure App Service, we can take advantage of its *deployment slots*. Deployment slots are running apps that have their own host names.

We can create a slot for the *blue* environment and one for the *green* environment. We'll call them *Staging* and *Production*.

This way we can deploy new features without any downtime. We could swap an application and its configuration between the two deployment slots. Basically we'd be swapping the IP addresses of the two slots.

**Tim:** I like that!

**Andy:** Great! Tim and I will work on getting this implemented and we can all meet later to show it to everyone.
