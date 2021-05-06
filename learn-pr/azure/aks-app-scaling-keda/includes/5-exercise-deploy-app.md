In this exercise, you'll deploy your company's backend messaging service as a test app onto Azure Kubernetes Service (AKS). The service will connect to the Redis PaaS service created in the previous exercise.

> [!NOTE]
> The code for the service is available in this [GitHub repository](https://github.com/MicrosoftDocs/mslearn-aks-deploy-container-app) if you want to explore the source code further.

## Create a List in Redis

We first need to create a list in Redis and populate it with some random elements.  What we are simulating here is a queue that is receiving data.  Each item in the queue represents something that our microservice will process.  For simplicity sake, we are adding a static number of items. As you will see later in the exercise, we scale the microservice to the number of items that are in the queue (Redis List).

1. Create a Redis container locally to connect to the Azure Redis Cache Service we created earlier:

  ```bash
  docker run -it --rm redis redis-cli -h $REDIS_HOST -a $REDIS_KEY
  ```

  You should see something similar to this:

  ```bash
  redis-contoso-video.redis.cache.windows.net:6379>
  ```

2. Create a list and some random items:

  ```bash
  lpush keda Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris eget interdum felis, ac ultricies nulla. Fusce vehicula mattis laoreet. Quisque facilisis bibendum dui, at scelerisque nulla hendrerit sed. Sed rutrum augue arcu, id maximus felis sollicitudin eget. Curabitur non libero rhoncus, pellentesque orci a, tincidunt sapien. Suspendisse laoreet vulputate sagittis. Vivamus ac magna lacus. Etiam sagittis facilisis dictum. Phasellus faucibus sagittis libero, ac semper lorem commodo in. Quisque tortor lorem, sollicitudin non odio sit amet, finibus molestie eros. Proin aliquam laoreet eros, sed dapibus tortor euismod quis. Maecenas sed viverra sem, at porta sapien. Sed sollicitudin arcu leo, vitae elementum
  ```

## Create a deployment manifest

You create a deployment manifest file to deploy your application. The manifest file allows you to define what type of resource you want to deploy and all the details associated with the workload.

Kubernetes groups containers into logical structures called pods, which have no intelligence. Deployments add the missing intelligence to create your application. Let's create a deployment file.

1. In Cloud Shell, create a manifest file for the Kubernetes deployment called `deployment.yaml` by using the integrated editor.

    ```bash
    touch deployment.yaml
    ```

2. Open the integrated editor in Cloud Shell by entering `code .`

3. Open the `deployment.yaml` file, and add the following code section of YAML.

    ```yaml
    # deployment.yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-microservice
    spec:
      selector: # Define the wrapping strategy
        matchLabels: # Match all pods with the defined labels
          app: contoso-microservice # Labels follow the `name: value` template
      template: # This is the template of the pod inside the deployment
        metadata:
          labels:
            app: contoso-microservice
        spec:
          containers:
            - image: paulplavetzki/redis-client:v0.2.1
              name: contoso-microservice
              resources:
                requests:
                  cpu: 100m
                  memory: 128Mi
                limits:
                  cpu: 100m
                  memory: 128Mi
              env:
                - name: REDIS_HOST
                  value: "redis-contoso-video.redis.cache.windows.net"
                - name: REDIS_PORT
                  value: "6379"
                - name: REDIS_LIST
                  value: "keda"
                - name: REDIS_KEY
                  value: "fwPWjvcTvMks01j1ucxlvfnC9Gl7NNOv6hcypOrfuhA="       
    ```

4. Save the manifest file and close the editor.

## Apply the manifest

1. In Cloud Shell, run the `kubectl apply` command to submit the deployment manifest to your cluster.

    ```bash
    kubectl apply -f ./deployment.yaml
    ```

    The command should output a result similar to the following example.

    ```output
    deployment.apps/contoso-microservice created
    ```

2. Run the `kubectl get deploy` command to check if the deployment was successful.

    ```bash
    kubectl get deploy contoso-microservice
    ```

    The command should output a table similar to the following example.

    ```output
    NAME              READY   UP-TO-DATE   AVAILABLE   AGE
    contoso-microservice   0/1     1            0           16s
    ```

3. Run the `kubectl get pods` command to check if the pod is running.

    ```bash
    kubectl get pods
    ```

    The command should output a table similar to the following example.

    ```output
    NAME                               READY   STATUS    RESTARTS   AGE
    contoso-microservice-7c58c5f699-r79mv   1/1     Running   0          63s
    ```

## Create the Scaled Object with A Redis Trigger

This is where we will see what `KEDA` can do!  We will create a `ScaledObject` to scale based on the number of items in Redis list.  Before we apply the manifest, let's dissect the key sections of the spec.

1. `scaleTargetRef` - this section describes which workload `KEDA` observes.  In our deployment manifest from above we use the following values to tie the scaled object to the deployment.

  ```yaml
    scaleTargetRef:
      apiVersion:    apps/v1                        # Optional. Default: apps/v1
      kind:          deployment                     # Optional. Default: Deployment
      name:          contoso-microservice           # Mandatory. Must be in the same namespace as the ScaledObject
      envSourceContainerName: contoso-microservice  # Optional. Default: .spec.template.spec.containers[0]
  ```

2. `minReplicaCount` and `maxReplicaCount` - these two attributes determine the range of replicas `KEDA` uses for scaling.  In our case, we instruct `KEDA` to scale to zero with a max of one hundred.

  ```yaml
    minReplicaCount: 0                                 # Optional. Default: 0
    maxReplicaCount: 100                               # Optional. Default: 100
  ```

  > [!NOTE]
  > `minReplicaCount: 0` will take our `Deployment` default replica count from one to zero.  This will occur if the service is idle and not processing any events.  In this exercise, if there are no items in the Redis list, and the service remains idle, `KEDA` will scale to zero.

3. `advanced` - this section is generally related to advanced customization of `KEDA`. The `restoreToOriginalReplicaCount` instructs `KEDA` that after any scaling up scenarios, `KEDA` will return replica count to the original value.  In the case of our example, we set it to `false`, thus we do not return the original value of one, but scale down to the `minReplicaCount` value, zero.

  ```yaml
    restoreToOriginalReplicaCount: false        # Optional. Default: false
    horizontalPodAutoscalerConfig:                   # Optional. Section to specify HPA related options
      behavior:                                      # Optional. Use to modify HPA's scaling behavior
        scaleDown:
          stabilizationWindowSeconds: 300
          policies:
          - type: Percent
            value: 100
            periodSeconds: 15
  ```

4. `triggers` - this section uses `scalers` to detect if the object should be activated or deactivated, and feed custom metrics for a specific event source.  For our example, we use the Redis `scaler` to connect the Redis instance and to the Redis list.  The important metric in this `scaler` is `listLength`.  This instructs `KEDA` to scale up when there are ten items in the list.

  ```yaml
    triggers:
    - type: redis
      metadata:
        # address:   # Format must be host:port
        passwordFromEnv: REDIS_KEY
        listName: keda # Required
        listLength: "10" # Required
        enableTLS: "false" # optional
        databaseIndex: "0" # optional
        addressFromEnv: REDIS_HOST
        portFromEnv: REDIS_PORT
  ```

  For detailed information on available `scalers` see the documentation at the [KEDA site](https://keda.sh/docs/2.2/scalers/).

### Deploying the Manifest

1. In Cloud Shell, create a manifest file for the Kubernetes deployment called `scaled-object.yaml` by using the integrated editor.

    ```bash
    touch scaled-object.yaml
    ```

2. Open the integrated editor in Cloud Shell by entering `code .`

3. Open the `scaled-object.yaml` file, and add the following code section of YAML.

  ```yml
  apiVersion: keda.sh/v1alpha1
  kind: ScaledObject
  metadata:
    name: scaled-contoso
  spec:
    scaleTargetRef:
      apiVersion:    apps/v1  # Optional. Default: apps/v1
      kind:          deployment         # Optional. Default: Deployment
      name:          contoso-microservice         # Mandatory. Must be in the same namespace as the ScaledObject
      envSourceContainerName: contoso-microservice         # Optional. Default: .spec.template.spec.containers[0]
    pollingInterval: 30                                # Optional. Default: 30 seconds
    cooldownPeriod:  120                               # Optional. Default: 300 seconds
    minReplicaCount: 0                                 # Optional. Default: 0
    maxReplicaCount: 100                               # Optional. Default: 100
    advanced:                                          # Optional. Section to specify advanced options
      restoreToOriginalReplicaCount: false        # Optional. Default: false
      horizontalPodAutoscalerConfig:                   # Optional. Section to specify HPA related options
        behavior:                                      # Optional. Use to modify HPA's scaling behavior
          scaleDown:
            stabilizationWindowSeconds: 300
            policies:
            - type: Percent
              value: 100
              periodSeconds: 15
    triggers:
    - type: redis
      metadata:
        # address:   # Format must be host:port
        passwordFromEnv: REDIS_KEY
        listName: keda # Required
        listLength: "10" # Required
        enableTLS: "false" # optional
        databaseIndex: "0" # optional
        addressFromEnv: REDIS_HOST
        portFromEnv: REDIS_PORT
  ```

4. Save the manifest file and close the editor.

### Apply the manifest

1. In Cloud Shell, run the `kubectl apply` command to submit the deployment manifest to your cluster.

    ```bash
    kubectl apply -f ./scaled-object.yaml
    ```

2. Run the `kubectl get pods` command to check then number of running pods.

    ```bash
    kubectl get pods
    ```

    The command should output a table similar to the following example.

    ```output
    NAME                                  READY   STATUS    RESTARTS   AGE
    contoso-microservice-794d98b5-4flvg   1/1     Running   0          2m1s
    ```

    You should initially see 1 replica ready, the scaling of the replica will start after the polling period is eclipsed.

3. Periodically run the `kubectl get pods` command to verify the pod is scaling.

  > [!NOTE]
  > If you have linux utility `watch` installed you can run the following command to see the pods scale to process the Redis list items: `watch kubectl get pods`  If not, you can also try `kubectl get pods -w`.

  The command should output a table similar to the following example:

  ```output
  NAME                                  READY   STATUS    RESTARTS   AGE
  contoso-microservice-794d98b5-4flvg   1/1     Running   0          3m
  contoso-microservice-794d98b5-4jpxp   1/1     Running   0          3m
  contoso-microservice-794d98b5-4lw7b   1/1     Running   0          2m15s
  contoso-microservice-794d98b5-5fqj5   1/1     Running   0          3m
  contoso-microservice-794d98b5-5kdbw   1/1     Running   0          2m15s
  contoso-microservice-794d98b5-64qsm   1/1     Running   0          3m
  contoso-microservice-794d98b5-bmh7b   1/1     Running   0          3m8s
  contoso-microservice-794d98b5-gkstw   1/1     Running   0          2m15s
  contoso-microservice-794d98b5-pl7v7   1/1     Running   0          2m15s
  contoso-microservice-794d98b5-rgmvx   1/1     Running   0          2m15s
  ```

And after all the items have been processed and the `cooldownPeriod` has expired, you will see that the number of pods is zero.  Why zero?  The reason that `KEDA` removes all running replicas is that there are no items left to process, within our `ScaledObject` manifest we set `minReplicaCount: 0` and `restoreToOriginalReplicaCount: false`.
