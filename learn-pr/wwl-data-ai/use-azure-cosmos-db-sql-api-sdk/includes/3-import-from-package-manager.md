The **Microsoft.Azure.Cosmos** library, including all of its previous versions, are hosted on **nuget** to make it easier to import the library into a .NET application.

## Importing a NuGet package

To import a NuGet package into a .NET application, you must use the .NET CLI. The CLI includes a ``dotnet add`` command that is used to add a resource to a .NET project. To specifically add a NuGet package, you must do one of the following things:

### Import the latest version of the package

Invoke the ``dotnet add package`` command with only the name of the package. For example, this command will import the latest stable version of the **Microsoft.Azure.Cosmos** library.

:::code language="azurecli" source="../media/3-script.sh" range="1":::

> &#128161; This command will only import stable versions of the package. If a newer preview of the package is available, it will import the older stable version. If no stable version is available, it will not import the package at all.

### Import a specific version of the package

Invoke the ``dotnet add package`` command with the name of the package and the ``--version`` argument specifying a specific package version. For example, this command will import the **3.21.0** version of the **Microsoft.Azure.Cosmos** library.

:::code language="azurecli" source="../media/3-script.sh" range="3-4" highlight="2":::

> &#128161; Specifying the package version is the only way to import preview versions of packages that have not been flagged as stable yet.

## .NET project file

Once imported, the package specification will be added to the **csproj** file for the .NET project. The project file uses the XML format and a new element named **PackageReference** is created within the **ItemGroup** element with the name of the package and the version. In this example, the **3.21.0** version of the **Microsoft.Azure.Cosmos** library was imported into the project from NuGet.

:::code language="xml" source="../media/3-project.xml" highlight="7":::

> &#128221; The version of the package will be added whether you specfied it in the import command or not. If you did not specify a package version, the version of the latest stable package that was imported is specified in the project file.
