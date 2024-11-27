Here’s the updated README with the additional link for Task 1:

---

# Kubernetes Task List

## Topics Covered:

1. **Kube Config Basics**
2. **Service Account vs User Account** - General Concept
3. **Pod Basics**
4. **YAML Basics**
5. **Service Basics**
6. **Port Forwarding**
7. **Deployments, Replica Sets, Namespaces, Daemon Sets, Stateful Sets**

---

## Tasks

### Normal Tasks

| S.No | Task Description | Relevant Links |
|------|------------------|----------------|
| 1    | Spin up a simple Nginx pod, expose it via a service, and access it on localhost (Check what to do for accessing from localhost). | [Kubernetes Service Tutorial](https://kubernetes.io/docs/tutorials/services/connect-applications-service/), [Port Forwarding Access](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) |
| 2    | Deploy the above single pod using a Deployment and set replicas as 2. | N/A |
| 3    | Deploy a MySQL StatefulSet application with 3 replicas and configure a volume of 5Gi each. | [StatefulSet Deployment Guide](https://kubernetes.io/docs/tasks/run-application/run-replicated-stateful-application/) |
| 4    | Complete the below operations: <br> 1. Create a custom Nginx image, push it to Docker Hub/ECR, and pull the image.<br> 2. Create a `deployment.yaml` with the custom Nginx image and deploy it in the Kubernetes cluster.<br> 3. Create `service.yaml` to route traffic to the created pod, expose it to the outside world, and verify. | [Using Secrets to Pull Images from Private Registries](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-pod-that-uses-your-secret) |

---

### Debugging Tasks

| Task Description | Relevant Links |
|------------------|----------------|
| Check for the deployment name `task-05-nginx-deployment` in your namespace. If facing an issue with pod creation, try to identify and fix the issue. | N/A |
| Learn about **Service Accounts** and how they link with Pods. | N/A |

---

## Notes

### Kubernetes Concepts:

1. **Service Account vs User Account**:  
   - **Service Account**: A Kubernetes service account provides an identity for processes that run in a pod. It allows pods to interact with the Kubernetes API server.  
   - **User Account**: A user account is typically tied to human users, managing access and permissions for interacting with the Kubernetes cluster.

2. **Pod Basics**:  
   A Pod is the smallest deployable unit in Kubernetes, typically representing a single instance of a running process in the cluster.

3. **YAML Basics**:  
   YAML (Yet Another Markup Language) is a human-readable data serialization format used for configuration files. Kubernetes uses YAML files to define and configure resources like Pods, Deployments, Services, etc.

4. **Service Basics**:  
   A service in Kubernetes provides a stable endpoint for accessing a set of Pods. It abstracts access to the Pods and can be exposed to the outside world.

5. **Port Forwarding**:  
   Kubernetes port forwarding allows you to access applications running inside Pods locally on your machine. You can forward a port on your local machine to a port on a Pod running in the Kubernetes cluster.

6. **Deployments, ReplicaSets, Namespaces, DaemonSets, StatefulSets**:  
   - **Deployment**: A resource that manages the deployment of Pods, ensuring the specified number of replicas is always running.  
   - **ReplicaSet**: Ensures that a specified number of identical Pods are running at any given time.  
   - **Namespace**: A way to partition resources in a Kubernetes cluster.  
   - **DaemonSet**: Ensures that a Pod runs on all or some nodes in the cluster.  
   - **StatefulSet**: A controller for managing stateful applications, ensuring persistent storage and stable network identities.
