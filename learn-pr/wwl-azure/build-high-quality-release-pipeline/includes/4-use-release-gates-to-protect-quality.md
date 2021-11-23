A quality gate is the best way to enforce a quality policy in your organization.

It's there to answer one question: can I deliver my application to production or not?

A quality gate is located before a stage that is dependent on the outcome of a previous stage.

In the past, a quality gate was typically something that a QA department monitored.

They had several documents or guidelines, and they verified if the software was of a good enough quality to move on to the next stage.

When we think about Continuous Delivery, all manual processes are a potential bottleneck.

We need to reconsider the notion of quality gates and see how we can automate these checks as part of our release pipeline.

By using automatic approval using a release gate, you can automate the approval and validate your company's policy before moving on.

Many quality gates can be considered.

 -  No new blocker issues.
 -  Code coverage on new code greater than 80%.
 -  No license violations.
 -  No vulnerabilities in dependencies.
 -  No further technical debt was introduced.
 -  Compliance checks
    
     -  Are there work items linked to the release?
     -  Is the release started by someone else as the one who commits the code?
 -  Is the performance not affected after a new release?

Defining quality gates make the release process better, and you should always consider adding them.
