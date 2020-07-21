In this exercise, you'll deploy your company's website as a test app onto AKS. The website is a static website with an underlying technology stack of HTML, CSS, and JavaScript. It doesn't receive as many requests as the other services and provides us with a safe way to test deployment options.

> The code for the web app is available in this [GitHub repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app) if you want to explore the source code further.

## Create a container registry

You need to create and push your container image to a container registry to deploy your app to your AKS cluster. Azure provides the **Azure Container Registry** (ACR) service to store container images.

1. Log in to the Azure Cloud Shell if not done so already.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. Create variables for the configuration values you'll reuse in this exercise.

```bash
ACR_NAME=ContosoContainerRegistry$RANDOM
```

1. Run the `az acr create` command to create a new container registry.

    ```azurecli
    az acr create \
        --resource-group $RESOURCE_GROUP \
        --name $ACR_NAME\
        --sku Basic
    ```

    The ACR you're working with is a private container registry. You need to tell your AKS cluster to authenticate with that registry to download the stored images.

1. Run the `az aks update` command to attach to your new ACR.

    ```azurecli
    az aks update \
        --name $CLUSTER_NAME \
        --resource-group $RESOURCE_GROUP \
        --attach-acr $ACR_NAME
    ```

## Sign in and push a container image to ACR

You need to authenticate with the new ACR before you can push your container image. Your ACR credentials are available in the [Azure portal](https://portal.azure.com)  should you need the information. Navigate to your newly created ACR and select the **Access keys** tab.

    :::image type="content" source="../media/4-acr-login.png" alt-text="Check your credentials on the 'Access Keys' tab":::

1. In the Cloud Shell run the `az acr login` command to authenticate with your new ACR. There's no need to include the `.azurecr.io` in the name of the CR when logging in.

    ```azurecli
    az acr login --name $ACR_NAME
    ```

    You're now ready to push images to the ACR.

1. Clone the web app from the GitHub repository and change into the `mslearn-aks-deploy-container-app` directory.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app.git
    cd mslearn-aks-deploy-container-app
    ```

1. Run the `az acr build` command to build and push the container image.

    ```azurecli
    az acr build \
        --image contoso-website \
        --registry $ACR_NAME \
        --file Dockerfile .
    ```

    The `--image` parameter adds the `contoso-website` tag to the image, and the image is automatically pushed to the registry once the build completes successfully.

## Create a deployment manifest

You create a deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and all the details associated with the workload.

Kubernetes groups containers into logical structures called Pods, which have no intelligence. Deployments add the missing intelligence to create your application. Let's begin creating a deployment file.

1. In the Cloud Shell, create a manifest file for the Kubernetes deployment called `deployment.yaml` by using the integrated editor.

    ```bash
    touch deployment.yaml
    ```

1. Open the integrated editor in Cloud Shell by typing `code .`

1. Open the `deployment.yaml` file and add the following code section of YAML.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1 # The API resource where this workload resides
    kind: Deployment # The kind of workload we're creating
    metadata:
      name: contoso-website # This will be the name of the deployment
    ```

    In the above code, you added the first two keys to tell Kubernetes the `apiVersion` and `kind` of manifest you're creating. The `name` is the name of the deployment, and you'll use it to identify and query the deployment information when using `kubectl`.

    > [!TIP]
    > You can find more information about `apiVersion` and what values to put in this key by visiting the official Kubernetes documentation, linked at the end of this module.

1. A deployment wraps a pod. You make use of a template definition to define the pod information within the manifest file. The template is placed in the manifest file below the deployment specification section.

    Update the `deployment.yaml` file to match the following YAML.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata: # Metadata for the POD
          labels:
            app: contoso-website
    ```

    Pods don't have given names when created inside deployments, the pod's name will be the deployment's name with a random ID added to the end.

    Notice the use of the `labels` key. You add the `labels` key to allow deployments to find and group pods.

1. A pod wraps one or more containers. All pods have a specification section that allows you to define the containers inside that pod.

    Update the `deployment.yaml` file to match the following YAML.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-website
        spec:
          containers: # Here we define all containers
        name: contoso-website
    ```

    The `containers` key is an array of container specifications as a pod can have one or more containers. The specification defines an `image`, `name`, `resources`, `ports`, and other important information about the container.

    All running pods will follow the name `contoso-website-<UUID>`, where UUID is a generated ID to identify all resources uniquely.

1. It's a good practice to define a minimum and a maximum amount of the resources the app is allowed to use from the cluster. You use the  `resources` key to specify this information.

    Update the `deployment.yaml` file to match the following YAML.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-website
        spec:
          containers:
            - image: ContosoContainerRegistry$RANDOM.azurecr.io/contoso-website
              name: contoso-website
              resources:
                requests: # Minimum amount of resources requested
                  cpu: 100m
                  memory: 128Mi
                limits: # Maximum amount of resources requested
                  cpu: 250m
                  memory: 256Mi
    ```

      Notice how the resource section allows you to specify the minimum resource amount as a request and the maximum resource amount as a limit.

1. The last step is to define the ports this container will expose externally through the `ports` key. The `ports` key is an array of objects, which means that a container in a pod can expose multiple ports with multiple names.

    Update the `deployment.yaml` file to match the following YAML.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-website
        spec:
          containers:
            - image: ContosoContainerRegistry$RANDOM.azurecr.io/contoso-website
              name: contoso-website
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 80 # This container exposes port 80
                  name: http # We named that port "http" so we can refer to it later
    ```

    Notice how you name the port using the `name` key. Naming ports allow you to change the exposed port without changing files that reference that port.

1. Finally, add a selector section to define the workloads the deployment will manage.  The `selector` key is placed inside the deployment specification section of the manifest file. Use the `matchLabels` key to list the labels for all the pods managed by the deployment.

    Update the `deployment.yaml` file to match the following YAML.

    ```yml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
    spec:
      selector: # Define the wrapping strategy
        matchLabels: # Match all pods with the defined labels
          app: contoso-website # Labels follow the `name: value` template
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-website
        spec:
          containers:
            - image: ContosoContainerRegistry$RANDOM.azurecr.io/contoso-website
              name: contoso-website
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 250m
                  memory: 256Mi
              ports:
                - containerPort: 80
                  name: http
    ```

1. Save the manifest file and close the editor.

## Apply the manifest

1. In the Cloud Shell, run the `kubectl apply` command to submit the deployment manifest to your cluster.

    ```bash
    kubectl apply -f ./deployment.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    deployment.apps/contoso-website created
    ```

1. Run the `kubectl get deploy` command to check if the deployment was successful.

    ```bash
    kubectl get deploy contoso-website
    ```

    The command should output a table similar to the following example.

    ```output
    NAME              READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-website   0/1     1            0           16s
    ```

1. Run the `kubectl get pods` command to check if the pod is running.

    The command should output a table similar to the following example.

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    contoso-website-7c58c5f699-r79mv   1/1     Running   0          63s
    ```
