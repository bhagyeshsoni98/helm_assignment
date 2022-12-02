### **Task :**

Create a sample helm chart using command helm create mychart and explore the files / directories being created

------

1. Created helm chart named mychart :
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-1_charts_and_directory_structure$ helm create mychart
    Creating mychart
    ```

2. Default directory structure created from above command :
    ```bash
    bhagyesh@BHAGYESH-SONI:~/helm_assignment/task-1_charts_and_directory_structure$ tree
    .
    ├── mychart
    │   ├── charts
    │   ├── Chart.yaml
    │   ├── templates
    │   │   ├── deployment.yaml
    │   │   ├── _helpers.tpl
    │   │   ├── hpa.yaml
    │   │   ├── ingress.yaml
    │   │   ├── NOTES.txt
    │   │   ├── serviceaccount.yaml
    │   │   ├── service.yaml
    │   │   └── tests
    │   │       └── test-connection.yaml
    │   └── values.yaml
    └── README.md

    4 directories, 11 files
    ```