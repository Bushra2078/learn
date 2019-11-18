Nice work! In this module, you learned how infrastructure as code enables you to describe the infrastructure that you need for your application. You also learned the difference between declarative and imperative code, as well as a few tools that you can use to automate your deployments.

Terraform is just one tool for automating your deployments. Terraform operations are idempotent. That means you can run Terraform as many times as you want without affecting infrastructure resources that haven't changed.

You can run Terraform locally or from Azure Cloud Shell to experiment and incrementally build out your infrastructure configuration. After you have the configuration, you can integrate automated provisioning in the pipeline. Maintaining your infrastructure code along with your application code gives you everything that you need to build, test, and deploy your application as a unit.

## Challenge

If you're looking for a challenge, see if you can modify the pipeline to provision infrastructure for all three deployment stages: _Dev_, _Test_, and _Staging_. See if you can modify it just like the release pipeline that you set up in the [Create a multi-stage pipeline with Azure Pipelines](/learn/modules/create-multi-stage-pipeline?azure-portal=true) module.

One approach might be to modify your Terraform plan to provision all three App Service environments. You can add a stage that runs after the _Build_ stage and that provisions all three App Service environments before you run your deployment stages. You can use the [for_each](https://www.terraform.io/docs/configuration/resources.html#for_each-multiple-resource-instances-defined-by-a-map-or-set-of-strings&azure-portal=true) syntax to provision all three App Service environments from a single block of code.

Another approach might be to use the same pattern that you used in this module. Here, you can specify a Terraform variable that defines the App Service name for the corresponding environment: **dev**, **test**, or **staging**. You'll also need a separate state file to manage each deployment. For example, you might name the state file for the *Dev* stage *terraform-dev.tfstate* instead of just *terraform.tfstate*.

As a bonus, you can map each App Service instance to an App Service plan that more closely matches your infrastructure requirements. For example, you might use the B1 Basic plan for your **dev** and **test** environments. The the B1 Basic plan is intended for apps that have lower traffic requirements. Then, you might use the Standard or Premium plan for your **staging** environment. The Standard and Premium plans are for production workloads, and the **staging** environment more closely matches your production environment.

## Learn more

In this module, you saw a few tools that you can use to automate your deployments. Here's more information about each option.

### Azure CLI

* [Control Azure services with the CLI](https://docs.microsoft.com/learn/modules/control-azure-services-with-cli/?azure-portal=true)
* [Azure CLI](https://docs.microsoft.com/cli/azure/?view=azure-cli-latest&azure-portal=true)

### Azure PowerShell

* [Automate Azure tasks using scripts with PowerShell](https://docs.microsoft.com/learn/modules/automate-azure-tasks-with-powershell/?azure-portal=true)
* [Azure PowerShell](https://docs.microsoft.com/powershell/azure/?azure-portal=true)

### Azure Resource Manager templates

* [Build Azure Resource Manager templates](https://docs.microsoft.com/learn/modules/build-azure-vm-templates/?azure-portal=true)
* [Control and organize Azure resources with Azure Resource Manager](https://docs.microsoft.com/learn/modules/control-and-organize-with-azure-resource-manager/?azure-portal=true)
* [Azure Resource Manager](https://docs.microsoft.com/azure/azure-resource-manager/?azure-portal=true)

### Ansible

* [Ansible](https://www.ansible.com/?azure-portal=true)
* [Ansible on Azure documentation](https://docs.microsoft.com/azure/ansible/?azure-portal=true)

### Terraform

* [Terraform](https://www.terraform.io/?azure-portal=true)
* [Terraform on Azure documentation](https://docs.microsoft.com/azure/terraform/?azure-portal=true)