Elastic Stack provides tools, including Elasticsearch and Kibana, to help you search, analyze, monitor, and secure your apps and IT. Recall that in the Trailwinds scenario, you have been asked to deploy Elastic Cloud on Kubernetes on AKS. Here, you will deploy a three-node Elasticsearch cluster and two instances of Kibana leveraging Azure Cloud Shell.

1. Create an elasticsearch.yaml configuration file with the following content.

    ```yml
    apiVersion: elasticsearch.k8s.elastic.co/v1
    kind: Elasticsearch
    metadata:
      name: quickstart
    spec:
      version: 7.11.1
      nodeSets:
      - name: default
        count: 1
        config:
          node.store.allow_mmap: false
    ```

1. Save the changes to elasticsearch.yaml and run the following command in Azure Cloud Shell:

    ```bash
    kubectl apply -f elasticsearch.yaml
    ```

    The command will finish with *elasticsearch.elasticsearch.k8s.elastic.co/quickstart created* message.

1. Run the following command in Cloud Shell to see the status of the Elasticsearch cluster as it gets created.

    ```bash
    kubecctl get elasticsearch
    ```

    :::image type="content" source="../media/get-elasticsearch-output.png" alt-text="TODO":::

1. Use the following command to start port forwarding on the current Cloud Shell session. Open a new Azure Cloud Shell session from the menu.

    ```bash
    kubectl port-forward service/quickstart-es-http 9200
    ```

    :::image type="content" source="../media/port-forward-output.png" alt-text="TODO":::

    :::image type="content" source="../media/cloud-shell-new.png" alt-text="TODO":::

1. On the newly opened Azure Cloud Shell session, get the credentials of the default elastic user for the Elasticsearch cluster.

    ```bash
    PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')    
    ```

1. With credentials for the elastic user, run the following curl to get information about nodes of Elasticsearch cluster.

    ```bash
    curl -u "elastic:$PASSWORD" -k "https://localhost:9200/_cat/nodes?v=true"
    ```

    :::image type="content" source="../media/curl-output.png" alt-text="TODO":::

1. Create kibana.yaml file with the following content:

    ```yml
    apiVersion: kibana.k8s.elastic.co/v1
    kind: Kibana
    metadata:
      name: quickstart
    spec:
      version: 7.11.1
      count: 2
      http:
        service:
          spec:
            type: LoadBalancer
      elasticsearchRef:
        name: quickstart
    ```

1. Next, run the following command to deploy Kibana.

    ```yml
    kubectl apply -f kibana.yaml    
    ```

1. You can use `watch kubectl get kibana` command to see the status of Kibana deployment. Once the health of the deployment turns green, stop the watch command and run `kubectl get service quickstart-kb-http` to get details for Kibana.

1. Copy the EXTERNAL-IP from the output and open https://<EXTERNAL-IP>:5601. Caution: Since we are using self-signed certificates for this tutorial you should see a “Your connection isn’t private” message in the browser. Please ensure to use valid certificates for any production deployments. Please refer to the TLS certificates section for more details.

1. Click on Advanced and proceed to the Kibana Login page. Use the ***elastic*** user to log in.

1. On Azure Cloud Shell, run the following command to get the password for the elastic user and use the value to log in to the Kibana Login page in the browser.

    ```bash
    kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}'    
    ```

    :::image type="content" source="../media/elastic-login-dialog.png" alt-text="TODO":::

    :::image type="content" source="../media/elastic-welcome-screen.png" alt-text="TODO":::

    The deployment is up and running. You can click on Add data to add sample datasets and Kibana visualizations that are shipped with Kibana, or you can click on Explore on my own to explore Kibana further and add your data.
