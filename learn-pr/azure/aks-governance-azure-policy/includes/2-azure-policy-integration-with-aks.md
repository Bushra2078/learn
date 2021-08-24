Azure Policy is an Azure service that helps you manage your compliance state across different Azure service. Azure Policy for Kubernetes enables you to use the same Azure policies in your Kubernetes clusters as well. This allows you to manage the compliance state of Kubernetes resources like pods, deployments and services as if they were an Azure resource.

In this unit, you'll learn about Azure Policy and Azure Policy for Kubernetes.

## Introducing Azure Policy

Azure policy allows you to manage the compliance state of your Azure services. It does this by comparing the state of your Azure resources to business rules you define. Common rules are the limitation of certain regions, the requirement for resource tags or limiting which Azure services can be used.

The way you define these business rules in Azure policy is by using policy definitions. There are many built-in policies that cover a range of common scenarios. If one of the built-in policies doesn't meet your needs, you can also define a custom policy using a JSON-based language. You can also group multiple policy definitions togethers into an initiative.

In a policy definition you define a resource compliance condition and the effect that should be taken if that condition is met. A condition compares a resource's properties to a required value. An example of a condition could be comparing the location of a resource versus a predefined list of allowed locations. The effect of a policy can be auditing the condition, denying the resource's creation or modifying the created resource. In the example of the location of a resource, you could for example deny the creation of resources not in the list of allowed locations. For a more detailed explanation of policy definitions, please refer to the [documentation](https://docs.microsoft.com/azure/governance/policy/concepts/definition-structure).

Azure Policy works by assigning a policy definition or an initiative to a scope by making policy assignments. A scope can be either a management group, a subscription or a resource group. Policy assignments are automatically inherited to all scopes underneath the assignment, unless you make an exclusion. Multiple policy definitions can apply to a certain scope. The net result of layering policy definitions is considered to be _cumulative most restrictive_. This means that if multiple policies apply to a certain resource, that resource will only be compliant if all policy definitions applying to it are compliant.

Policy assignments get evaluated during the creation or update of Azure resources, if the definition or scope is changed and periodically (every 24 hours) for continuous monitoring. Practically, this means that when you create new resources the policy will immediately take effect. Any historical resources will also be scanned, so you get a continuous view on the compliance of all your resources.

### Integration of Azure Policy with AKS

There are two ways in which Azure Policy integrates with AKS. There is a set of policies that enforce compliance on the Azure control plane for AKS, and there is another set of policies that enforces compliance on the workload running in your cluster. The first set of policies is focused more on cluster design itself, whereas the second set of policies is focused on workload design.

An example of the set of policies focused on the Azure control plane for AKS is the policy to [enforce the use of private clusters](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/AKS_PrivateCluster_Deny.json). This policy evaluates whether or not an AKS cluster is using the private cluster functionality. This is a configuration on the Azure API, controlling the design of the cluster itself.

An example of the set of policies focused on the workload running in your cluster is the policy to [enforce the use of allowed images](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Kubernetes/ContainerAllowedImages.json). This policy evaluates whether a pod definition in Kubernetes uses an image matching a certain regular expression. This is a configuration within the cluster itself, and doesn't interact with the Azure API.

The first set of policies works against the Azure API itself. The second set of policies interacts with the Kubernetes API. To achieve this, you will need to setup the [Azure Policy add-on for AKS](https://docs.microsoft.com/azure/aks/use-azure-policy) on your AKS clusters.

The Azure Policy add-on for AKS uses a number of components under the covers, which will be explained in the next section. 

### Understanding how Azure Policy for AKS works under the covers

To enforce policies on top of the Kubernetes API, Azure Policy for Kubernetes makes use of a number of tools: namely admission webhooks, Open Policy Agent (OPA), GateKeeper and finally an Azure Policy pod.

At the lowest Azure Policy leverages [admission webhooks](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) in Kubernetes. Admission webhooks are a built-in functionality of the Kubernetes API. They allow the Kubernetes API to call an external webhook to validate if a request to create, delete, modify or connect to a resource should be allowed or denied (ValidatingAdmissionWebhook) or if the request should be changed (MutatingAdmissionWebhook).

[Open Policy Agent (OPA)](https://www.openpolicyagent.org/) is an open source policy engine. OPA provides a high-level language to define policies in. You can use OPA to enforce policies in your own microservices, in CI/CD pipelines and in Kubernetes. Azure policy for Kubernetes translates Azure policies into the OPA language to be deployed on your Kubernetes cluster.

[OPA gatekeeper](https://www.openpolicyagent.org/docs/latest/kubernetes-introduction/) is a Kubernetes specific implementation of OPA that integrates with the Kubernetes API. It integrates with the admission webhooks introduced earlier. Rather than having to deploy your own webhook handlers, you can leverage OPA gatekeeper to service the admission webhook responses. Azure Policy for Kubernetes deploys OPA Gatekeeper on your Kubernetes cluster to achieve this functionality.

