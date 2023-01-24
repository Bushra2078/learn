Insecure design is a new entry on the OWASP Top 10 in 2021.
It's different from insecure implementation in that it has more to do with risks related to design and architectural flaws. A secure implementation might have an insecure design, which still renders an application vulnerable to attacks and exploits.​
Security should be not an afterthought - how you protect your system’s configuration secrets, handle customers data, leak implementation details during logging and so on​. An insecure design can not be fixed by a perfect implementation.​

You might be familiar with the term *'shift-left'*. It's often referred to testing your application early on during the application lifecycle to ensure hight quality (left being analysis and requirements phase, right being release and support phase). Shift-left also applies to security, even before we write the first line of code. A few activities could include threat modeling, following secure design patterns and principles, leveraging reference architectures and conducting security code reviews. ​

A few techniques that can address insecure design are:

- Least privilege​ principle - granting just enough permissions to a user or service to successfully perform an operation.
- Attack surface reduction​ - limit and control what's visible to external users
- Zero Trust​ principle - never trust, always verify explicitly
- Defense in Depth​ - layered and tiered security approach
- Threat Modeling​

Exercise ***assume breach*** mentality - minimize blast radius for breaches and prevent lateral movement by segmenting access by network, user, devices, and application awareness. Verify all sessions are encrypted end to end. Use analytics to get visibility, drive threat detection, and improve defenses. Always authenticate and authorize based on all available data points, including user identity, location, device health, service or workload, data classification, and anomalies.

Let's discuss the latest in more detail. Threat modeling is an essential part of DevSecOps because it informs your security design process and helps find vulnerabilities in your application. While it does fall under DevSecOps, it also sits neatly under education too.

:::image type="content" source="../media/tm-1.png" alt-text="Application logical components":::

Threat modeling is something that can be used to help mitigate that from the early stages of application design.
Whenever an application’s design or code is changed, you run the threat modeling process again to reflect the new state of the application and to identify any new threats that could have emerged from the changes. It’s an iterative process, performed throughout the software development lifecycle.

> [!IMPORTANT]
> Threat modeling is a process to understand security threats to a system, determine risks from those threats, and establish appropriate mitigations.

:::image type="content" source="../media/tm-2.png" alt-text="Data flow diagram with basic threat model":::

Making threat modeling part of the design phase of the application helps bake security into the design from the start, which is always going to be more effective that trying to tack it on at the end. But it’s not only useful at the design stage – it should be performed at every stage of the SDLC – requirements gathering; design; coding; testing; even deployment.
