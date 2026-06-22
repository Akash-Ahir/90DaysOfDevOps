# Day 55 – Persistent Volumes (PV) and Persistent Volume Claims (PVC)

## Task
Containers are ephemeral — when a Pod dies, everything inside it disappears. That is a serious problem for databases and anything that needs to survive a restart. Today we fix this with Persistent Volumes and Persistent Volume Claims.

---


## Challenge Tasks

## Task 1: See the Problem — Data Lost on Pod Deletion
1. Write a Pod manifest that uses an `emptyDir` volume and writes a timestamped message to `/data/message.txt`
2. Apply it, verify the data exists with `kubectl exec`
3. Delete the Pod, recreate it, check the file again — the old message is gone

<img width="862" height="550" alt="task -1 1" src="https://github.com/user-attachments/assets/1fa7e68f-9265-4a3e-a6f7-478129706828" />


**Verify:** Is the timestamp the same or different after recreation?
  - The timestamp is different

---

## Task 2: Create a PersistentVolume (Static Provisioning)
1. Write a PV manifest with `capacity: 1Gi`, `accessModes: ReadWriteOnce`, `persistentVolumeReclaimPolicy: Retain`, and `hostPath` pointing to `/tmp/k8s-pv-data`
2. Apply it and check `kubectl get pv` — status should be `Available`

Access modes to know:
- `ReadWriteOnce (RWO)` — read-write by a single node
- `ReadOnlyMany (ROX)` — read-only by many nodes
- `ReadWriteMany (RWX)` — read-write by many nodes

`hostPath` is fine for learning, not for production.


<img width="1681" height="201" alt="task -2" src="https://github.com/user-attachments/assets/d1bd0ae0-9a36-4ef3-8c63-d2044a54eda7" /><br/>


**Verify:** What is the STATUS of the PV?
  - The status of pv is available

---

## Task 3: Create a PersistentVolumeClaim
1. Write a PVC manifest requesting `500Mi` of storage with `ReadWriteOnce` access
2. Apply it and check both `kubectl get pvc` and `kubectl get pv`
3. Both should show `Bound` — Kubernetes matched them by capacity and access mode

  <img width="1871" height="277" alt="task -3" src="https://github.com/user-attachments/assets/631a88fb-9303-46ce-9ab9-40996ba04ae3" /><br/>


**Verify:** What does the VOLUME column in `kubectl get pvc` show?
  -  PersistentVolume

---

## Task 4: Use the PVC in a Pod — Data That Survives
1. Write a Pod manifest that mounts the PVC at `/data` using `persistentVolumeClaim.claimName`
2. Write data to `/data/message.txt`, then delete and recreate the Pod
3. Check the file — it should contain data from both Pods

<img width="785" height="697" alt="task -4" src="https://github.com/user-attachments/assets/4647f84f-30bd-4813-bba6-c168c234d7cc" /><br/>


**Verify:** Does the file contain data from both the first and second Pod?
  - Yes, the file contain data from both pods

---

## Task 5: StorageClasses and Dynamic Provisioning
1. Run `kubectl get storageclass` and `kubectl describe storageclass`
2. Note the provisioner, reclaim policy, and volume binding mode
3. With dynamic provisioning, developers only create PVCs — the StorageClass handles PV creation automatically

<img width="1896" height="437" alt="task -5" src="https://github.com/user-attachments/assets/7dc7437e-7469-49df-9caa-2e4b8ddccfc1" />


**Verify:** What is the default StorageClass in your cluster?
  - Standard (default)

---

## Task 6: Dynamic Provisioning
1. Write a PVC manifest that includes `storageClassName: standard` (or your cluster's default)
2. Apply it — a PV should appear automatically in `kubectl get pv`


  <img width="1892" height="292" alt="task -6 1 a" src="https://github.com/user-attachments/assets/99c5a306-46b3-4291-a898-7626e61f62b3" /><br/>



**Verify:** How many PVs exist now? Which was manual, which was dynamic?
   -  2 pvs are tthere
         1) persistent-volume - this is the manual one 
         2) pvc-97c9a618-dcac-407f-ba98-d47ddec7830a - this is the dynamic one

---

  ## Key Learnings

- Containers are ephemeral and lose data when Pods are deleted.
- Persistent Volumes provide storage independent of Pod lifecycle.
- Persistent Volume Claims allow applications to request storage without knowing implementation details.
- Static provisioning requires manual PV creation.
- Dynamic provisioning automatically creates PVs through a StorageClass.
- Reclaim policies determine what happens to storage after PVC deletion.

---
