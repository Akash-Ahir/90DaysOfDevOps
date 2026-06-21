# Day 54 – Kubernetes ConfigMaps and Secrets

## Task Overview
Your application needs configuration — database URLs, feature flags, API keys. Hardcoding these into container images means rebuilding every time a value changes. Kubernetes solves this with ConfigMaps for non-sensitive config and Secrets for sensitive data.

---

## Challenge Tasks

## Task 1: Create a ConfigMap from Literals
1. Use `kubectl create configmap` with `--from-literal` to create a ConfigMap called `app-config` with keys `APP_ENV=production`, `APP_DEBUG=false`, and `APP_PORT=8080`
2. Inspect it with `kubectl describe configmap app-config` and `kubectl get configmap app-config -o yaml`
3. Notice the data is stored as plain text — no encoding, no encryption

<img width="817" height="942" alt="task-1" src="https://github.com/user-attachments/assets/f7e5a98c-b7f3-4de2-9dda-b559922ea52f" />


**Verify:** Can you see all three key-value pairs?-Yes

---

## Task 2: Create a ConfigMap from a File
1. Write a custom Nginx config file that adds a `/health` endpoint returning "healthy"
2. Create a ConfigMap from this file using `kubectl create configmap nginx-config --from-file=default.conf=<your-file>`
3. The key name (`default.conf`) becomes the filename when mounted into a Pod

#### [nginx-configmap.yml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-54/Manifest-file/nginx-configmap.yml)<br/>



<img width="1230" height="551" alt="task-2" src="https://github.com/user-attachments/assets/b45015f5-cffc-4b51-80a3-831bc9404bf5" />




**Verify:** Does `kubectl get configmap nginx-config -o yaml` show the file contents?-yes

---

## Task 3: Use ConfigMaps in a Pod
1. Write a Pod manifest that uses `envFrom` with `configMapRef` to inject all keys from `app-config` as environment variables. Use a busybox container that prints the values.

#### [nginx-configmap-pod.yml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-54/Manifest-file/nginx-configmap-pod.yml)<br/>


<img width="802" height="247" alt="task-3 1" src="https://github.com/user-attachments/assets/abf06e1c-493c-41e6-8961-7de07f5dba0c" />


2. Write a second Pod manifest that mounts `nginx-config` as a volume at `/etc/nginx/conf.d`. Use the nginx image.

#### [nginx-pod.yml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-54/Manifest-file/nginx-pod.yml)<br/>


<img width="931" height="197" alt="task-3 2" src="https://github.com/user-attachments/assets/c1039463-7b96-4d6b-80c5-56f1bcbb1851" />

3. Test that the mounted config works: `kubectl exec <pod> -- curl -s http://localhost/health`

Use environment variables for simple key-value settings. Use volume mounts for full config files.

**Verify:** Does the `/health` endpoint respond?-yes

---

## Task 4: Create a Secret
1. Use `kubectl create secret generic db-credentials` with `--from-literal` to store `DB_USER=admin` and `DB_PASSWORD=s3cureP@ssw0rd`
2. Inspect with `kubectl get secret db-credentials -o yaml` — the values are base64-encoded
3. Decode a value: `echo '<base64-value>' | base64 --decode`

<img width="1617" height="390" alt="task-4 1" src="https://github.com/user-attachments/assets/d82a1300-7ed2-475b-b408-080d56e516e6" />


**base64 is encoding, not encryption.** Anyone with cluster access can decode Secrets. The real advantages are RBAC separation, tmpfs storage on nodes, and optional encryption at rest.

**Verify:** Can you decode the password back to plaintext?-yes

---

## Task 5: Use Secrets in a Pod
1. Write a Pod manifest that injects `DB_USER` as an environment variable using `secretKeyRef`
2. In the same Pod, mount the entire `db-credentials` Secret as a volume at `/etc/db-credentials` with `readOnly: true`
3. Verify: each Secret key becomes a file, and the content is the decoded plaintext value

#### [secretpod.yaml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-54/Manifest-file/secretpod.yaml)<br/>


<img width="796" height="336" alt="task-5" src="https://github.com/user-attachments/assets/40484c20-9463-4745-9557-f8a57b2e94bc" />


**Verify:** Are the mounted file values plaintext or base64?-plaintext

---

## Task 6: Update a ConfigMap and Observe Propagation
1. Create a ConfigMap `live-config` with a key `message=hello`
2. Write a Pod that mounts this ConfigMap as a volume and reads the file in a loop every 5 seconds

<img width="1075" height="421" alt="task-6 1" src="https://github.com/user-attachments/assets/baf5ed1a-0899-4a86-bbee-32f048bd299d" />


3. Update the ConfigMap: `kubectl patch configmap live-config --type merge -p '{"data":{"message":"world"}}'`
4. Wait 30-60 seconds — the volume-mounted value updates automatically
5. Environment variables from earlier tasks do NOT update — they are set at pod startup only


<img width="1361" height="462" alt="task-6 2" src="https://github.com/user-attachments/assets/656717d4-a64b-4412-b9a2-4745c7a363d8" />


#### [live-configmap-pod.yaml](https://github.com/Akash-Ahir/90DaysOfDevOps/blob/master/2026/day-54/Manifest-file/live-configmap-pod.yaml)<br/>



## Key Learnings

- ConfigMaps are used to store non-sensitive configuration data.
- Secrets are used to store sensitive information such as passwords and API keys.
- ConfigMap data is stored as plain text.
- Secret data is Base64 encoded, not encrypted.
- Environment variables are loaded only when a Pod starts.
- ConfigMaps and Secrets mounted as volumes can update automatically.
- Each Secret key becomes a separate file when mounted as a volume.
- Separating configuration from container images improves maintainability and portability.




**Verify:** Did the volume-mounted value change without a pod restart?-yes

---
