### **Task :**

https://github.com/infracloudio/citadel-internal/tree/master/workshops/helm#chart-tests-40-minutes

---

1. Test job created using below yaml defination :
    ```bash
    apiVersion: v1
    kind: Pod
    metadata:
    {{- include "resource.name" . }}
    annotations:
        "helm.sh/hook": test
    spec:
    containers:
        - name: wget
        image: busybox
        command: ['wget']
        args: ['{{ .Release.Name }}-helm-module.default.svc.cluster.local:{{ .Values.service.port }}']
    restartPolicy: Never
    ```

2. Installed chart
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-7_chart_tests$ helm install webapp ./nginx/
    NAME: webapp
    LAST DEPLOYED: Fri Dec  2 19:23:22 2022
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    ```

3. Tested connection with nginx service using `helm test webapp` command which created test pod.
    > Output of `helm test webapp`
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-7_chart_tests$ helm test webapp
    NAME: webapp
    LAST DEPLOYED: Fri Dec  2 19:23:22 2022
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE:     webapp-helm-module
    Last Started:   Fri Dec  2 19:24:23 2022
    Last Completed: Fri Dec  2 19:24:29 2022
    Phase:          Succeeded
    ```

    > Test pod created
    ```bash
    pod/webapp-helm-module                    0/1     Completed   0          9s
    ```

    > Logs of test pod
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment$ k logs webapp-helm-module
    Connecting to webapp-helm-module.default.svc.cluster.local:80 (10.96.74.154:80)
    saving to 'index.html'
    index.html           100% |********************************|   342  0:00:00 ETA
    'index.html' saved
    ```