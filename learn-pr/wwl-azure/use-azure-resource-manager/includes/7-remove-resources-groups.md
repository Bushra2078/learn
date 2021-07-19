Use caution when deleting a resource group. Deleting a resource group deletes all the resources contained within it. That resource group might contain resources that resources in other resource groups depend on.

:::image type="content" source="../media/remove-resource-groups-2.png" alt-text="Screenshot showing the Delete resource group button (highlighted) in the portal.":::


## Using PowerShell to delete resource groups

To remove a resource group use, **Remove-AzResourceGroup**. In this example, we are removing the ContosoRG01 resource group from the subscription. The cmdlet prompts you for confirmation and returns no output.

```
Remove-AzResourceGroup -Name "ContosoRG01"
```

## Removing Resources

You can also delete individual resources within a resource group. For example, here we are deleting a virtual network. Notice you can change the resource group on this page.

:::image type="content" source="../media/remove-resource-groups-3.png" alt-text="Screenshot from the portal of the route table page, with the Delete button highlighted to show you can delete an individual resource within a resource group.":::
