### **Task :**

https://github.com/infracloudio/citadel-internal/tree/master/workshops/helm#subcharts-40-50-minutes

---

1. Need to mention dependency chart in parent Chart.yaml:
    ```bash
    dependencies:
     - name: mysql
       repository: https://charts.bitnami.com/bitnami
       version: 9.4.4
       condition: mysql.enabled,global.mysql.enabled
       tags:
         - mysql
         - db
    ```

2. Build dependency of chart. This step will download all the dependency chart under charts directory
    > build command output
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-6_subcharts$ helm dependency build ./nginx/
    Hang tight while we grab the latest from your chart repositories...
    ...Successfully got an update from the "mybitnami" chart repository
    Update Complete. ⎈Happy Helming!⎈
    Saving 1 charts
    Downloading mysql from repo https://charts.bitnami.com/bitnami
    Deleting outdated charts
    ```
    
    > dependency build downloaded mysql chart package under charts directory
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-6_subcharts/nginx/charts$ ls -al
    total 56
    drwxrwxr-x 2 bhagyesh bhagyesh  4096 Dec  2 17:44 .
    drwxr-xr-x 4 bhagyesh bhagyesh  4096 Dec  2 17:44 ..
    -rw-r--r-- 1 bhagyesh bhagyesh 45691 Dec  2 17:44 mysql-9.4.4.tgz
    ```

3. We can provide condition to enable subcharts through condition specified in Chart.yaml
    ```bash
    condition: mysql.enabled,global.mysql.enabled
    ```

4. To enable mysql subchart and to set root user password for db, need to modify values as below :
    ```bash
    mysql:
    enabled: true
    auth:
        rootPassword: 'Pa$$w0RD'
    ```

5. Installed Chart
    ```
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-6_subcharts$ helm install nginx-webapp ./nginx/
    NAME: nginx-webapp
    LAST DEPLOYED: Fri Dec  2 17:44:42 2022
    NAMESPACE: default
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    ```

6. Verified that subchart mysql also has been installed on the cluster
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-6_subcharts$ k get all | grep mysql
    pod/nginx-webapp-mysql-0                        1/1     Running   0          66m
    service/nginx-webapp-mysql            ClusterIP   10.96.239.74    <none>        3306/TCP   66m
    service/nginx-webapp-mysql-headless   ClusterIP   None            <none>        3306/TCP   66m
    statefulset.apps/nginx-webapp-mysql   1/1     66m
    ```
