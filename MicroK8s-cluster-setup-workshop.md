# Purpose
This repository help to setup MicroK8s cluster of 3 nodes (1master, 2 worksers)  

## Requirements
- Running 3 VMs with ubuntu 18+ (preferably under same subnet, allow port 22)
- preferd minimum configuration for master: 2vcpu , 1GB memory, 20GB disk
---

## step 1: Install MicroK8s 
- login to all 3 VMs and install microk8s using single command

*MicroK8s will install a minimal, lightweight Kubernetes you can run and use on practically any machine. It can be installed with a snap* 
```
sudo snap install microk8s --classic  #cluster created with latest k8s version

```

- To use a specific version of Kubernetes, you can use the --channel option. For example, to install MicroK8s and let it follow the v1.18 stable release series you can run:


```
snap install microk8s --classic --channel=1.18/stable

```
---
## step 2: Check the status installation in all VMs
-MicroK8s has a built-in command to display its status. During installation you can use the --wait-ready flag to wait for the Kubernetes services to initialise:
```
sudo microk8s status --wait-ready
```
---
## step 3: Enable admin privileges to microk8s in master node
- MicroK8s creates a group to enable seamless usage of commands which require admin privilege. To add your current user to the group and gain access to the .kube caching directory, run the following two commands in master node:

```
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
```
---
## step 4: Turn on the services you want
- Try microk8s enable --help for a list of available services and optional features.
    - microk8s enable -name- turns on a service
    - microk8s disable -name- turns off a service.
- let us try to enable dashboard, dns, registry, istio services

```
microk8s enable dashboard dns registry istio    #run with sudo if you bipass step3
```
- check for available services
```
microk8s enable --help    
```
---
## step 5: adding worker node 1 to the master
- list all the nodes int the cluster , we are not yet attached any worker nodes, it should show only master
```
microk8s kubectl get nodes
```
- now let us add workernodes to the master, Luckily for us, Kubernetes makes adding new nodes really easy. In case of microk8s, the shell command `microk8s add-node` generates a connection string and outputs a list of suggested microk8s join commands for adding new nodes to the current microk8s cluster. 
```
microk8s add-node
```
- In the above output of the microk8s add-node command you see `microk8s join ip:port/xxxxxx` command copy it and run it on 1st worker node along with sudo request

```
sudo microk8s join ip:port/xxxxxx
```
---
## step 6: adding worker node 6 to the master

- repeat instructions in setp 5 , for adding worker node 2

- *remember genrated `microk8s add-nod` link is valid for one node, for adding another node you need to generate a fresh link*

---
## step 7: verify your cluster
- list all the nodes int the cluster , this time should show 3 nodes master and 2 workernodes
```
microk8s kubectl get nodes
```









---
# Congratulations  you have setup your own microk8s cluster

- don't forget to terrminate your VM's 
