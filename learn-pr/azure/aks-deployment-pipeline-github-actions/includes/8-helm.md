You have successfully built and pushed both of your production and staging images to the ACR. It's time to automate all the steps and make the machine work for you.

But there's a problem. Your workloads aren't generic enough, this way you can't deploy them automatically, you need to manually change the files every time.

## Helm charts

Helm is an open-source packaging tool that helps you install and manage the lifecycle of Kubernetes applications. Similar to Linux package managers such as APT and Yum. Helm is used to manage Kubernetes charts, which are packages of preconfigured Kubernetes resources.

A chart is a group of one or more workloads together with some configuration files and a chart description file. Those files compose a unit that can be easily deployed to a Kubernetes cluster.

One of the greatest advantages of using Helm is that you don't need to deploy all files individually. Instead, you can issue a single command to deploy the chart, or even multiple dependent charts with an automatic dependency resolution.

The structure of a chart directory is as follows:

:::image type="content" source="../media/8-helm-chart-tree.png" alt-text="A Helm chart tree":::

Let's go through each file and directory to understand their meaning.

|Name  |Type  |Meaning  |
|---------|---------|---------|
|Chart.yaml     |File         |File that describes the chart, it's the file that will have the name, description, and version of the chart         |
|charts     |Directory         |Directory to include dependent charts         |
|templates     |Directory         |Directory where all the manifest files live         |
|values.yaml     |File         |File that contains all default values for helm templates         |

The other feature that makes Helm stand out is, in fact, the feature that you'll need the most. The ability to create and manipulate templates.

## Helm templates

Templates are the feature that makes possible for manifest files to be automated and put into a CI pipeline.

A template file is a manifest file that contains placeholders for variable values. Let's take this example of the deployment.yaml file inside the kubernetes directory of your website fork:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website
spec:
  selector:
    matchLabels:
      app: contoso-website
  template:
    metadata:
      labels:
        app: contoso-website
    spec:
      containers:
        - image: !IMAGE!
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

See the `!IMAGE!` placeholder? That's a place where you should put your repository and image name. If you're doing a manual replacement, you'd do something like this:

```bash
$ sed 's+!IMAGE!+'"$ACR_NAME"'/contoso-website+g' kubernetes/deployment.yaml
```

This command would replace `!IMAGE!` in the file by the name of your ACR and the name of your image and print out the result, so you can pipe this command to a `kubectl apply -f -` and create the workloads.

However, this solution isn't elegant or efficient. Helm comes with native templating that allows you to replace `!IMAGE!` by `{{.Values.containerImage}}`:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website
spec:
  selector:
    matchLabels:
      app: contoso-website
  template:
    metadata:
      labels:
        app: contoso-website
    spec:
      containers:
        - image: {{.Values.containerImage}}
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

And then you just need to run the Helm command to install the workload passing this argument:

```bash
$ helm install contoso-website ./chart-location \
 --set containerImage="$ACR_NAME/contoso-website"
```

Besides this simple feature, Helm also uses template functions, which allows you to use more complex logic to include, for example, default and required values.

To make your CI pipeline more efficient, let's build the helm chart for the company's website.
