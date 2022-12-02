### **Tasks :**
---

1. Install latest version of mysql helm chart from mybitnami helm repository that you added earlier in your local. Override the rootPassword value of mysql helm chart to something of your choice during installation.

    - Installed chart from `mybitnami/mysql` and overriden root password :
        ```bash
        bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-3_chart_installation$ helm install mysql mybitnami/mysql --set auth.rootPassword='Pa$$w0Rd'
        ```

2. Explore the status of helm release post installation and also the kubernetes resources being created by it.
    
    - Status of mysql release :
        ```bash
        bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-3_chart_installation$ helm status mysql
        NAME: mysql
        LAST DEPLOYED: Fri Dec  1 18:41:42 2022
        NAMESPACE: default
        STATUS: deployed
        REVISION: 1
        TEST SUITE: None
        NOTES:
        CHART NAME: mysql
        CHART VERSION: 9.4.4
        APP VERSION: 8.0.31

        ** Please be patient while the chart is being deployed **

        Tip:

          Watch the deployment status using the command: kubectl get pods -w --namespace default

        Services:

          echo Primary: mysql.default.svc.cluster.local:3306

        Execute the following to get the administrator credentials:

          echo Username: root
          MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)

        To connect to your database:

          1. Run a pod that you can use as a client:

              kubectl run mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:8.0.31-debian-11-r10 --namespace default --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash

          2. To connect to primary service (read/write):

              mysql -h mysql.default.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"
        ```

    - Resources created by the chart :
        ```bash
        bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-3_chart_installation$ k get all
        NAME          READY   STATUS    RESTARTS   AGE
        pod/mysql-0   1/1     Running   0          8m15s

        NAME                     TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
        service/kubernetes       ClusterIP   10.96.0.1     <none>        443/TCP    8m55s
        service/mysql            ClusterIP   10.96.65.89   <none>        3306/TCP   8m15s
        service/mysql-headless   ClusterIP   None          <none>        3306/TCP   8m15s

        NAME                     READY   AGE
        statefulset.apps/mysql   1/1     8m15s

        bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-3_chart_installation$ k get secrets 
        NAME                          TYPE                 DATA   AGE
        mysql                         Opaque               2      8m20s
        sh.helm.release.v1.mysql.v1   helm.sh/release.v1   1      8m20s

        bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-3_chart_installation$ k get cm
        NAME               DATA   AGE
        kube-root-ca.crt   1      9m44s
        mysql              1      9m21s

        bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-3_chart_installation$ k get sa
        NAME      SECRETS   AGE
        default   0         12m
        mysql     1         12m
        ```

    - Tested the connection with mysql as root user :
        ```bash
        bhagyesh@BHAGYESH-SONI:~/helm_assignment$ kubectl run mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:8.0.31-debian-11-r10 --namespace default --env MYSQL_ROOT_PASSWORD='Pa$$w0Rd' --command -- bash
        If you don't see a command prompt, try pressing enter.
        I have no name!@mysql-client:/$ 
        I have no name!@mysql-client:/$ echo $MYSQL_ROOT_PASSWORD
        Pa$$w0Rd
        I have no name!@mysql-client:/$
        I have no name!@mysql-client:/$ mysql -h mysql.default.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"
        mysql: [Warning] Using a password on the command line interface can be insecure.
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 200
        Server version: 8.0.31 Source distribution

        Copyright (c) 2000, 2022, Oracle and/or its affiliates.

        Oracle is a registered trademark of Oracle Corporation and/or its
        affiliates. Other names may be trademarks of their respective
        owners.

        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

        mysql> 
        ```