Identifying threats inside your organization and their potential impact - whether a compromised entity or a malicious insider - has always been a time-consuming and labor-intensive process. Sifting through alerts, connecting the dots, and active hunting all add up to massive amounts of time and effort expended with minimal returns and the possibility of sophisticated threats evading discovery. Elusive threats like zero-day, targeted, and advanced persistent threats can be the most dangerous to your organization, making their detection all the more critical.

The UEBA capability in Microsoft Sentinel eliminates the drudgery from your analysts’ workloads and the uncertainty from their efforts, and delivers high-fidelity, actionable intelligence, so they can focus on investigation and remediation.

As Microsoft Sentinel collects logs and alerts from all of its connected data sources, it analyzes them and builds baseline behavioral profiles of your organization’s entities (users, hosts, IP addresses, applications etc.) across time and peer group horizon. Using various techniques and machine learning capabilities, Sentinel can then identify anomalous activity and help you determine if an asset has been compromised. Not only that, but it can also figure out the relative sensitivity of particular assets, identify peer groups of assets, and evaluate the potential impact of any given compromised asset (its “blast radius”). Armed with this information, you can effectively prioritize your investigation and incident handling.

### Architecture overview

:::image type="content" source="../media/entity-behavior-1.png" alt-text="EUBA architecture":::

### Security-driven analytics

Inspired by Gartner’s paradigm for UEBA solutions, Microsoft Sentinel provides an "outside-in" approach, based on three frames of reference:

**Use cases:** By prioritizing for relevant attack vectors and scenarios based on security research aligned with the MITRE ATT&CK framework of tactics, techniques, and subtechniques that put various entities as victims, perpetrators, or pivot points in the kill chain; Microsoft Sentinel focuses specifically on the most valuable logs each data source can provide.

**Data Sources:** While first and foremost supporting Azure data sources, Microsoft Sentinel thoughtfully selects third-party data sources to provide data that matches our threat scenarios.

**Analytics:** Using various machine learning (ML) algorithms, Microsoft Sentinel identifies anomalous activities and presents evidence clearly and concisely in the form of contextual enrichments, some examples of which appear below.

:::image type="content" source="../media/entity-behavior-2.png" alt-text="Security Driven Analytics":::

Microsoft Sentinel presents artifacts that help your security analysts get a clear understanding of anomalous activities in context, and in comparison with the user's baseline profile. Actions performed by a user (or a host, or an address) are evaluated contextually, where a "true" outcome indicates an identified anomaly:

- Across geographical locations, devices, and environments.

- Across time and frequency horizons (compared to user's own history).

- As compared to peers' behavior.

- As compared to organization's behavior.

:::image type="content" source="../media/entity-behavior-3.png" alt-text="EUBA Context image":::

### Scoring

Each activity is scored with “Investigation Priority Score”, which determines the probability of a specific user performing a specific activity based on behavioral learning of the user and their peers. Activities identified as the most abnormal receive the highest scores (on a scale of 0-10).

