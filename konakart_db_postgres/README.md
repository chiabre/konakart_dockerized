# Prometheus + Konakart + JMeter Kubernetes lab

*The fllowing Prometheus + Konakart + JMeter deployment has been tested only on minikube*

Requirements:
* on EC2
    * minikube
    * kubectl
* on your laptop
    * docker
    * minikube
    * kubectl

## Minikube

[minkube](https://minikube.sigs.k8s.io/docs/start/)

### EC2 instance

If minikube runs on a remote EC2 istance, to expeose konakart web ui e jmx exporter start minikube with

```console
sudo minikube start --driver=none`
```

additional useful options:
* `--namespace lab` to define the dedatul kubectl namespace

### Laptop

If minikube runs on your laptop start minikube with

```console
minikube start --driver=docker`
```

additional useful options:
* `--cpus 4 --memory 8g` to allocate defined set of resources to minikube
* `--namespace lab` to define the dedatul kubectl namespace
* `--cache-images` to cache the docker imgs from the local registry

to expose a service on localhost

```console
minikube service [SERVICE] --url -n [NAMESPACE]`
```
### Kubernetes dashboard

To start the kubernetes web UI (dashboard) on an ec2 istance (without `sudo` on your laptop)

```console
sudo minikube dashboard
```

## Lab set-up

Once that minkube is running you can use the following command (or the init.sh script) to deploy 
the lab (prometheus + konakart services)

### lab init

create lab namespace

```console
kubectl create -f lab_namespace/lab_namespace.yml
```

set default context to lab namespace (not neeed if minikube has been started with `--namespace lab` )

```console
kubectl config set-context $(kubectl config current-context) --namespace=lab
```

(optional) set limits range and resources quota for lab namespace

```console
kubectl apply -f lab_namespace/lab_limitsRange.yml
kubectl apply -f lab_namespace/lab_resourceQuota.yml
```

### Prometheus + cadvisor

deploy prometheus service 

```console
kubectl apply -f prometheus/prom_configMap.yml -f prometheus/prom_service.yml -f prometheus/prom_deployment.yml
kubectl rollout status deployment/prometheus
```

deploy cadvisor (demonset + service in sigle file)

```console
kubectl apply -f cadvisor/cadvisor_demonSet.yml 
```

### Konakart

deploy konakart and scale down to 0 konakart

```console
kubectl apply -f konakart/kk_service.yml -f konakart/kk_deployment.yml
kubectl rollout status --timeout=5m deployment/konakart
kubectl scale --replicas=0 deployment konakart
kubectl rollout status --timeout=5m deployment/konakart
```

### JMeter

create once the JMeter service 

```console
kubectl apply -f jmeter/jmeter_service.yml
```

#### Konakart test

create once the Konakart JMeter config map (to store the script into k8s)
```console
kubectl apply -f jmeter/kk/jmeter_kk_ConfigMap.yml
```

* start the Konkart JMeter test as kubernetes job

```console
 kubectl delete job jmeter
 kubectl apply -f jmeter/jmeter_kk_job.yml
```

the kind of test executed is defined in the job definition file and based on the test scripts provided into the confiMap file. The available test scripts and related optios are described [here](/k8s/jmeter/kk/README.md)

## Konakart/Akamas integration in Kuberentes 

in Kuberentes lab Konakart offers 2 set of parameters to Akamas:
* JAVA_OPTS, exposed as env variables
* container limits & request defined in the deployment file

### kubectl set env (only JAVA OPTS)

A file configurator can be used to generate a sh script with the following content

```console
kubectl set env deployment/konakart JAVA_OPTS='-Xmx1024m -Xms1024m'`
```

the above command will trigger a deployment of a new POD with the new env. variables within the same kubernetes deployment/kk-deployment. Konakart web ui and jmx exporter will available on tha same port as before 

### deployment file updated (JAVA OPTS +container limits & request )

once updated the deployment file with the new values (via FileConfigurator)

```console
kubectl scale --replicas=0 deployment/konakart; kubectl rollout status --timeout=3m deployment/konakart; kubectl apply -f konakart/kk_deployment.yml; kubectl scale --replicas=1 deployment/konakart; kubectl rollout status --timeout=3m deployment/konakart;
```

the above command will:
* scale down the konakart replicas to 0
* wait for the command completition (timeout 3min)
* apply the new deployment file
* scale up the konakart replicas to 1
* wait for the command completition (timeout 3min)

### JAVA OPTS via config Map
in case the JAVA OPTS are not exposed as env variables Akamas can be integrated via config map by ovverriding the startup service scritp/configuration file within the microservice. Once generated the new configMap via file configurato it can be pushed to k8s ( `kubectl apply -f` ) and the service can be restarted with scaling it down to 0 and then up to 1 (via `kubectl scale --replicas=0|1`) 

## K8s Utils

### Debug

```console
kubectl describe pod [POD-NAME]
kubectl get event --field-selector involvedObject.name=[POD-NAME] --sort-by='.metadata.creationTimestamp'
kubectl exec --stdin --tty [POD-NAME] -- /bin/bash
```

### Quota & limtis utils

```console
kubectl get quota -n lab
kubectl get limits -n lab
```
