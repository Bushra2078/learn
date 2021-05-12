In this exercise you will learn to create a microservice endpoint and containerize it using docker.

> [!IMPORTANT]
> To complete this exercise, please download and install both the [.NET SDK](https://dotnet.microsoft.com/download) and [Docker](https://www.docker.com/products/docker-desktop). You will also need a text editor, such as [Visual Studio Code](https://code.visualstudio.com/).

## Clone the code

The website and API have already been created for you. Clone the [repository from GitHub](https://github.com/MicrosoftDocs/mslearn-dotnetmicroservices/) to retrieve the code.

1. Open up a command prompt.
1. Change to a directory that you want the code to be downloaded to.
1. Enter the following command to download, or clone, the sample repository:

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-dotnetmicroservices
    ```

The code will download into a new folder named **mslearn-dotnetmicroservices**.

## Create the Dockerfile for the backend web API

Now that the code is downloaded, we'll be deploying our backend and frontend microservices as Docker containers. In order to do that we need to create a Dockerfile that instructs Docker how to build the image.

1. Open the **backend** directory from the repository that you just cloned in a text editor such as VS Code.
1. Within the **backend** directory, open the file named **Dockerfile**, this file will be empty.
1. Enter the following code:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
    WORKDIR /src
    COPY backend.csproj .
    RUN dotnet restore
    COPY . .
    RUN dotnet publish -c release -o /app
    ```

    This will perform the following steps sequentially when invoked:

    - Pull the `mcr.microsoft.com/dotnet/sdk:5.0` image and name the image `build`.
    - Set the working directory within the image to `/src`.
    - Copy the file named **backend.csproj** found locally to the `/src` directory that was just created.
    - Calls `dotnet restore` on the project.
    - Copy everything in the local working directory to the image.
    - Calls `dotnet publish` on the project.

1. Directly below the last line, now enter this:

    ```dockerfile
    FROM mcr.microsoft.com/dotnet/aspnet:5.0
    WORKDIR /app
    EXPOSE 80
    EXPOSE 443
    COPY --from=build /app .
    ENTRYPOINT ["dotnet", "backend.dll"]
    ```

    This will perform the following steps sequentially when invoked:

    - Pull the `mcr.microsoft.com/dotnet/aspnet:5.0` image.
    - Set the working directory within the image to `/app`.
    - Exposes port 80 and 443.
    - Copy everything from the `/app` directory of the **build** image created above into the root directory of this image.
    - Sets the entrypoint of this image to `dotnet` and passes `backend.dll` as an argument.

1. Save the Dockerfile, open a command prompt, and navigate to the directory that holds that file.
1. Run this command to create image and tag the image with the name **pizzabackend**:

    ```bash
    docker build -t pizzabackend .
    ```

    This executes the commands in the `Dockerfile` in the current directory and applies the tag `pizzabackend` to the resulting image.

> [!TIP]
> If you are getting errors from Docker, it may not have be installed correctly. Run the following command to verify:
> `docker run hello-world`
> If you do _not_ see "Hello from Docker!" amongst the output, please follow this [Docker installation tutorial](https://dotnet.microsoft.com/learn/aspnet/microservice-tutorial/install-docker).

1. After much output, the image will be built. Typing `docker images` will show you a list of all images on your machine with `pizzaapiservice` listed.
1. To run the web API service, enter the following command to start a new Docker container using the **pizzabackend** image and expose the service on port 5200:

    ```bash
    docker run -it --rm -p 5200:80 --name pizzabackendcontainer pizzabackend
    ```

1. Then you can browse to `http://localhost:5200/pizzainfo` and see a JSON representation of the Contoso Pizza's menu.
