# AWS K3s Cluster with Terraform

This module provisions a **lightweight Kubernetes (K3s) cluster on AWS** using Terraform. It is part of the [terraform-knowledge-base](https://github.com/PritamChk/terraform-knowledge-base) repository and is designed to serve as a reusable, configurable template for deploying K3s clusters in cloud environments.

---

## 🚀 Features

- Automated provisioning of **EC2 instances** for K3s master and worker nodes.
- Configurable **cluster size** and **instance types**.
- Secure networking with **VPC, subnets, and security groups**.
- Bootstraps **K3s installation** via cloud-init or user data scripts.
- Outputs cluster connection details for easy access.

---

## 📦 Prerequisites

Before using this module, ensure you have:

- **Terraform v1.3+**
- An **AWS account** with appropriate IAM permissions
- **AWS CLI** configured locally
- Basic knowledge of **Kubernetes** and **Terraform**

---

## ⚙️ Usage

```hcl
module "k3s_cluster" {
  source = "github.com/PritamChk/terraform-knowledge-base/aws/k3s_cluster"

  region          = "ap-south-1"
  cluster_name    = "demo-k3s"
  instance_type   = "t3.medium"
  ssh_key_name    = "my-keypair"
}
```

After applying:

```bash
terraform init
terraform apply
```

You’ll get outputs such as:

- Master node public IP
- Worker node IPs
- SSH connection string
- Kubeconfig path (if configured)

---

## 📂 Repository Structure

```
aws/k3s_cluster/
├── main.tf          # Core resources (EC2, networking, K3s bootstrap)
├── variables.tf     # Input variables for customization
├── outputs.tf       # Useful outputs (IPs, kubeconfig, etc.)
├── provider.tf      # AWS provider configuration
└── README.md        # Documentation (this file)
```

---

## 🔧 Configuration Options

| Variable        | Description                          | Default       |
| --------------- | ------------------------------------ | ------------- |
| `region`        | AWS region for deployment            | `ap-south-1`  |
| `cluster_name`  | Name prefix for resources            | `k3s-cluster` |
| `master_count`  | Number of master nodes               | `1`           |
| `worker_count`  | Number of worker nodes               | `2`           |
| `instance_type` | EC2 instance type                    | `t3.medium`   |
| `ssh_key_name`  | Existing AWS key pair for SSH access | `null`        |

---

## 📖 Notes

- K3s is a **lightweight Kubernetes distribution** ideal for dev/test clusters and edge workloads.
- This setup is **not production-hardened**; for production, consider HA masters, private networking, and managed Kubernetes (EKS).
- Ensure your **AWS key pair** exists in the target region before applying.

---

## 🛠️ Future Improvements

- Add support for **multi-master HA clusters**
- Integrate with **Terraform remote state**
- Optionally configure **Load Balancer + Ingress**
- Automated **kubeconfig export**

---

## 👨‍💻 Author

Created by [PritamChk](https://github.com/PritamChk)  
Part of the **Terraform Knowledge Base** project.
