The Contoso outdoor equipment company has two services that they'd like to group together to build and deploy as a single unit. They decided to use Docker Compose to build the services together.

In this exercise, you create a Docker Compose YAML file, then use the Docker Compose utility to both build the Docker container images and run them.

## Connect to the codespace

To connect to the codespace:

1. Open a browser and go to the [eShopLite repository](https://github.com/MicrosoftDocs/mslearn-dotnet-cloudnative).
1. Select **Code**, and then select the **Codespaces** tab.
1. Select the codespace that you created in the previous exercise. GitHub opens the codespace.
1. Change to the */dotnet-docker* directory.

## Create the Docker Compose file

Now you can use the Docker Compose file to configure images for both the back-end and front-end services.

1. In the top folder of the codespace (the same folder that contains *README.md*), open the file named *docker-compose.yml*.
1. Add the following code to the file:

    ```yml
    version: '3.4'

    services: 

        frontend:
            image: storeimage
            build:
                context: .
                dockerfile: DockerfileStore
            environment: 
               - ProductEndpoint=http://backend:8080
               - ImagePrefix=http://localhost
            ports:
               - "5902:8080"
            depends_on: 
               - backend
        backend:
            image: productservice
            build: 
                context: .
                dockerfile: DockerfileProducts
            ports: 
               - "5200:8080"
    ```

    This code does several things:

   1. It creates the front-end website and names it **frontend**. The code tells Docker to build it, and points to the *DockerfileStore* file.
   1. The code sets an environment variable for the website: `ProductEndpoint=http://backend:8080`. This code is how the front-end service finds the Products back-end service.
   1. A second environment variable specifies where images for products are located.
   1. The code opens a port and declares that it depends on the back-end service.

    The back-end service named **backend** is created next. The same Dockerfile that you created in the previous exercise builds it. The last command specifies which port to open.

1. Select the **Ports** tab. Then, to the right of the local address for the **Back End** port, select the **Copy** icon.

    ![Screenshot that shows how to copy the address for the back-end Products service.](../media/copy-backend-address.png)

1. In the *docker-compose.yml* file, paste this URL in the `ImagePrefix` environment variable to replace the text `http://localhost`.
1. Append `images` to the pasted text:

    ```docker-compose
    environment: 
      - ProductEndpoint=http://backend:8080
      - ImagePrefix=https://super-duper-space-broccoli-5200.app.github.dev/images
    ```

## Build the images and run the containers

Now, use Docker Compose to build and start both front-end and back-end components.

1. To build the container images, select the **Terminal** tab, and then run the following command:

    ```bash
    docker compose build
    ```

1. To start both the front-end website and the back-end web API, run this command:

    ```bash
    docker compose up
    ```

1. Some output appears, and then the website and web API are running. You should see output that's similar to this example:

    ```output
    Attaching to docker-aspnet-products_backend_1, docker-aspnet-products_frontend_1
    ```

1. To test the front-end service, select the **Ports** tab. Then, to the right of the local address for the **Front End** port, select the globe icon. The browser displays the home page.

1. Select **Products**. The catalog shows Contoso's merchandise.
