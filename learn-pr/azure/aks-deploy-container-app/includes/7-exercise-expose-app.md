You successfully deployed the video rendering service website to your cluster. However, you noticed that you couldn't access the website from any client external to the cluster. The problem is that you haven't exposed your application to the Internet yet. By default, Kubernetes blocks all external traffic. You'll need to add an **Ingress Rule** to allow traffic into the cluster.

## Create the service manifest

Like all resources, services also have manifest files describing how they should behave. Let's create a new service description.

1. Log in to the Azure Cloud Shell if not done so already.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. In the Cloud Shell, create a manifest file for the Kubernetes service called `service.yaml`.

    ```bash
    touch service.yaml
    ```

1. Open the integrated editor in Cloud Shell by typing `code .`

1. Open the `service.yaml` file and add the following code section of YAML.

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    ```

    In the above code, you added the first two keys to tell Kubernetes the `apiVersion` and `kind` of manifest you're creating. The `name` is the name of the service, and you'll use it to identify and query the service information when using `kubectl`.

1. You define how the service will behave in the specification section of the manifest file. The first behavior you need to add is the type of service the service. Set the `type` key to `clusterIP`.

    Update the `service.yaml` file to match the following YAML.

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: ClusterIP
    ```

1. You define the pods the service will group and provide coverage by adding a `selector` section to the manifest file. Add the `selector` and set the `app` key value to the `contoso-website` label of your pods as specified in your earlier deployments manifest file.

    Update the `service.yaml` file to match the following YAML.

      ```yml
      #service.yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: contoso-website
      spec:
        type: ClusterIP
        selector:
          app: contoso-website
      ```

1. You define the port-forwarding rules by adding a `ports` section to the manifest file. The service must accept all TCP requests on port 80 and forward the request to the HTTP target port for all pods matching the selector value defined earlier.

    Update the `service.yaml` file to match the following YAML.

    ```yml
    #service.yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
    spec:
      type: ClusterIP
      selector:
        app: contoso-website
      ports:
        - port: 80 # SERVICE exposed port
          name: http # SERVICE port name
          protocol: TCP # The protocol the SERVICE will listen to
          targetPort: http # Port to forward to in the POD
    ```

1. Save the manifest file and close the editor.

## Deploy the service

1. In the Cloud Shell, run the `kubectl apply` command to submit the service manifest to your cluster.

    ```bash
    kubectl apply -f ./service.yaml
    ```

    The command should output a result similar to the following example:

    ```output
    service/contoso-website created
    ```

1. Run the `kubectl get service` command to check if the deployment was successful.

    ```bash
    kubectl get service contoso-website
    ```

    The command should output a result similar to the following example. Make sure the column `CLUSTER-IP` is filled with an IP address, and the column `EXTERNAL-IP` is `<none>`. Also, make sure the column `PORT(S)` is defined to `80/TCP`.

    ```output
    NAME              TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
    contoso-website   ClusterIP   10.0.158.189   <none>        80/TCP    42s
    ```

    With the external IP set to `<none>`, the application isn't available to external clients. The service is only accessible to the internal cluster.

## Create an Ingress manifest

To expose your website to the world via DNS, you must create an ingress controller.

1. In the Cloud Shell, create a manifest file for the Kubernetes service called `service.yaml`.

    ```bash
    touch ingress.yaml
    ```

1. Open the integrated editor in Cloud Shell by typing `code .`

1. Open the `service.yaml` file and add the following code section of YAML.

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
    ```

    In the above code, you added the first two keys to tell Kubernetes the `apiVersion` and `kind` of manifest you're creating. The `name` is the name of the ingress, and you'll use it to identify and query the ingress information when using `kubectl`.

1. Create an `annotations` key inside `metadata` section of the manifest file called to use the :::no-loc text="HTTP Application Routing"::: addon for this ingress. Set the key to `kubernetes.io/ingress.class` and a value of `addon-http-application-routing`.

    Update the `ingress.yaml` file to match the following YAML.

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    ```

1. Set the Fully Qualified Domain Name (FQDN) of the host allowed access to the cluster. 

	In the Cloud Shell,  run  the `az network dns zone list` command to query the Azure DNS zone list. 

    ```bash
    az network dns zone list --output table
    ```

    The command should output a result similar to the following example.

    ```output
    ZoneName                               ResourceGroup                                     RecordSets    MaxRecordSets
    -------------------------------------  ------------------------------------------------  ------------  ---------------
    5cd29ec927f24764b052.eastus.aksapp.io  mc_contoso-aks_contoso-kubernetes-cluster_eastus  2             10000
    ```

1. Copy the `ZoneName` and update  the `ingress.yaml` file to match the following YAML. Replace the `<zone-name>` placeholder value with the `ZoneName` value you copied.

    Update the `ingress.yaml` file to match the following YAML.

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso.<zone-name> # Which host is allowed to enter the cluster
    ```

1. Next up, add the backend configuration to your ingress rule. Create a key named `http` and allow the `http` protocol to pass through.  Then, define the `paths` key that will allow you to filter whether this rule applies to all paths of the website or only some of them. 

    Update the `ingress.yaml` file to match the following YAML.

    ```yml
    #ingress.yaml
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: contoso-website
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso.<uuid>.<region>.aksapp.io
          http:
            paths:
              - backend: # How the ingress will handle the requests
                  serviceName: contoso-website # Which service the request will be forwarded to
                  servicePort: http # Which port in that service
                path: / # Which path is this rule referring to
    ```

1. Save the manifest file and close the editor.

## Deploy the ingress

Now we need to deploy the service for our changes to take effect.

1. In the Cloud Shell, run the `kubectl apply` command to submit the ingress manifest to your cluster.

    ```bash
    kubectl apply -f ./ingress.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    ingress.extensions/contoso-website created
    ```

1. Run the ` kubectl get ingress` command to check if the deployment was successful.

    ```bash
    kubectl get ingress contoso-website
    ```

    The command should output a result similar to the following example.

    ```output
    NAME              HOSTS                                           ADDRESS        PORTS   AGE
    contoso-website   contoso.5cd29ec927f24764b052.eastus.aksapp.io   52.226.96.30   80      4m44s
    ```

    Make sure the `ADDRESS` column of the output is filled with an IP address. That's the address of you cluster.

1. There could be a small delay between the creation of the ingress and the creation of the zone record. Let's query Azure to find out if our DNS has been created and we can access the website already:

    Run the `list` command to list all DNS zones again:

    ```bash
    az network dns zone list --output table
    ```

    The command should output a result similar to the following example.

    ```output
    ZoneName                               ResourceGroup                                     RecordSets    MaxRecordSets
    -------------------------------------  ------------------------------------------------  ------------  ---------------
    5cd29ec927f24764b052.eastus.aksapp.io  mc_contoso-aks_contoso-kubernetes-cluster_eastus  4             10000
    ```

1. Copy the `ZoneName` and `ResourceGroup` columns and run the `az network dns` command. Replace `<resource-group>` and `<zone-name>` value placeholders with the values you copied.

    ```bash
    az network dns record-set list -g <resource-group> -z <zone-name> --output table
    ```

    The command should output a result similar to the following example.

    ```output
    Fqdn                                            Name     ProvisioningState    ResourceGroup                                     Ttl
    ----------------------------------------------  -------  -------------------  ------------------------------------------------  ------
    5cd29ec927f24764b052.eastus.aksapp.io.          @        Succeeded            mc_contoso-aks_contoso-kubernetes-cluster_eastus  172800
    5cd29ec927f24764b052.eastus.aksapp.io.          @        Succeeded            mc_contoso-aks_contoso-kubernetes-cluster_eastus  3600
    contoso.5cd29ec927f24764b052.eastus.aksapp.io.  contoso  Succeeded            mc_contoso-aks_contoso-kubernetes-cluster_eastus  300
    contoso.5cd29ec927f24764b052.eastus.aksapp.io.  contoso  Succeeded            mc_contoso-aks_contoso-kubernetes-cluster_eastus  300
    ```

    Make sure there are two new records at the bottom of the list with the host we created in the `host` key. And the `ProvisioningState` is `Succeeded`.  It can take up to two minutes for Zone Records to propagate.

1. Open your browser and go to the FQDN described in the output. You should see a website as displayed in the following example screenshot.

:::image type="content" source="../media/7-website-success.png" alt-text="Screenshot of the Contoso video rendering service website.":::
