
You started by learning about the benefits of knowing beforehand about what would be deployed. This pre-knowledge helps with concerns like, for example,  if a new deploy would break the existing setup. It's also a good mental check to see if what you intend to happen is actually what will happen. You've furthermore learned that the *What-If* script is the tool that will help you address the above concerns.

You were then introduced to ARM template test toolkit. The testing toolkit validates your deployment templates by comparing them to tried and tested, best practices and indicates where you are in *violation*. It's worth pointing out that the ARM template test toolkit is not something you *must* abide by but is merely recommendations.

Finally you've learned how to implement domain-specific rules by authoring and running custom tests for the ARM template test toolkit tool.

In summary, you should now have a good overall understanding of what scripts and tools can help you during the development process of your deployment templates.

## Additional resources

- Read more on **what-if** command at the official [What-If](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-deploy-what-if?tabs=azure-powershell?azure-portal=true)
- Read more on the different test cases the toolkit is testing [Test cases](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-cases?azure-portal=true)
- Docs on [Deployment modes](https://docs.microsoft.com/azure/azure-resource-manager/templates/deployment-modes?azure-portal=true)
- Visual Studio Code [Integrated terminal](https://code.visualstudio.com/docs/editor/integrated-terminal?azure-portal=true)
- Azure CLI command [az configure](https://docs.microsoft.com/cli/azure/azure-cli-configuration?view=azure-cli-latest&azure-portal=true)
- Installing [PowerShell Core](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit?azure-portal=true)
- Docs on the [Test toolkit](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/test-toolkit?azure-portal=true)
- The testing toolkit GitHub repository [ARM template test toolkit](https://aka.ms/arm-ttk-latest?azure-portal=true)
