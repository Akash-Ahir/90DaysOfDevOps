# Day 52 – Kubernetes Namespaces and Deployments

## Task Overview
Yesterday you created standalone Pods. The problem? Delete a Pod and it is gone forever — no one recreates it. Today you fix that with Deployments, the real way to run applications in Kubernetes. You will also learn Namespaces, which let you organize and isolate resources inside a cluster.

---



## Challenge Tasks

## Task 1: Explore Default Namespaces
Kubernetes comes with built-in namespaces. List them:

```bash
kubectl get namespaces
```

You should see at least:
- `default` — where your resources go if you do not specify a namespace
- `kube-system` — Kubernetes internal components (API server, scheduler, etc.)
- `kube-public` — publicly readable resources
- `kube-node-lease` — node heartbeat tracking

Check what is running inside `kube-system`:
```bash
kubectl get pods -n kube-system
```

These are the control plane components keeping your cluster alive. Do not touch them.

<img width="1237" height="647" alt="task 1" src="https://github.com/user-attachments/assets/3a789302-83ea-45f6-9536-65a5c4eee2a2" />


**Verify:** How many pods are running in `kube-system`?
  - 14 pods are running in kube-system

---

## Task 2: Create and Use Custom Namespaces
Create two namespaces — one for a development environment and one for staging:

```bash
kubectl create namespace dev
kubectl create namespace staging
```

Verify they exist:
```bash
kubectl get namespaces
```

You can also create a namespace from a manifest:
```yaml
# namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

```bash
kubectl apply -f namespace.yaml
```

<img width="842" height="512" alt="task 2 1" src="https://github.com/user-attachments/assets/3b5d0347-0e69-4819-a6b2-a162e6443c5b" /><br/>


Now run a pod in a specific namespace:
```bash
kubectl run nginx-dev --image=nginx:latest -n dev
kubectl run nginx-staging --image=nginx:latest -n staging
```

List pods across all namespaces:
```bash
kubectl get pods -A
```

<img width="1482" height="637" alt="task 2 2" src="https://github.com/user-attachments/assets/dbf20a9f-39bf-487b-b5df-45ebc21c7e2c" />


Notice that `kubectl get pods` without `-n` only shows the `default` namespace. You must specify `-n <namespace>` or use `-A` to see everything.

**Verify:** Does `kubectl get pods` show these pods? What about `kubectl get pods -A`?
    `kubectl get pods` - will show only default namespace pod 
     `kubectl get pods -A` - will show pods across all namespace

---

## Task 3: Create Your First Deployment
A Deployment tells Kubernetes: "I want X replicas of this Pod running at all times." If a Pod crashes, the Deployment controller recreates it automatically.

Create a file `nginx-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: dev
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
```

Key differences from a standalone Pod:
- `kind: Deployment` instead of `kind: Pod`
- `apiVersion: apps/v1` instead of `v1`
- `replicas: 3` tells Kubernetes to maintain 3 identical pods
- `selector.matchLabels` connects the Deployment to its Pods
- `template` is the Pod template — the Deployment creates Pods using this blueprint

Apply it:
```bash
kubectl apply -f nginx-deployment.yaml
```

Check the result:
```bash
kubectl get deployments -n dev
kubectl get pods -n dev
```
<img width="977" height="447" alt="task 3" src="https://github.com/user-attachments/assets/b9f06d47-ea96-4d16-b459-89203f1f7157" />


You should see 3 pods with names like `nginx-deployment-xxxxx-yyyyy`.

**Verify:** What do the READY, UP-TO-DATE, and AVAILABLE columns mean in the deployment output?

  `READY` - current ready replicas to desired state 
  
  `UP-TO-DATE` - pods running with the updated specification
  
  `AVAILABLE` - Number of replicas running and ready to serve traffic

---

## Task 4: Self-Healing — Delete a Pod and Watch It Come Back
This is the key difference between a Deployment and a standalone Pod.

```bash
# List pods
kubectl get pods -n dev

# Delete one of the deployment's pods (use an actual pod name from your output)
kubectl delete pod <pod-name> -n dev

# Immediately check again
kubectl get pods -n dev
```
<img width="1186" height="447" alt="task 4" src="https://github.com/user-attachments/assets/583d61a5-76b8-4381-844b-7732a7a2bd47" />


The Deployment controller detects that only 2 of 3 desired replicas exist and immediately creates a new one. The deleted pod is replaced within seconds.

**Verify:** Is the replacement pod's name the same as the one you deleted, or different?
    - The name of the replacement pods is different 

---

## Task 5: Scale the Deployment
Change the number of replicas:

```bash
# Scale up to 5
kubectl scale deployment nginx-deployment --replicas=5 -n dev
kubectl get pods -n dev

# Scale down to 2
kubectl scale deployment nginx-deployment --replicas=2 -n dev
kubectl get pods -n dev
```

<img width="1230" height="477" alt="task 5" src="https://github.com/user-attachments/assets/cbb68a63-0d3d-460d-b138-8c2e8f1e1afe" />


Watch how Kubernetes creates or terminates pods to match the desired count.

You can also scale by editing the manifest — change `replicas: 4` in your YAML file and run `kubectl apply -f nginx-deployment.yaml` again.

**Verify:** When you scaled down from 5 to 2, what happened to the extra pods?
  - Kubernetes terminated 3 extra pods automatically the ReplicaSet controller ensures only 2 pods remain running

---

### Task 6: Rolling Update
Update the Nginx image version to trigger a rolling update:

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
```

Watch the rollout in real time:
```bash
kubectl rollout status deployment/nginx-deployment -n dev
```

<img width="1906" height="545" alt="task 6 1" src="https://github.com/user-attachments/assets/b2affd8e-6110-4a1c-ad93-35f4cd9402a8" />


Kubernetes replaces pods one by one — old pods are terminated only after new ones are healthy. This means zero downtime.

Check the rollout history:
```bash
kubectl rollout history deployment/nginx-deployment -n dev
```

Now roll back to the previous version:
```bash
kubectl rollout undo deployment/nginx-deployment -n dev
kubectl rollout status deployment/nginx-deployment -n dev
```


```bash
kubectl describe deployment nginx-deployment -n dev | grep Image
```


Verify the image is back to the previous version:
<img width="927" height="957" alt="task 6 3" src="https://github.com/user-attachments/assets/a98e0261-499a-47ca-8436-fdad8431cdb8" />

<img width="1157" height="80" alt="task 6 4" src="https://github.com/user-attachments/assets/682d1c1f-f7ad-4610-9fac-f70fb167fa39" />



<img width="1888" height="973" alt="task 6 2" src="https://github.com/user-attachments/assets/fe046f41-9e14-46e0-ab8a-0f5006b76e6f" />


**Verify:** What image version is running after the rollback?
  - nginx:1.24

---

### Task 7: Clean Up
```bash
kubectl delete deployment nginx-deployment -n dev
kubectl delete pod nginx-dev -n dev
kubectl delete pod nginx-staging -n staging
kubectl delete namespace dev staging production
```

Deleting a namespace removes everything inside it. Be very careful with this in production.

```bash
kubectl get namespaces
kubectl get pods -A
```
<img width="1385" height="851" alt="task 7" src="https://github.com/user-attachments/assets/d00a92a6-ae35-4889-8c38-1abfdaf5843a" />

---

