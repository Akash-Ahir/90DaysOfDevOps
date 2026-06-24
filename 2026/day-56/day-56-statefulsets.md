# Day 56 – Kubernetes StatefulSets

## Task
Deployments work great for stateless apps, but what about databases? You need stable pod names, ordered startup, and persistent storage per replica. Today you learn StatefulSets — the workload designed for stateful applications like MySQL, PostgreSQL, and Kafka.

---

## Challenge Tasks

## Task 1: Understand the Problem
1. Create a Deployment with 3 replicas using nginx
2. Check the pod names — they are random (`app-xyz-abc`)
3. Delete a pod and notice the replacement gets a different random name

This is fine for web servers but not for databases where you need stable identity.

| Feature | Deployment | StatefulSet |
|---|---|---|
| Pod names | Random | Stable, ordered (`app-0`, `app-1`) |
| Startup order | All at once | Ordered: pod-0, then pod-1, then pod-2 |
| Storage | Shared PVC | Each pod gets its own PVC |
| Network identity | No stable hostname | Stable DNS per pod |

Delete the Deployment before moving on.


#### [nginx-deployment.yml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-56/Manifest-file/nginx-deployment.yml)<br/>



<img width="1447" height="485" alt="task-1" src="https://github.com/user-attachments/assets/c3209116-9910-471f-84b9-a53a25afd212" />


**Verify:** Why would random pod names be a problem for a database cluster?
   - Random pod names make it difficult for database nodes to identify and communicate with each other

---

## Task 2: Create a Headless Service
1. Write a Service manifest with `clusterIP: None` — this is a Headless Service
2. Set the selector to match the labels you will use on your StatefulSet pods
3. Apply it and confirm CLUSTER-IP shows `None`

A Headless Service creates individual DNS entries for each pod instead of load-balancing to one IP. StatefulSets require this.


#### [headless-service.yml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-56/Manifest-file/headless-service.yml)<br/>


<img width="982" height="292" alt="task-2" src="https://github.com/user-attachments/assets/f4cc16db-f983-42ab-b841-7235dee9d3a0" />


**Verify:** What does the CLUSTER-IP column show?
   the cluuster-ip column show : None

---

## Task 3: Create a StatefulSet
1. Write a StatefulSet manifest with `serviceName` pointing to your Headless Service
2. Set replicas to 3, use the nginx image
3. Add a `volumeClaimTemplates` section requesting 100Mi of ReadWriteOnce storage
4. Apply and watch: `kubectl get pods -l <your-label> -w`

Observe ordered creation — `web-0` first, then `web-1` after `web-0` is Ready, then `web-2`.

Check the PVCs: `kubectl get pvc` — you should see `web-data-web-0`, `web-data-web-1`, `web-data-web-2` (names follow the pattern `<template-name>-<pod-name>`).


#### [statefulset.yml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-56/Manifest-file/statefulset.yml)<br/>


<img width="1897" height="842" alt="task-3" src="https://github.com/user-attachments/assets/af83729a-40b3-4403-94a1-6e55f7bc423b" />


**Verify:** What are the exact pod names and PVC names?
   
   Pods:
   - web-0
   - web-1
   - web-2
   
   PVCs:
   - web-volume-web-0
   - web-volume-web-1
   - web-volume-web-2

---

## Task 4: Stable Network Identity
Each StatefulSet pod gets a DNS name: `<pod-name>.<service-name>.<namespace>.svc.cluster.local`

1. Run a temporary busybox pod and use `nslookup` to resolve `web-0.<your-headless-service>.default.svc.cluster.local`
2. Do the same for `web-1` and `web-2`
3. Confirm the IPs match `kubectl get pods -o wide`

<img width="1896" height="712" alt="task-4 1" src="https://github.com/user-attachments/assets/17153a22-948b-46ea-8032-460827f0568e" />
<img width="1892" height="880" alt="task-4 2" src="https://github.com/user-attachments/assets/9b9a8094-c547-4dbb-a89d-9a50782fee5e" />



**Verify:** Does the nslookup IP match the pod IP?-YES

---

## Task 5: Stable Storage — Data Survives Pod Deletion
1. Write unique data to each pod: `kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"`
2. Delete `web-0`: `kubectl delete pod web-0`
3. Wait for it to come back, then check the data — it should still be "Data from web-0"

The new pod reconnected to the same PVC.

<img width="1502" height="632" alt="task-5" src="https://github.com/user-attachments/assets/54808f93-901f-494a-91c1-a95b2f1cd102" />


**Verify:** Is the data identical after pod recreation?-YES

---

## Task 6: Ordered Scaling
1. Scale up to 5: `kubectl scale statefulset web --replicas=5` — pods create in order (web-3, then web-4)
2. Scale down to 3 — pods terminate in reverse order (web-4, then web-3)
3. Check `kubectl get pvc` — all five PVCs still exist. Kubernetes keeps them on scale-down so data is preserved if you scale back up.

<img width="1767" height="895" alt="task-6 1" src="https://github.com/user-attachments/assets/862301b4-8833-42a9-9021-410a618f369e" />
<img width="1720" height="536" alt="task-6 2" src="https://github.com/user-attachments/assets/d4820773-f24e-49b7-8b7c-fb6f809a7119" />

## Key Takeaways

- Deployments are best for stateless applications.
- StatefulSets provide stable pod identities and DNS names.
- Each StatefulSet pod gets its own Persistent Volume Claim.
- Data survives pod recreation because storage remains attached to the pod identity.
- Scaling down does not remove PVCs, preventing accidental data loss.



**Verify:** After scaling down, how many PVCs exist? -5

---
