This unit introduces you to basic elements of Azure Health Bot. Everything in the service can be built simply by dragging scenario elements onto a canvas. After you understand the practical use of each scenario, you can then design more complex applications. 

Let's start building a basic bot that can be deployed at the entrance of a hospital or healthcare organization to provide information about the offered services. In the introduction module to this learning path, we created a custom scenario. Let's continue from there.

## Ask what the user wants

Because our aim is to create an informative bot, let's first greet the user and take input on what the user wants to do. 

### Set up a prompt and branches

We start by using the *prompt* block. This is what a prompt block looks like:

:::image type="content" source="../media/3-prompt.png" alt-text="Screenshot that shows the fields in a prompt block.":::

The healthcare bot uses JavaScript to implement some scenario steps. So it helps to know basic concepts of JavaScript. If you don't know JavaScript, knowledge of any basic programming language will also help.  

**Display text**: Enter a block display name that will help you differentiate between the blocks. Because we're creating a greeting block, let's name it **Greeting**. 

**Variable name**: Because the healthcare bot uses some programming concepts, you need give the name of the variable to store the input from the user. A variable is simply a container that temporarily holds the data. The name is case sensitive.

**Variable Data Type**: Choose the type of data that you'll store in the variable. Important data types include string, number, Boolean, time, choice, multiple choice, attachment, and object. Because the help that we're providing to the user through the bot can have many options, select multiple choice (**multi-choice**).

**Choices Array**: As the name suggests, this is an array of choices or multiple choices. An array is a systematic collection of like objects. Provide the required choices.

**Show Choices as**: This is the way we want the GUI to look. Let's simply choose a button. Depending on the variable type, you'll need to change the upcoming boxes. The rest will be set to defaults.

:::image type="content" source="../media/3-greetings.png" alt-text="Screenshot that shows information for greetings.":::

After you fill in the information, close the pane. Congratulations! You've completed the first step. Now let's head to the next step.

After the user enters the data, we have to move according to those choices. That means we're branching from this point. So, which block will we use? You guessed it: the *branch* block. Let's drag a block onto the canvas.

**JavaScript Boolean Expression**:  This field recognizes the command. We know that the counting in a computer starts from 0 index. So 0 is the first position in the computer. If we choose the option 1 in the array, then it corresponds to the 0 index. We have to feed this with a simple line of code:

```javascript
scenario.help.index == 0
```

This is the way we call the objects:  

**Syntax**:  "[name].[variable name].[index] == [index position]"_

Because the first branch is for the first object of the array, we have to branch the first object to one side and the rest of the objects to the other side. That's why we've taken the 0 index. Note the usage of `==`  and not `=`. The single equal sign is for assigning a value. The double equal sign is to check the value.

This is how our first branch block should look:

:::image type="content" source="../media/3-first-branch.png" alt-text="Screenshot that shows a filled-in branch block.":::

Connect the prompt and branch blocks. The result should look something like this:

:::image type="content" source="../media/3-connected-blocks.png" alt-text="Screenshot that shows the basic bot with connected prompt and branch blocks.":::

## Display available services

We have two paths now:

* If the condition is true: *yes*
* If the condition is false: *no*

### Set up a prompt and a switch

Let's do the first (*yes*) path.

Because our first option said **Services**, if the user selects **Services**, we have to display the available services. After the user selects a service, we need to show just the data related to that. You're free to continue the process and make the bot even more interactive. But the scope of this unit is to just introduce you to the bot interface. So, we're keeping it simple.

We have to display the services to the user and take an input. Which block do we use? Yes, it's the prompt block again. Drag a prompt block and fill it in as shown in this example:

:::image type="content" source="../media/3-services-list.png" alt-text="Screenshot that shows a filled-in services list.":::

We've already gone through the parameter details.

Our example hospital offers many services, so there are multiple branchings now. In such cases, we use the *switch* block.

Drag the switch block to the canvas. It looks something like this:

:::image type="content" source="../media/3-switch.png" alt-text="Screenshot that shows a switch block.":::

This is like the classic switch case that we use in any programming language. If the option matches, then it flows through that. If it doesn't match, then it enters the default value.

:::image type="content" source="../media/3-switch-details.png" alt-text="Screenshot that shows switch details.":::

Fill in the switch details. The variable name goes in the brackets after the dollar (`$`) sign. The period (`.`) refers to the call. Then provide all the choices that we have in **Switch cases** boxes.

Connect the prompt and switch blocks as shown in this example:  

:::image type="content" source="../media/3-connect-services.png" alt-text="Screenshot that shows the basic bot with connected prompt and switch blocks.":::

## Display information about the service

Let's assume that the user selects any service. We can simply provide the information to the user. 

### Set up statements

Displaying information is basically giving an output. To do this, we use the *statement* block.

Drag a statement block onto the canvas. It should look something like this:

:::image type="content" source="../media/3-statement.png" alt-text="Screenshot that shows a statement block.":::

**Display text**:  This field is the information that we want to display to the user. Fill it in as shown in the following example and leave the rest as is.

:::image type="content" source="../media/3-pharmacy-statement.png" alt-text="Screenshot that shows filled-in display text about a pharmacy.":::

Select **OK** and then connect the statement block. The basic bot should now look similar to this:

:::image type="content" source="../media/3-connect-pharmacy.png" alt-text="Screenshot that shows the pharmacy statement block connected in the bot.":::

Fill in the other switch cases with statement blocks. The following example shows one for emergency and trauma: 

:::image type="content" source="../media/3-emergency-statement.png" alt-text="Screenshot that shows a statement for emergency and trauma.":::

After you fill in everything, the bot should look something like this:

:::image type="content" source="../media/3-connected-all-services.png" alt-text="Screenshot that shows the basic bot with several statements connected.":::

### Set up another branch

Let's go back to the first branching that we set up. If the user chooses the other option instead of the services, it's the *no* path.

The next thing we had in the list was the departments and more information. Let's configure the bot for the next branching.

We know that the *yes* path refers to the department selection, and the *no* path refers to the selection of more information. This is unlike the previous step, where we had two options inside the *no* path. The bot is directly branching here, so drag a branch block and configure it as follows:

:::image type="content" source="../media/3-departments.png" alt-text="Screenshot that shows the Boolean expression entered for departments.":::

Then connect the branch block as follows:

:::image type="content" source="../media/3-connect-departments.png" alt-text="Screenshot that shows the basic bot with a connected branch for departments.":::

### Set up a switch and statement for departments

For the departments, follow the same steps that we used for the services with the switch case. It should look like this:

:::image type="content" source="../media/3-departments-details.png" alt-text="Screenshot that shows department details.":::

Drag the switch block and configure it as follows:

:::image type="content" source="../media/3-departments-switch.png" alt-text="Screenshot that shows filled-in switch cases for departments.":::

Add the statement blocks as we did previously:

:::image type="content" source="../media/3-cardiologist.png" alt-text="Screenshot that shows a statement block for cardiologist.":::

Because the choice of more information is just a simple statement that we want to display, let's use a statement block. Finally, the bot should look something like this:

:::image type="content" source="../media/3-connected-all-departments.png" alt-text="Screenshot that shows the simple bot with department options connected.":::

Congratulations! You've completed the bot. Now save and run it. The [Web Chat v4 component](https://github.com/microsoft/BotFramework-WebChat) can help you to test the bot.
