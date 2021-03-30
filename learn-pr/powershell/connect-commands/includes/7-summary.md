In this module, you started by learning what a pipeline is. 

A pipeline is set of commands connected by the pipe (`|`) character. The idea is to have the output of one command serve as the input to the next command.

As part of constructing the pipeline, you learned that you first need to evaluate whether a command fits and can be added as the next command in the pipeline. A command fits if its returning output matches the input that's needed for the next command in turn.

The `Get-Help` command helps you inspect the command, and the INPUT and PARAMETERS sections can help you understand what types of input a command accepts. For pipeline input, you need to find parameters that have a property `Accept pipeline input?` set to _True_. 

There's also an evaluation order that reveals how the input is analyzed for validity. There are two main ways that an input can be considered _valid_. The first way is called _By value_, which means that the input matches an array to a specific type. The second way, _By property name_, means that whatever type of object is passed in, it needs to have a property with this particular name.

Finally, you learned about filtering and formatting. The _filtering left_ concept is important because it dictates that you should filter as close to the data source as possible. That is, it should be input as far left, or early, in the statement as possible. It's especially important when you work on large data stores and you need data to be returned over the network. _Formatting right_ means that any output formatting should happen as late as possible. That is, the formatting should be input as far right in the statement as possible.

## Additional resources

- [About pipelines](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_pipelines?view=powershell-7.1&WT.mc_id=academic-16634-chnoring&preserve-view=true)
- [What is a pipeline?](https://docs.microsoft.com/powershell/scripting/learn/ps101/04-pipelines?view=powershell-7.1#the-pipeline&WT.mc_id=academic-16634-chnoring&preserve-view=true)
- [Filtering left](https://docs.microsoft.com/powershell/scripting/learn/ps101/04-pipelines?view=powershell-7.1#filtering-left&WT.mc_id=academic-16634-chnoring&preserve-view=true)
- [Formatting right](https://docs.microsoft.com/powershell/scripting/learn/ps101/05-formatting-aliases-providers-comparison?view=powershell-7.1#format-right&WT.mc_id=academic-16634-chnoring&preserve-view=true)
- [Where-Object command in detail](https://docs.microsoft.com/powershell/scripting/samples/removing-objects-from-the-pipeline--where-object-?view=powershell-7.1&WT.mc_id=academic-16634-chnoring&preserve-view=true)
- [Use Format commands](https://docs.microsoft.com/powershell/scripting/samples/using-format-commands-to-change-output-view?view=powershell-7.1&WT.mc_id=academic-16634-chnoring&preserve-view=true)