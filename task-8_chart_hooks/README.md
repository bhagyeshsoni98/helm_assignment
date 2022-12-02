### **Task :**

https://github.com/infracloudio/citadel-internal/tree/master/workshops/helm#chart-hooks-40-minutes

---

1. Created pre-install.yaml and post-install.yaml under templates directory
    > pre-install.yaml
    ```bash
    apiVersion: batch/v1
    kind: Job
    metadata:
    name: pre-install-job
    annotations:
    "helm.sh/hook": pre-install
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": before-hook-creation
    spec:
    template:
        metadata:
        name: {{ .Release.Name }}-pre-install
        spec:
        restartPolicy: Never
        containers:
        - name: pre-install-job
            image: "busybox"
            command: ['/bin/echo']
            args: ['I am performing prerequisite tasks!']
    ```

    > post-install.yaml
    ```bash
    apiVersion: batch/v1
    kind: Job
    metadata:
    name: post-install-job
    annotations:
    "helm.sh/hook": post-install
    "helm.sh/hook-weight": "-5"
    "helm.sh/hook-delete-policy": before-hook-creation
    spec:
    template:
        metadata:
        name: {{ .Release.Name }}-post-install
        spec:
        restartPolicy: Never
        containers:
        - name: post-install-job
            image: "busybox"
            command: ['/bin/echo']
            args: ['I am done with cleanup!']
    ```

2. Pods for both jobs created
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment$ k get pods
    NAME                                  READY   STATUS      RESTARTS   AGE
    post-install-job-ftt8h                0/1     Completed   0          4m17s
    pre-install-job-wj94v                 0/1     Completed   0          4m17s
    webapp-helm-module-7db5fff954-4qzzz   1/1     Running     0          4m17s
    webapp-mysql-0                        1/1     Running     0          4m17s
    ```

3. Logs of pre-install and post-install pods
    > pre-install logs
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment$ k logs pre-install-job-wj94v 
    I am performing prerequisite tasks!
    ```

    > post-install logs
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment$ k logs pre-install-job-wj94v 
    I am performing prerequisite tasks!
    ```