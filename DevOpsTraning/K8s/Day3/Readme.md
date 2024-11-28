# **Day 3 Kubernetes Tasks**

---
## **Learning Topics**

| **Topic**                                   | **Description**                                                                                          |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------|
| **Commands and Arguments in Pods**          | Understand when to use commands and arguments.                                                          |
| **ConfigMaps vs Secrets**                   | Learn the differences, use cases, and the advantages of using Secrets over ConfigMaps.                  |
| **Service Accounts and Tokens**             | Explore Bound Tokens and their functionality.                                                           |
| **Resource Management**                     | Learn about Resource Requests, Quotas, and LimitRanges.                                                 |


---

## **Day 3 Task Overview**

### **Normal Tasks**

| **S.No** | **Task Description**                                                                                     | **Links/Hints**                                                                                                           |
|----------|---------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| 1        | Spin up a simple pod with commands and arguments to learn about the Pod lifecycle. Adjust `restartPolicy`. | [Reference Documentation](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/)   |
| 2        | Create a simple Kubernetes Secret and use it in a pod as an environment variable or mount it as a volume. |                                                                                                                          |
| 3        | Create a ConfigMap with multiple files and data keys. Mount files as pod volumes and set data keys as env vars. Verify mounts. |                                                                                                                          |
| 4        | Deploy a custom Nginx server using a private Docker image. Configure the pod to pull the image securely using `dockerconfigjson`. | *Skip if completed on Day 2.*                                                                                            |
| 5        | Spin up a pod requiring `4vCPUs` and `4Gi RAM`. Debug why it isn’t scheduled. Learn about `LimitRanges` and `ResourceQuotas`. |                                                                                                                          |

---

### **Debug Tasks**

| **S.No** | **Task Description**                                                                                     | **Links/Hints**                                                                                                           |
|----------|---------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
| 1        | Debug the deployment `task-02-oom-deploy` in your namespace. Fix the pods in `CrashLoopBackOff` state and make them healthy. |                                                                                                                          |
| 2        | Debug the deployment `task-01-qos-deploy` in your namespace. Learn about QoS classes, check the current QoS, and modify to Guaranteed QoS. | [Reference Documentation](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/)                |

*Note: Debug tasks will be deployed in the cluster. You will be notified once they are available.*  

