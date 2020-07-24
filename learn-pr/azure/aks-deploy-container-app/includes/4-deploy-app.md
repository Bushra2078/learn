Your company is looking at ways to deploy your cloud-based video rendering service. You've chosen Azure Kubernetes Service (AKS) as your cloud-native development platform. With the cluster configured, you're ready to deploy one of the components in your video rendering application. You decide to deploy a static version of your company's website to explore the Kubernetes deployment process.

Before we discuss the Kubernetes way of deployment, let's review some of the steps you'd take to deploy a similar application to a non-Kubernetes environment.

Assume you're using an Azure Virtual Machine as your target platform. The first step is to prepare the server software to host the application. You'll install the operating system, make sure to update the OS to the latest security and software patches, install and configure the web server software, and finally deploy the web application. You'll repeat this process for each new VMs when you decide to scale the website out to handle an increase in demand from customers.

An alternative approach is to run the website on a container-based platform like Azure Container Instances (ACI). You do not need to worry about the underlying server technology, but you'll have to configure and manage several containers to use this strategy manually.

Kubernetes and AKS help you orchestrate containers. The Kubernetes container orchestration features make it easy to manage workloads on the cluster.

Here you'll explore how to create workloads in your AKS cluster.

## Container images

Kubernetes is a **container** orchestrator. You deploy workloads using containers built from container images to run your applications within an ASK cluster. You'll typically use Docker containers for this purpose.

## Container registries

Container registries allow you to store your images safely in the cloud and download them later. You can think of the container registry as an archive that stores multiple versions of your container image. Each stored image has a tag assigned for identification.

For example, you may have the image `contoso-website:latest`, which would be a different version of the image with the tag `contoso-website:v1.0.0`.

:::image type="content" source="../media/4-1-cr-diagram.png" alt-text="Container Registry Diagram":::

Container registries may be public or private. Private registries require credentials to access and download images and will be the strategy you'll follow when storing container images.

Kubernetes only allows you to deploy images hosted in a container registry. Creating a private container registry will normally be part of your standard AKS deployment strategy.

## Kubernetes Pods

Kubernetes groups containers and applications into logical structures called **Pods**. These pods have no intelligence and are composed of one or more application containers. Each one has an IP address, network rules, and exposed ports.

## Kubernetes labels

Kubernetes labels allow you to logical group Kubernetes objects. These labels enable the system to query the cluster for objects that match a label with a specific name.

For example, if you wanted to search all workloads related to the `contoso-website`, you'll query the cluster for pods with the label `app` and the value `contoso-website`.

## Kubernetes deployments

:::image type="content" source="../media/4-2-deployments-diagram.png" alt-text="Deployments diagram":::

Deployments are an evolution of pods. They wrap the Pods into an intelligent object that allows them to _scale out_. You can easily duplicate and scale your application to support more load without the need to configure complex networking rules.

Deployments allow users to update applications just by changing the image tag without downtime. When you update a deployment, instead of deleting all apps and creating new ones, the deployment turns off the online apps one by one, replacing them with the newest version. This aspect means any deployment can update the pods inside it with no visible effect in availability.

## Kubernetes manifest files

A Kubernetes manifest file allows you to describe your workloads in the YAML format declaratively and simplify Kubernetes object management.

Imagine you have to deploy a workload by hand. You need to think about and manage several aspects. You'd need to create a container, select a specific node, wrap it in a pod, run the pod, monitor execution, and so on.

Manifest files contain all the information that is needed to create and manage the described workload.

### Manifest file structure

The structure of manifest files differs depending on the type of resource that you create. However, manifest files share common instructions. These instructions define various aspects, such as the APIs to use and the type of workload to create.

The first two entries in all manifest files have two important keys `apiVersion` and `kind`. Here is an example of a deployment file.

```yaml
apiVersion: apps/v1 # Where in the API it resides
kind: Deployment # The kind of workload we're creating
```

The `apiVersion` key defines the API server endpoint that manages the object you'll deploy.

The `kind` key defines the workload this deployment will create.

Other common keys for all the files are the `metadata` and `name` keys. All Kubernetes resources **must** have a name, and this name goes inside the `metadata` key.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website # This will be the name of the deployment
```

## How to group objects in a deployment

Deployments make use of a `label` to find and group pods. You define the label as part of your deployment's manifest file.

Here is an example. Notice the `matchLabels` value defined in the `selector` definition added to the `spec` definition.

```yaml
# deployment.yaml
# ...
spec:
  selector:
    matchLabels:
      app: contoso-website
# ...
```

From this point on, all files have different structures based on what kind of resource you're telling Kubernetes to create.

## How to apply a deployment file

You deploy a Kubernetes deployment manifest file using `kubectl`. Here is an example of the command.

```bash
kubectl apply -f ./deployment.yaml
```
