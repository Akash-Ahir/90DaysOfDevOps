# Day 57 – Resource Requests, Limits, and Probes

## Task
Your Pods are running, but Kubernetes has no idea how much CPU or memory they need — and no way to tell if they are actually healthy. Today you set resource requests and limits for smart scheduling, then add probes so Kubernetes can detect and recover from failures automatically.

---

## Challenge Tasks

## Task 1: Resource Requests and Limits
1. Write a Pod manifest with `resources.requests` (cpu: 100m, memory: 128Mi) and `resources.limits` (cpu: 250m, memory: 256Mi)
2. Apply and inspect with `kubectl describe pod` — look for the Requests, Limits, and QoS Class sections
3. Since requests and limits differ, the QoS class is `Burstable`. If equal, it would be `Guaranteed`. If missing, `BestEffort`.

CPU is in millicores: `100m` = 0.1 CPU. Memory is in mebibytes: `128Mi`.

**Requests** = guaranteed minimum (scheduler uses this for placement). **Limits** = maximum allowed (kubelet enforces at runtime).


<img width="1880" height="965" alt="task-1" src="https://github.com/user-attachments/assets/4b56e2ca-ab05-4e3e-95c8-d2000b6eb081" />


**Verify:** What QoS class does your Pod have?
  - Burstable

---

## Task 2: OOMKilled — Exceeding Memory Limits
1. Write a Pod manifest using the `polinux/stress` image with a memory limit of `100Mi`
2. Set the stress command to allocate 200M of memory: `command: ["stress"] args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]`
3. Apply and watch — the container gets killed immediately

CPU is throttled when over limit. Memory is killed — no mercy.

Check `kubectl describe pod` for `Reason: OOMKilled` and `Exit Code: 137` (128 + SIGKILL).

<img width="881" height="922" alt="task-2" src="https://github.com/user-attachments/assets/b9729bd7-17af-4664-88ab-4792ddb91e27" />


**Verify:** What exit code does an OOMKilled container have?
  - 137


---

## Task 3: Pending Pod — Requesting Too Much
1. Write a Pod manifest requesting `cpu: 100` and `memory: 128Gi`
2. Apply and check — STATUS stays `Pending` forever
3. Run `kubectl describe pod` and read the Events — the scheduler says exactly why: insufficient resources

<img width="742" height="360" alt="task-3 1" src="https://github.com/user-attachments/assets/b60cfd7c-51e8-4cf2-8901-6b3969a97cd0" />


**Verify:** What event message does the scheduler produce?
<img width="916" height="240" alt="task-3 2" src="https://github.com/user-attachments/assets/251a9eb8-4b5e-4912-ab28-5666f1320974" />


---

## Task 4: Liveness Probe
A liveness probe detects stuck containers. If it fails, Kubernetes restarts the container.

1. Write a Pod manifest with a busybox container that creates `/tmp/healthy` on startup, then deletes it after 30 seconds
2. Add a liveness probe using `exec` that runs `cat /tmp/healthy`, with `periodSeconds: 5` and `failureThreshold: 3`
3. After the file is deleted, 3 consecutive failures trigger a restart. Watch with `kubectl get pod -w`




**Verify:** How many times has the container restarted?
  - 3 times 

---

## Task 5: Readiness Probe
A readiness probe controls traffic. Failure removes the Pod from Service endpoints but does NOT restart it.

1. Write a Pod manifest with nginx and a `readinessProbe` using `httpGet` on path `/` port `80`
2. Expose it as a Service: `kubectl expose pod <name> --port=80 --name=readiness-svc`
3. Check `kubectl get endpoints readiness-svc` — the Pod IP is listed
4. Break the probe: `kubectl exec <pod> -- rm /usr/share/nginx/html/index.html`
5. Wait 15 seconds — Pod shows `0/1` READY, endpoints are empty, but the container is NOT restarted

<img width="1166" height="712" alt="task-5 1" src="https://github.com/user-attachments/assets/32bfebe1-e802-4609-8313-4d6d4ac592b1" />


<img width="1075" height="97" alt="task-5 2" src="https://github.com/user-attachments/assets/c9c76e24-ebfb-4fba-9dae-3e171c05bc92" />


<img width="1860" height="252" alt="task-5 3" src="https://github.com/user-attachments/assets/bed04555-4df9-4888-a859-86e1cf335d50" />




**Verify:** When readiness failed, was the container restarted? -No

---

## Task 6: Startup Probe
A startup probe gives slow-starting containers extra time. While it runs, liveness and readiness probes are disabled.

1. Write a Pod manifest where the container takes 20 seconds to start (e.g., `sleep 20 && touch /tmp/started`)
2. Add a `startupProbe` checking for `/tmp/started` with `periodSeconds: 5` and `failureThreshold: 12` (60 second budget)
3. Add a `livenessProbe` that checks the same file — it only kicks in after startup succeeds

<img width="900" height="421" alt="task-6" src="https://github.com/user-attachments/assets/79846b7d-410b-425d-a19a-9d8a0b7d344f" />


<img width="1880" height="235" alt="task-6 2" src="https://github.com/user-attachments/assets/fc7e0686-b823-431c-809a-7b472c4aa085" />


<img width="845" height="300" alt="task-6 3" src="https://github.com/user-attachments/assets/0fd6de69-6a05-49aa-b961-cd3c11c7e9b4" />




**Verify:** What would happen if `failureThreshold` were 2 instead of 12?
- With failureThreshold: 2 and periodSeconds: 5, Kubernetes allows only about 10 seconds for the application to start. Since the container takes 20 seconds to create /tmp/started, the startup probe fails twice, Kubernetes restarts the container, and the Pod keeps restarting without ever becoming healthy

---

