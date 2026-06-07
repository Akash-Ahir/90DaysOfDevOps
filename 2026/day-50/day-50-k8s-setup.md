# Day 50 – Kubernetes Architecture and Cluster Setup

## Task
You have been building and shipping containers with Docker. But what happens when you need to run hundreds of containers across multiple servers? You need an orchestrator. Today you start your Kubernetes journey — understand the architecture, set up a local cluster, and run your first `kubectl` commands.

This is where things get real.

---

## Challenge Tasks

## Task 1: Recall the Kubernetes Story
Before touching a terminal, write down from memory:

1. Why was Kubernetes created? What problem does it solve that Docker alone cannot?
    - Docker alone can run containers on a single machine, but when you need to run hundreds of containers across multiple servers, you need orchestration. Kubernetes can do automation on Distribute containers across multiple servers, Restart failed containers automatically, Scale containers based on demand, Manage networking between containers on different machines, Keep track of the "desired state" vs actual state.

2. Who created Kubernetes and what was it inspired by?
    - Created by Google, inspired by Google's internal system called Borg, which they had used for over 10 years to manage containers.

3. What does the name "Kubernetes" mean?
    - The name reflects its role as the person who guides steers the cluster of containers

---

## Task 2: Draw the Kubernetes Architecture
From memory, draw or describe the Kubernetes architecture. Your diagram should include:

**Control Plane (Master Node):**
- API Server — the front door to the cluster, every command goes through it
- etcd — the database that stores all cluster state
- Scheduler — decides which node a new pod should run on
- Controller Manager — watches the cluster and makes sure the desired state matches reality

**Worker Node:**
- kubelet — the agent on each node that talks to the API server and manages pods
- kube-proxy — handles networking rules so pods can communicate
- Container Runtime — the engine that actually runs containers (containerd, CRI-O)

<img width="1505" height="672" alt="kubernetes architecture diagram" src="https://github.com/user-attachments/assets/fdd54e7d-d60a-4d92-8f21-4991beec673d" />


After drawing, verify your understanding:
- What happens when you run `kubectl apply -f pod.yaml`? Trace the request through each component.
    kubectl sends the request to API Server
    API Server validates the request and stores it in etcd
    Scheduler watches etcd for new pods without a node assigned
    Scheduler decides which worker node is best
    API Server updates etcd with the node assignment
    kubelet on that worker node sees the new pod assignment via API Server
    kubelet tells the Container Runtime to create the container
    kube-proxy sets up networking rules so the pod can communicate
    Pod starts running 

- What happens if the API server goes down?
    No commands work, no new pods can be created, kubelet can't report status.

- What happens if a worker node goes down?
    Pods on that node stop, but kubelet on other nodes keep working. Scheduler will move pods to healthy nodes eventually
---

## Task 3: Install kubectl
`kubectl` is the CLI tool you will use to talk to your Kubernetes cluster.

Install it:
```bash
# macOS
brew install kubectl

# Linux (amd64)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Windows (with chocolatey)
choco install kubernetes-cli
```

Verify:
```bash
kubectl version --client
```
<img width="1432" height="255" alt="task 3" src="https://github.com/user-attachments/assets/be295636-260f-4231-80ec-d067ef167723" />



---

## Task 4: Set Up Your Local Cluster
Choose **one** of the following. Both give you a fully functional Kubernetes cluster on your machine.

**Option A: kind (Kubernetes in Docker)**
```bash
# Install kind
# macOS
brew install kind

# Linux
curl -Lo ./kind https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create a cluster
kind create cluster --name devops-cluster

# Verify
kubectl cluster-info
kubectl get nodes
```

<img width="1342" height="731" alt="task 4" src="https://github.com/user-attachments/assets/3f2c2c11-979f-48c4-a706-2e48a95e5b09" />


**Option B: minikube**
```bash
# Install minikube
# macOS
brew install minikube

# Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start a cluster
minikube start

# Verify
kubectl cluster-info
kubectl get nodes
```

Write down: Which one did you choose and why?

---

## Task 5: Explore Your Cluster
Now that your cluster is running, explore it:

```bash
# See cluster info
kubectl cluster-info

# List all nodes
kubectl get nodes

# Get detailed info about your node
kubectl describe node <node-name>

# List all namespaces
kubectl get namespaces

# See ALL pods running in the cluster (across all namespaces)
kubectl get pods -A
```

Look at the pods running in the `kube-system` namespace:
```bash
kubectl get pods -n kube-system
```
<img width="862" height="911" alt="task 5" src="https://github.com/user-attachments/assets/6dae0d89-12fc-4be4-b4e3-a0303866efa8" /><br/>
<img width="957" height="322" alt="task 5 b" src="https://github.com/user-attachments/assets/e5cadfa7-be56-49fb-8309-cd67bc6eeecd" /><br/>
<img width="837" height="217" alt="task 5 c" src="https://github.com/user-attachments/assets/91bc857e-be62-4fcd-822f-0bf5f8108284" /><br/>







You should see pods like `etcd`, `kube-apiserver`, `kube-scheduler`, `kube-controller-manager`, `coredns`, and `kube-proxy`. These are the architecture components you drew in Task 2 — running as pods inside the cluster.

**Verify:** Can you match each running pod in `kube-system` to a component in your architecture diagram?

---

## Task 6: Practice Cluster Lifecycle
Build muscle memory with cluster operations:

```bash
# Delete your cluster
kind delete cluster --name devops-cluster
# (or: minikube delete)

# Recreate it
kind create cluster --name devops-cluster
# (or: minikube start)

# Verify it is back
kubectl get nodes
```

Try these useful commands:
```bash
# Check which cluster kubectl is connected to
kubectl config current-context

# List all available contexts (clusters)
kubectl config get-contexts

# See the full kubeconfig
kubectl config view
```

<img width="607" height="657" alt="task 6" src="https://github.com/user-attachments/assets/4607b1bc-a35b-43fb-b3c0-08765e2c6c5c" />


Write down: What is a kubeconfig? Where is it stored on your machine?
    - file that tells kubectl which cluster to talk to, how to authenticate, and what settings to use.
    - /home/akashahir/.kube/config

---

