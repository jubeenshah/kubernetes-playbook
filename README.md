# Kubernetes Guide

## Table of Content
1. Prerequisites
2. Installing and Setup (ansible)
3. [Running a HTTP server](running-a-http-server-nginx)


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
```

You can check for the details about the deployment to see whether all the pods are ready using the following command.

```shell
$ kubectl get deployment

NAME             READY   UP-TO-DATE   AVAILABLE   AGE
my-first-nginx   0/2     2            0           4m10s
```
