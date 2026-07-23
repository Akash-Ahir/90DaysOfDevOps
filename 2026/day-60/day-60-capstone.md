# Day 60 – Capstone: Deploy WordPress + MySQL on Kubernetes

## Task
Ten days of Kubernetes — clusters, Pods, Deployments, Services, ConfigMaps, Secrets, storage, StatefulSets, resource management, autoscaling, and Helm. Today you put it all together. Deploy a real WordPress + MySQL application using every major concept you have learned.


---

## Challenge Tasks

## Task 1: Create the Namespace (Day 52)
1. Create a `capstone` namespace
2. Set it as your default: `kubectl config set-context --current --namespace=capstone`

<img width="1077" height="367" alt="task-1" src="https://github.com/user-attachments/assets/372e97f3-3d42-4678-aa14-248fee76420d" />


---

## Task 2: Deploy MySQL (Days 54-56)
1. Create a Secret with `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`, and `MYSQL_PASSWORD` using `stringData`


<img width="731" height="177" alt="task-2 1" src="https://github.com/user-attachments/assets/e309aa56-5b19-4e12-82a7-cf2ca179a0ca" />


2. Create a Headless Service (`clusterIP: None`) for MySQL on port 3306

<img width="982" height="205" alt="task-2 2" src="https://github.com/user-attachments/assets/73a3c853-5d91-45e2-93d7-aebbcf0363fa" />


3. Create a StatefulSet for MySQL with:
   - Image: `mysql:8.0`
   - `envFrom` referencing the Secret
   - Resource requests (cpu: 250m, memory: 512Mi) and limits (cpu: 500m, memory: 1Gi)
   - A `volumeClaimTemplates` section requesting 1Gi of storage, mounted at `/var/lib/mysql`
4. Verify MySQL works: `kubectl exec -it mysql-0 -- mysql -u <user> -p<password> -e "SHOW DATABASES;"`

<img width="1396" height="432" alt="task-2 3" src="https://github.com/user-attachments/assets/b5136203-8fab-4f5e-b135-31aad8cd63c5" />


**Verify:** Can you see the `wordpress` database? -**YES**

---

## Task 3: Deploy WordPress (Days 52, 54, 57)
1. Create a ConfigMap with `WORDPRESS_DB_HOST` set to `mysql-0.mysql.capstone.svc.cluster.local:3306` and `WORDPRESS_DB_NAME`

<img width="751" height="217" alt="task-3 1" src="https://github.com/user-attachments/assets/a4c67e7e-8c58-482a-876b-a2f92ada78c7" />


2. Create a Deployment with 2 replicas using `wordpress:latest` that:
   - Uses `envFrom` for the ConfigMap
   - Uses `secretKeyRef` for `WORDPRESS_DB_USER` and `WORDPRESS_DB_PASSWORD` from the MySQL Secret
   - Has resource requests and limits
   - Has a liveness probe and readiness probe on `/wp-login.php` port 80
3. Wait until both pods show `1/1 Running`

<img width="1035" height="567" alt="task-3 2" src="https://github.com/user-attachments/assets/18b10abb-9638-48c1-b0d0-afe6b4ac616e" />



**Verify:** Are both WordPress pods running and ready? - **YES**

---

## Task 4: Expose WordPress (Day 53)
1. Create a NodePort Service on port 30080 targeting the WordPress pods
2. Access WordPress in your browser:
   - Minikube: `minikube service wordpress -n capstone`
   - Kind: `kubectl port-forward svc/wordpress 8080:80 -n capstone`
  
<img width="1157" height="652" alt="task-4 1" src="https://github.com/user-attachments/assets/bf45271e-937f-4ff5-a2dc-45f5ca7d3245" />


3. Complete the setup wizard and create a blog post

<img width="1897" height="976" alt="task-4 2" src="https://github.com/user-attachments/assets/6781b90c-d9e0-4c0d-b445-35db7f5e0c13" />


**Verify:** Can you see the WordPress setup page? - **YES**

---

## Task 5: Test Self-Healing and Persistence
1. Delete a WordPress pod — watch the Deployment recreate it within seconds. Refresh the site.
2. Delete the MySQL pod: `kubectl delete pod mysql-0 -n capstone` — watch the StatefulSet recreate it
3. After MySQL recovers, refresh WordPress — your blog post should still be there

<img width="1060" height="705" alt="task-5" src="https://github.com/user-attachments/assets/694250e9-9a41-406f-a7e3-901198e9cda8" />


**Verify:** After deleting both pods, is your blog post still there?- **YES**

---

## Task 6: Set Up HPA (Day 58)
1. Write an HPA manifest targeting the WordPress Deployment with CPU at 50%, min 2, max 10 replicas
2. Apply and check: `kubectl get hpa -n capstone`
3. Run `kubectl get all -n capstone` for the complete picture

<img width="1687" height="622" alt="task-6" src="https://github.com/user-attachments/assets/73b49f5c-8157-4afc-851c-5de22473214e" />



**Verify:** Does the HPA show correct min/max and target? - **YES**

---

## Task 7: (Bonus) Compare with Helm (Day 59)
1. Install WordPress using `helm install wp-helm bitnami/wordpress` in a separate namespace
<img width="1416" height="420" alt="task-7 1" src="https://github.com/user-attachments/assets/ad1cb518-2384-452b-b66d-07da76fdb247" />


2. Compare: how many resources did each approach create? Which gives more control?
<img width="1512" height="935" alt="task-7 2" src="https://github.com/user-attachments/assets/baf93650-9968-454e-96db-57e8bd94d90a" />


3. Clean up the Helm deployment


---

