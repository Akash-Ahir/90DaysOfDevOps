# Day 58 – Metrics Server and Horizontal Pod Autoscaler (HPA)

## Task
Yesterday you set resource requests and limits. Today you put that to work. Install the Metrics Server so Kubernetes can see actual resource usage, then set up a Horizontal Pod Autoscaler that scales your app up under load and back down when things calm down.

---

## Challenge Tasks

## Task 1: Install the Metrics Server
1. Check if it is already running: `kubectl get pods -n kube-system | grep metrics-server`
2. If not, install it:
   - Minikube: `minikube addons enable metrics-server`
   - Kind/kubeadm: apply the official manifest from the metrics-server GitHub releases
3. On local clusters, you may need the `--kubelet-insecure-tls` flag (never in production)
4. Wait 60 seconds, then verify: `kubectl top nodes` and `kubectl top pods -A`

**Verify:** What is the current CPU and memory usage of your node?
<img width="1037" height="686" alt="task 1" src="https://github.com/user-attachments/assets/79a7542a-21a1-46fc-8441-d08a2bf2e06a" />


---

## Task 2: Explore kubectl top
1. Run `kubectl top nodes`, `kubectl top pods -A`, `kubectl top pods -A --sort-by=cpu`
2. `kubectl top` shows real-time usage, not requests or limits — these are different things
3. Data comes from the Metrics Server, which polls kubelets every 15 seconds

<img width="880" height="692" alt="task 2" src="https://github.com/user-attachments/assets/439321ae-2c4b-40d6-a373-4b0b34ab1fe4" />


**Verify:** Which pod is using the most CPU right now?
  - kube-apiserver-devops-cluster-control-plane using the most cpu right now 

---

## Task 3: Create a Deployment with CPU Requests
1. Write a Deployment manifest using the `registry.k8s.io/hpa-example` image (a CPU-intensive PHP-Apache server)
2. Set `resources.requests.cpu: 200m` — HPA needs this to calculate utilization percentages
3. Expose it as a Service: `kubectl expose deployment php-apache --port=80`

<img width="1070" height="662" alt="task 3" src="https://github.com/user-attachments/assets/f7752856-e9ac-4790-aa04-f743d2d96789" />


Without CPU requests, HPA cannot work — this is the most common HPA setup mistake.

**Verify:** What is the current CPU usage of the Pod?- 1m

---

## Task 4: Create an HPA (Imperative)
1. Run: `kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10`
2. Check: `kubectl get hpa` and `kubectl describe hpa php-apache`
3. TARGETS may show `<unknown>` initially — wait 30 seconds for metrics to arrive

This scales up when average CPU exceeds 50% of requests, and down when it drops below.


<img width="1892" height="582" alt="task 4" src="https://github.com/user-attachments/assets/5a2d4cf1-6468-45d2-9af4-e6f1aab10632" />


**Verify:** What does the TARGETS column show?
    - Its show <unknown> for first few secpnds and after that it show 0% and varies according to the cpu utilization

---

## Task 5: Generate Load and Watch Autoscaling
1. Start a load generator: `kubectl run load-generator --image=busybox:1.36 --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://php-apache; done"`
2. Watch HPA: `kubectl get hpa php-apache --watch`
3. Over 1-3 minutes, CPU climbs above 50%, replicas increase, CPU stabilizes
4. Stop the load: `kubectl delete pod load-generator`
5. Scale-down is slow (5-minute stabilization window) — you do not need to wait


<img width="1872" height="940" alt="task 5" src="https://github.com/user-attachments/assets/1bd41e75-ee7f-43c0-959c-542237893128" />

<img width="1057" height="905" alt="task 5 3" src="https://github.com/user-attachments/assets/c9c07d86-b170-4746-a1b9-2882dbdc3a7f" />

**Verify:** How many replicas did HPA scale to under load? -9

---

## Task 6: Create an HPA from YAML (Declarative)
1. Delete the imperative HPA: `kubectl delete hpa php-apache`
2. Write an HPA manifest using `autoscaling/v2` API with CPU target at 50% utilization
3. Add a `behavior` section to control scale-up speed (no stabilization) and scale-down speed (300 second window)
4. Apply and verify with `kubectl describe hpa`

<img width="1861" height="912" alt="task 6" src="https://github.com/user-attachments/assets/56b4d8c1-4f1e-4372-b342-e4849e6f8667" />


`autoscaling/v2` supports multiple metrics and fine-grained scaling behavior that the imperative command cannot configure.





**Verify:** What does the `behavior` section control?
    -It controls how aggressively the HPA changes the number of replicas.

---

