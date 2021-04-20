
You're ready to connect to Earth's Azure Quantum services and start solving problems on a real quantum computer. The programs you created in Q# in previous modules, such as the quantum random number generator, will run using real qubits, instead of using simulations like in the module [Create your first Q# program by using the Quantum Development Kit](https://docs.microsoft.com/learn/modules/qsharp-create-first-quantum-development-kit/?azure-portal=true).

In this unit, you learn how to submit a job to Azure Quantum.

> [!NOTE] The cost of running this module in a Pay-As-You-Go subscription is approximately 9 USD (or the equivalent amount in your local currency). This quantity is only an approximate estimation and should not be used as a binding reference. The cost of the service might vary depending on your region, demand and other factors.

## Install the quantum extension

Azure Quantum uses the quantum extension for the Azure CLI to enable submitting Q# programs from the command line. Now you're going to install and configure the Azure CLI extension on your system to use Azure Quantum. To install it, follow these steps:

1. Ensure you've installed the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest/?azure-portal=true) (version 2.17.1 or higher).

1. Open a command prompt, and then run the following command:

   ```azurecli
   az extension add --source https://msquantumpublic.blob.core.windows.net/az-quantum-cli/quantum-latest-py3-none-any.whl
   ```

## Create a workspace

First, you need to create an Azure Quantum workspace in your Azure subscription and select the providers you want to use, if you haven't already. Follow these steps:

1. Open the [Azure portal](https://ms.portal.azure.com/?azure-portal=true), and sign in to your account.

1. Select **Create a resource**, and then search for **Azure Quantum**. On the results page, you should see a tile for the **Azure Quantum** service.

   :::image type="content" source="../media/3-azure-quantum-preview-search.png" alt-text="Tile for the Azure Quantum preview service." border="false":::

1. Select **Azure Quantum**, and then select **Create**. A form opens where you can create a workspace.

   :::image type="content" source="../media/3-azure-quantum-preview-create.png" alt-text="Screenshot showing option to create resource for the Azure Quantum preview service." border="false":::

1. Fill out the details of your workspace:
   - **Subscription**: The subscription that you want to associate with this workspace.
   - **Resource group**: The resource group that you want to assign this workspace to.
   - **Name**: The name of your workspace.
   - **Region**: The region for the workspace.
   - **Storage Account**: The Azure storage account to store your jobs and results. If you don't have an existing storage account, select **Create a new storage account** and complete the necessary fields. We recommend using the default values.

   :::image type="content" source="../media/3-azure-quantum-preview-properties.png" alt-text="Screenshot showing the properties for the Azure Quantum workspace." border="false":::

   > [!NOTE]
   > You must be an Owner of the selected resource group to create a new storage account. For more information about how resource groups work in Azure, see [Control and organize Azure resources with Azure Resource Manager](https://docs.microsoft.com/learn/modules/control-and-organize-with-azure-resource-manager/?azure-portal=true).

1. After you complete the information, select the **Providers** tab to add providers to your workspace. A provider gives you access to a quantum service, which can be quantum hardware, a quantum simulator, or an optimization service. In this case, we're interested in quantum hardware. We'll use the IonQ provider example, but the steps should be valid for other quantum hardware providers.

1. Add at least the IonQ provider, and then select **Review + create**.

1. Review the settings and approve the *Terms and Conditions of Use* of the selected providers. If everything is correct, select **Create** to create your workspace.

   :::image type="content" source="../media/3-azure-quantum-preview-terms.png" alt-text="Screenshot showing steps to review and create the workspace." border="false":::

> [!NOTE]
> This tutorial is using the IonQ targets as a [Quantum Processing Unit](https://docs.microsoft.com/azure/quantum/concepts-targets-in-azure-quantum) example. To complete it, you need to have access to IonQ targets on your subscription. If your subscription doesn't have access to quantum computing providers but you still want to try quantum computing programs, you can simulate a quantum computer locally using the Quantum Development Kit. For more information, go to the [Quantum Development Kit set-up guide](https://docs.microsoft.com/azure/quantum/install-overview-qdk).

## Set up the project and write your program

Next, you'll use Visual Studio Code to create a Q# Project, similar to how you did in the previous modules.

1. In Visual Studio Code, open the **View** menu and select **Command Palette**.

1. Enter **Q#: Create New Project**.

1. Select **Quantum application targeted to IonQ backend**.

1. Select a directory to hold your project, such as your home directory. Enter **MyFirstJob** as the project name, and then select **Create Project**.

1. From the window that appears at the bottom, select **Open new project**.

1. You should see two files: the project file and *Program.qs*, which contains starter code.

1. Replace the contents of *Program.qs* with the program:

    :::code language="qsharp" source="../code/3-program-1.qs":::

This program prepares a qubit in an even superposition and then measures it, similar to the random bit generator you wrote in the earlier module. It's simple but enough to show how to submit a job.

## Prepare the Azure CLI

Next, you prepare your environment to submit the job by using the workspace you created.

1. Use `az quantum workspace set` to select the workspace you created as the default workspace. You also need to specify the resource group you created it in and the location of the workspace, for example:

   ```dotnetcli
   az quantum workspace set -g MyResourceGroup -w MyWorkspace -l MyLocation -o table
   ```

   You should obtain the data of your workspace as output.

   ```output
   Location     Name         ProvisioningState    ResourceGroup    Usable  
   -----------  -----------  -------------------  ---------------  --------
   MyLocation   MyWorkspace  Succeeded            MyResourceGroup  Yes  

   ```

1. In your Azure Quantum workspace, there are different targets available from the providers that you added when you created the workspace. You can display a list of all the available targets with the command `az quantum target list -o table`:

   ```azurecli
   az quantum target list -o table
   ```

   You should obtain a list like this one:

   ```output
   Provider    Target-id                                       Status     Average Queue Time
   ----------  ----------------------------------------------  ---------  --------------------
   ionq        ionq.qpu                                        Available  0
   ionq        ionq.simulator                                  Available  0
   ```

    > [!NOTE]
    > When you submit a job in Azure Quantum, it will wait in a queue until the provider is ready to run your program. The `Average Queue Time` column of the target list command shows you how long other jobs that were run recently waited to be run. This information can give you an idea of how long you might have to wait.

In this case, we see that IonQ has two different targets, a quantum processing unit (QPU) and a simulator. The QPU is a trapped ion quantum computer with 11 qubits. The simulator is a GPU-accelerated simulator that supports up to 29 qubits with the same characteristics as the QPU, which makes it perfect to test jobs before running them on actual quantum hardware.

> [!NOTE]
> Keep in mind that this code will work only on quantum computing targets, defined as the [Quantum Processing Units](https://docs.microsoft.com/azure/quantum/concepts-targets-in-azure-quantum). Optimization solvers won't be able to run this code. Specifically, any target whose identifier ends with `.cpu` or `.fpga` is an optimization target and won't be able to run this code. You can learn how to use optimization targets with our module [Solve optimization problems by using quantum-inspired optimization](https://docs.microsoft.com/learn/modules/solve-quantum-inspired-optimization-problems/).


## Simulate the program

Before you run a program against real hardware, we recommend that you simulate it first, if possible, based on the number of qubits required. A simulation helps to ensure that your algorithm is doing what you want.

Run your program with `az quantum execute --target-id ionq.simulator -o table`. This command will compile your program, submit it to Azure Quantum, and wait until IonQ has finished simulating the program. After it's finished, it will output a histogram, which should look like this example:

   ```azurecli
   az quantum execute --target-id ionq.simulator -o table

   ..
   Result    Frequency
   --------  -----------  -------------------------
   0         0.50000000   ▐██████████             |
   1         0.50000000   ▐██████████             |
   ```

This histogram shows an equal frequency for each of the two possible qubit measurement results, which is what we expect from an idealized simulator. This result means we're ready to run it on the QPU.

## Run the program on hardware

To run the program on hardware, we'll use the asynchronous job submission command `az quantum job submit`.

1. Run in the Azure command line:

   ```azurecli
   az quantum job submit --target-id ionq.qpu -o table
   ```

   Like the `execute` command, this command will compile and submit your program, but it won't wait until the execution is complete. We recommend this pattern for running against hardware, because you might need to wait a while for your job to finish. To get an idea of how long, you can run `az quantum target list -o table` as described. You should obtain something like this example:

   ```output
   Name        Id                                    Status    Target    Submission time
   ----------  ------------------------------------  --------  --------  ---------------------------------
   QuantumRNG  yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy  Waiting   ionq.qpu  2020-10-22T22:41:27.8855301+00:00
   ```

1. Track the status of your job by using the `az quantum job show` command. To check on the status, use the `az quantum job show` command. Make sure to replace the `job-id` parameter with the `Id` output by the previous command:

   ```azurecli
    az quantum job show -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
   ```

   You should obtain an output like this example:

   ```output
   Name        Id                                    Status    Target    Submission time
   ----------  ------------------------------------  --------  --------  ---------------------------------
   QuantumRNG  yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy  Waiting   ionq.qpu  2020-10-22T22:41:27.8855301+00:00 
   ```

1. Eventually, you'll see the `Status` in the preceding table change to `Succeeded`. After that's finished, you can get the results from the job by running `az quantum job output`:

   ```azurecli
   az quantum job output -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
   ```

   And the output should be similar to this example:

   ```output
   Result    Frequency
   --------  -----------  ------------------------
   0         0.47200000   ▐█████████             |
   1         0.52800000   ▐██████████            |
   ```

The histogram you receive is the averaged results over the number of *shots* or iterations that the computer has run the program. Remember that quantum programs are probabilistic, so we need to run them many times to see output of the relevant statistics. In this case, the quantum computer has run the preceding program 500 times, because the default value of the argument `shots`is 500.

### Set the number of shots

To change the number of shots, you need to specify a different value for the argument `--shots`. For example, if you want to run the program only once:

1. Set the number of shots to 1:

    ```azurecli
    az quantum job submit --target-id ionq.qpu --shots 1 -o table
    ```

1. After the status of the job changes to `Succeeded`, extract the output of the job:

    ```azurecli
    az quantum job output -o table --job-id yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy
    Result    Frequency
    --------  -----------  -------------------------
    1         1.00000000   ▐████████████████████   |
    ```

In this case, we obtained `1` as the result of the bit generated by measuring the superposed qubit in the ion-trapped quantum computer.

Congratulations, you learned how to use Azure Quantum to create a true quantum random bit generator! However, we don't want quantum computers just to generate random numbers.

In the next units, you'll learn about the different targets available to run your algorithms.
