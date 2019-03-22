# Kubernetes Guide

## Table of Content
1. Prerequisites
2. Installing and Setup (ansible)
3. [Running a HTTP server](#running-a-http-server-nginx)
4. [Createing Node](#creating-a-node)
6. [Linking Pods and Containers](#linking-pods-and-container)


### Running a HTTP server (nginx)

On the `kubernetes master` we can use `kubectl run` to create a certain number of containers. The kubernetes master will then schedule the pods for the nodes to run, with general command, as follows: 

```shell
$ kubectl run <replication controller name> --image=<image-name> --replicas=<number of replicas> [--port=<exposing port>]
```

The following example will create two replicas with the name `my-first-nginx` from the nginx image and expose port `80`. We can deploy one or more containers in what is referred to as a `pod`. In the following case, we will deploy one container per pod. If the image, doesn't exist locally, one will be pulled from `Docker-Hub`

```shellserver
$ kubectl run my-first-nginx --image=nginx --replicas=2 --port=80

deployment.apps/my-first-nginx created
vagrant@ubuntu-xenial:/ansible-srv$ 
```

It will take some time for the setup, but if you run `kubectl get pods`, you will see the following output.

```shell
$ kubectl get pods

NAME                            READY   STATUS              RESTARTS   AGE
my-first-nginx-9b55fcdd-c4m6h   0/1     ContainerCreating   0          56s
my-first-nginx-9b55fcdd-n64qz   0/1     ContainerCreating   0          56s

$ kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
my-first-nginx-9b55fcdd-4qwnl   1/1     Running   0          6m39s
my-first-nginx-9b55fcdd-dv4m5   1/1     Running   0          6m39s
```

You can check for the details about the deployment to see whether all the pods are ready using the following command.

```shell
$ kubectl get deployment

NAME             READY   UP-TO-DATE   AVAILABLE   AGE
my-first-nginx   0/2     2            0           4m10s

$ kubectl get deployment
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
my-first-nginx   2/2     2            2           9m52s
```

### Creating a node

On the node run the following command.

```shell
sudo kubeadm join ip-address:6443 --token token.token --discovery-token-ca-cert-hash sha256:sha256Value --node-name Test
```

### Linking Pods and Containers

The `Pod` is a group of one or more containers and the smallest deployable unit in Kubernetes. Pods are always `co-located` and `co-scheduled`, and run in a shared context. 

Once logged onto the master node, create a `my-pod.yml` with the following content.

```yaml
apiVersion: v1
kind: Pod
metadata: 
  name: my-first-pod
spec: 
  containers:
  - name: my-nginx
    image: nginx
  - name: my-centos
    image: centos
    command: ["/bin/sh", "-c", "while : ; do curl http://localhost:80/; sleep 10; done"] 
```
To create the pods, run `kubectl create -f my-pod.yml`

