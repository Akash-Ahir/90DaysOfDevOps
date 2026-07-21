# Day 59 – Helm — Kubernetes Package Manager

## Task
Over the past eight days you have written Deployments, Services, ConfigMaps, Secrets, PVCs, and more — all as individual YAML files. For a real application you might have dozens of these. Helm is the package manager for Kubernetes, like apt for Ubuntu. Today you install charts, customize them, and create your own.

---

## Challenge Tasks

## Task 1: Install Helm
1. Install Helm (brew, curl script, or chocolatey depending on your OS)
2. Verify with `helm version` and `helm env`

<img width="1892" height="165" alt="task 1" src="https://github.com/user-attachments/assets/f26ca504-a14b-431b-bdda-30544540363d" />


Three core concepts:
- **Chart** — a package of Kubernetes manifest templates
- **Release** — a specific installation of a chart in your cluster
- **Repository** — a collection of charts (like a package repo)

**Verify:** What version of Helm is installed?
  - version.BuildInfo{Version:"v4.2.3", GitCommit:"43e8b7feece8beb0fcba47059ec9b522fd929a64", GitTreeState:"clean", GoVersion:"go1.26.5", KubeClientVersion:"v1.36"}

---

## Task 2: Add a Repository and Search
1. Add the Bitnami repository: `helm repo add bitnami https://charts.bitnami.com/bitnami`
2. Update: `helm repo update`
3. Search: `helm search repo nginx` and `helm search repo bitnami`

<img width="1851" height="551" alt="task 2" src="https://github.com/user-attachments/assets/e4888ee0-a043-429b-b837-0956c71b5cf8" />


**Verify:** How many charts does Bitnami have?
    - helm search repo bitnami | wc -l
      -145
---

## Task 3: Install a Chart
1. Deploy nginx: `helm install my-nginx bitnami/nginx`
<img width="782" height="266" alt="task 3" src="https://github.com/user-attachments/assets/853b71d3-2c86-4f5c-af25-ff7967dd86d2" />


2. Check what was created: `kubectl get all`
<img width="1125" height="315" alt="task 3 2" src="https://github.com/user-attachments/assets/fb306d7f-1d26-4a50-9b8c-225cad57b5ae" />



3. Inspect the release: `helm list`, `helm status my-nginx`, `helm get manifest my-nginx`
<img width="1412" height="281" alt="task 3 4" src="https://github.com/user-attachments/assets/032e8d0e-cead-4ee1-b4b5-fa11b165edc4" />



One command replaced writing a Deployment, Service, and ConfigMap by hand.


**Verify:** How many Pods are running? What Service type was created?
  - `1 pod` is running,  Service type  `LoadBalancer`

---

## Task 4: Customize with Values
1. View defaults: `helm show values bitnami/nginx`
2. Install a custom release with `--set replicaCount=3 --set service.type=NodePort`
<img width="1887" height="792" alt="task 4 1" src="https://github.com/user-attachments/assets/8c715c08-e367-46cb-8d59-076ab5c78911" />
<img width="1050" height="401" alt="task 4 2" src="https://github.com/user-attachments/assets/ad52be40-3f89-4cce-b8e5-ba85dbc0e496" />


3. Create a `custom-values.yaml` file with replicaCount, service type, and resource limits
4. Install another release using `-f custom-values.yaml`
5. Check overrides: `helm get values <release-name>`
<img width="1812" height="915" alt="task 4 3" src="https://github.com/user-attachments/assets/ae39ef0a-d182-43ba-9c61-9d7d221d9f10" />



**Verify:** Does the values file release have the correct replicas and service type? -yes

---

## Task 5: Upgrade and Rollback
1. Upgrade: `helm upgrade my-nginx bitnami/nginx --set replicaCount=5`
<img width="1905" height="970" alt="task 5 1" src="https://github.com/user-attachments/assets/b3a83663-adad-411c-b7e6-7a9a0744f826" />


2. Check history: `helm history my-nginx`
3. Rollback: `helm rollback my-nginx 1`
4. Check history again — rollback creates a new revision (3), not overwriting revision 2

<img width="1122" height="585" alt="task 5 2" src="https://github.com/user-attachments/assets/bb0b62e0-bcd7-4b75-af83-b08446dd66ef" />


Same concept as Deployment rollouts from Day 52, but at the full stack level.

**Verify:** How many revisions after the rollback?
  - 3

---

## Task 6: Create Your Own Chart
1. Scaffold: `helm create my-app`
2. Explore the directory: `Chart.yaml`, `values.yaml`, `templates/deployment.yaml`
<img width="1007" height="545" alt="task 6 1" src="https://github.com/user-attachments/assets/36736535-6bdd-45f3-9fec-3138be748e41" />
<img width="1011" height="942" alt="task 6 3" src="https://github.com/user-attachments/assets/f1b22012-6519-41c7-a920-ef8d8462e8b8" />



3. Look at the Go template syntax in templates: `{{ .Values.replicaCount }}`, `{{ .Chart.Name }}`
<img width="1736" height="957" alt="task 6 2" src="https://github.com/user-attachments/assets/33bf947a-b518-4f30-a0b2-0194beb881bf" />


4. Edit `values.yaml` — set replicaCount to 3 and image to nginx:1.25
<img width="682" height="192" alt="task 6 4" src="https://github.com/user-attachments/assets/c1e88c90-bd69-4dea-bcb0-c968c5c0a343" />


5. Validate: `helm lint my-app`
<img width="432" height="117" alt="task 6 5" src="https://github.com/user-attachments/assets/65c94ca6-4a8a-409d-ab4d-e2b0830d6eb2" />


6. Preview: `helm template my-release ./my-app`
<img width="451" height="752" alt="task 6 6" src="https://github.com/user-attachments/assets/1037a60f-db83-435c-a317-d13c56357b52" />


7. Install: `helm install my-release ./my-app`
8. Upgrade: `helm upgrade my-release ./my-app --set replicaCount=5`
<img width="1596" height="942" alt="task 6 7" src="https://github.com/user-attachments/assets/df721ec6-4fa5-4a66-99ea-37d29e777c58" />



**Verify:** After installing, 3 replicas? After upgrading, 5? -yes

---

