One of the benefits of Kubernetes is the support for declarative configuration management. The services you define in the configuration files will be retained at all costs.

This means if there's a failure Kubernetes will automatically restart the services that were running before the failure.

Let's see this resilience in action by deleting the pizza frontend pod and then verifying that Kubernetes has restarted it.

1. First run `kubectl get pods` and note the name, including the random string, of the pizza frontend pod. Here's an example output:

    ```bash
    username@computer-name % kubectl get pods

    NAME                             READY   STATUS    RESTARTS   AGE
    pizzabackend-7445bdb5c9-pnpk6    1/1     Running   0          31m
    pizzafrontend-5b6cc765c4-hjpx4   1/1     Running   0          63m
    ```

1. Now delete the pizza frontend pod by using the `kubectl delete` command. You'll need to specify the full name of the pod, including the random string.

    ```bash
    kubectl delete pod pizzafrontend-5b6cc765c4-hjpx4
    ```

    You'll receive a message immediately stating the pod has been deleted.

1. Because Kubernetes will maintain the system state as declared in the configuration files, it will immediately start up another pod instance. You can verify that by running `kubectl get pods`.

    ```bash
    username@computer-name % kubectl get pods

    NAME                             READY   STATUS    RESTARTS   AGE
    pizzabackend-7445bdb5c9-pnpk6    1/1     Running   0          31m
    pizzafrontend-5b6cc765c4-vwmv8   1/1     Running   0          7s
    ```

    Notice that the random string following the pizzafrontend name has changed. Indicating the pod is a new instance. Also the **AGE** value is considerably less as well.

In this exercise you learned how Kubernetes will automatically maintain declared system state, even if there's a failure
