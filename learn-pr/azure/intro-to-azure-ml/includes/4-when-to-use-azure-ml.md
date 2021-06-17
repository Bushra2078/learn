Azure ML’s versatility and ease of use mean that new applications are always being discovered by users. Here we will explore some of the strengths of Azure ML in practice, so you can utilize these functions in your next application or scenario.

## Working in a team

Collaborative work within Azure ML is possible by adding multiple users to a Workspace. If you require more precise control, _Azure Roll Based Access Control (RBAC)_ can be used to equip team members with roles to define their access and control of resources within the Workspace. Once team members have access, they may contribute to data labeling projects or work jointly to add and clean data or train and deploy models.

Users can also work collectively with in-built Jupyter Notebooks to share ideas and code. Each member's edits and contributions are logged in the Notebook, and a complete revision history is kept. The Notebooks also allow simultaneous access—so multiple members can discuss and edit together while following changes by collaborators.

## MLOps

Azure ML usesMLOps principles to manage and accelerate the life cycle of your models—while improving the quality of your machine learning solutions. These principles are useful whatever your teams’ size as they can drastically reduce the time from training to deployment—and highlight issues within your dataset and models. Once your models are deployed, you can then easily monitor machine learning applications for operational and ML-related issues—including your machine learning infrastructure. By using these tools, you can ensure your models performance remains consistent, and your applications are stable.

## Responsible ML

Azure ML’s features and supported tools enhance intelligibility and oversight of your models—so you can build responsible AI solutions. Model transparency is achieved through the SDK’s interpretability tools—highlighting significant features or metrics that may affect system behavior. Management of model life-cycle events can be conducted in several ways. Azure ML Studio provides intuitive data visualization, while logs and metrics can be tracked and viewed through the Azure Portal, SDK, and CLI extension. If you wish for more detailed logging and monitoring, Azure Monitor, Mlflow, and other services can be integrated to provide in-depth tools to monitor and analyze model training.

Azure ML also helps safeguard people and their data by integrating differential privacy tools such as SmartNoise to protect sensitive data and avoid leaks. Azure ML also supports Microsoft SEAL encryption to maintain the confidentiality of private information—even from teams using the data. MLOps features also deliver more control of the end-to-end ML life cycle with governance data logging and tools—and a robust security framework

![glass box ml](../media/4-transparency.gif)

## Ongoing predictions and forecasting

The wide array of algorithms and their potential uses means that almost every industry can deploy models that will help boost productivity or shine a light on new customers and better serve existing ones. The most used algorithms are regression, classification, and time-series forecasting. These can predict target categories, find unusual data points, predict values, and discover similarities. Modeling data can help businesses find their next store location or locate areas within a factory that likely require maintenance before trouble arises. In our daily lives, weather reporting relies heavily on these models to predict the coming weather or the path of storm systems, allowing people to prepare. With Azure ML, these different models can be created quickly, but if you are unsure which is suitable for your data, AutoML can be used to test, train, and suggest the most appropriate model for your data.

## Integration with other Azure services

Azure ML integrates with many Azure services and tools to fulfill your specific requirements. For deployment of models, Azure Container Registry and Azure Container Instances are great solutions for rapid creation and management of models that can operate in isolated containers, including simple applications, task automation, and build jobs. For deeper event logs and monitoring, Azure ML can connect to Azure Monitor for a complete monitoring service capable of deep diagnostics and troubleshooting within your datasets and deployed models, telling you how it’s performing and the resources it’s consuming.

Azure Event Grid is an event ingestion service that can alert and automate responses to changes in the systems it’s monitoring. It can be used if you require extended or automated handling of pipeline workflows or managing events within deployed models. Users can produce reactive applications that can respond or alert you to changes within the underlying model. This feature can be especially helpful if you wish to trigger a pipeline when data drift is detected or alert you via email when an event occurs.