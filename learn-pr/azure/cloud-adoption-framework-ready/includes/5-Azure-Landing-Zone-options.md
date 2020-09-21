Azure landing zones provide cloud adoption teams with a well-managed environment for their workloads. Each of the following implementation options apply a predetermined set of landing zone design area considerations to provide an implementation and architecture to guide your environment configuration.

## Partner implementation options

Configuration of your cloud environment can be one of the biggest enables to cloud success. It can also be one of the biggest blockers, if the configuration is misaligned with how you want to operate workloads in the cloud. If the success of your adoption project is critical and your team is not sure how to proceed, you are advised to consult a partner.

Many of the top Microsoft partners provide offerings aligned to the Ready methodology of the Cloud Adoption Framework. Those offerings typically include the partners own customized Azure landing zone implementation option. [Find a partner](https://www.microsoft.com/azure/partners/adopt?filters=ready)

Before engaging a partner, review the guide to evaluating [partner implementation options for Azure landing zones](/azure/cloud-adoption-framework/ready/landing-zone/partner-landing-zone).

## Start small implementation options (best for central operations)

The following are implementation options to start small and expand. Each establishes a less complex initial implementation using Azure-native governance and operations tooling that can then be refactored to meet your needs.

- **CAF Migration landing zone blueprint:** Deploys the basic foundation for migrating low risk assets. Review the [design principles](./migrate-landing-zone.md#design-principles) or [deploy](./migrate-landing-zone.md) this solution to your Azure environment.
- **CAF Foundation blueprint:** Adds the minimum tools need to begin developing a governance strategy. Review the [design principles](./foundation-blueprint.md#design-principles) or [deploy](./foundation-blueprint.md) this solution to your Azure environment.
- **CAF Terraform modules:** Third-party path for multicloud operating models. This path can limit Azure-first operating models. Review the [design principles](./terraform-landing-zone.md#design-decisions) or [deploy](./terraform-landing-zone.md#customize-and-deploy-your-first-landing-zone) this solution to your Azure environment.

## Start with enterprise-scale implementation options (best for enterprise operations)

The following are implementation options to start with enterprise-scale. Each builds towards a more robust enterprise architecture.

- **CAF Enterprise-Scale foundation:** This is the suggested foundation for enterprise-scale adoption. Review the [example in GitHub](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/wingtip/README.md) or [deploy](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fwingtip%2FarmTemplates%2Fes-foundation.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fwingtip%2FarmTemplates%2Fportal-es-foundation.json) this solution to your Azure environment.
- **CAF Enterprise-Scale Virtual WAN:** Add a Virtual WAN network module to the enterprise-scale foundation. Review the [example in GitHub](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/contoso/Readme.md) or [deploy](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fcontoso%2FarmTemplates%2Fes-vwan.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fcontoso%2FarmTemplates%2Fportal-es-vwan.json) this solution to your Azure environment.
- **CAF Enterprise-Scale hub and spoke:** Add a Virtual WAN network module to the enterprise-scale foundation. Review the [example in GitHub](https://github.com/Azure/Enterprise-Scale/blob/main/docs/reference/adventureworks/README.md) or [deploy](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fes-hubspoke.json/createUIDefinitionUri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2FEnterprise-Scale%2Fmain%2Fdocs%2Freference%2Fadventureworks%2FarmTemplates%2Fportal-es-hubspoke.json) this solution to your Azure environment.
