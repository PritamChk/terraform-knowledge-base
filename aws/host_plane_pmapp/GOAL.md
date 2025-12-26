# **Terraform Hands-On Project: Hosting Plane on AWS**

### **Project Goal**

Provision the infrastructure and automate the deployment of the Plane self-hosted app on AWS using Terraform. This includes creating networking, security, compute resources, and executing your installation scripts on EC2.

---

## **Step 1: IAM Role & Permissions**

**Objective:** Learn how to design the principle of least privilege for Terraform automation.

**Tasks:**

* Decide whether you’ll run Terraform from your local machine or an EC2 bastion.
* Identify which AWS actions Terraform needs for:

  * EC2 provisioning
  * VPC/subnet creation
  * Security group creation
  * IAM role and instance profile creation
  * S3 (if storing state remotely)
* Create a dedicated **Terraform IAM user or role** with policy limited to required resources.

**Hints:**

* Focus on **Terraform resource creation privileges** (e.g., `ec2:*`, `iam:PassRole`, `s3:*` if remote state).
* Remember **`iam:PassRole`** is required if your EC2 instance will assume a role for provisioning scripts.
* Consider **least privilege**: don’t attach AdministratorAccess; practice fine-grained policies.

**Expected Learning:**

* Understanding IAM roles vs. instance profiles
* Terraform AWS provider authentication
* Least privilege concepts in practice

---

## **Step 2: VPC + Subnet**

**Objective:** Build a simple network to host your EC2 instance.

**Tasks:**

* Create **1 VPC**
* Add **1 public subnet** (for now)
* Set up **Internet Gateway** and **route table** for public access
* Enable **DNS support** for public access to Plane app

**Hints:**

* Public subnet = subnet with a route to IGW
* Terraform resources to research: `aws_vpc`, `aws_subnet`, `aws_internet_gateway`, `aws_route_table`, `aws_route_table_association`
* Tag resources properly for clarity

**Expected Learning:**

* Basic AWS networking concepts
* Terraform VPC provisioning
* How route tables control subnet connectivity

---

## **Step 3: EC2 Provisioning**

**Objective:** Launch a compute instance to host Plane and test your Terraform skills for compute.

**Tasks:**

* Launch **t3.medium** EC2 instance
* Use a public AMI compatible with your Plane installation script (e.g., Amazon Linux 2023)
* Attach the **IAM role / instance profile** you designed
* Associate a **security group** with ports for Plane (HTTP/HTTPS/SSH)
* Make it accessible in the public subnet

**Hints:**

* Terraform resources: `aws_instance`, `aws_security_group`
* Use `user_data` to bootstrap the instance if you want (optional)
* Keep SSH key in mind for manual testing

**Expected Learning:**

* Terraform EC2 creation
* Security group design
* Instance profile usage
* Bootstrap scripts vs. manual install

---

## **Step 4: Provision Installation Scripts**

**Objective:** Automate your manual Plane installation process via Terraform.

**Tasks:**

* Decide how to deliver your installation scripts:

  * Upload via Terraform `file` provisioner
  * Use `remote-exec` to execute the script after instance creation
* Ensure Docker and Docker Compose are installed
* Run Plane setup scripts automatically on instance startup

**Hints:**

* `remote-exec` runs commands over SSH
* `file` provisioner copies local scripts to remote EC2
* Consider idempotency: can the script run multiple times safely?

**Expected Learning:**

* Terraform provisioners
* Automating OS-level setup
* Understanding the limitations of `remote-exec` vs. configuration management tools

---

## **Step 5: (Optional, Next-Level) Private Subnet + ELB**

**Objective:** Make your setup more production-like with security and scalability.

**Tasks:**

* Move EC2 to a private subnet
* Create a **public ELB** to route traffic to EC2
* Update security groups to allow only ELB → EC2 access
* Adjust your installation script if needed (no direct public IP)

**Hints:**

* Terraform resources: `aws_lb`, `aws_lb_target_group`, `aws_lb_listener`, `aws_lb_target_group_attachment`
* Remember private subnet = no direct Internet route → NAT might be needed for updates
* Test ELB health checks

**Expected Learning:**

* ELB setup and routing
* Private subnet security
* NAT and outbound traffic routing
* Real-world architecture practices

---

## **Step 6: Outputs & State**

**Objective:** Make Terraform useful beyond creation.

**Tasks:**

* Output Plane app endpoint (public IP or ELB DNS)
* Optional: output security group IDs, subnet IDs
* Manage Terraform state locally first, then explore S3 backend

**Hints:**

* Use `output` blocks
* Consider `terraform fmt` and `terraform validate`
* Remote state enables team collaboration

**Expected Learning:**

* Terraform outputs
* State management concepts
* Best practices for collaboration

---

## ✅ **Final Deliverables / Objectives**

* Terraform project directory with clear structure:

  ```
  vpc.tf
  ec2.tf
  security.tf
  iam.tf
  outputs.tf
  variables.tf
  ```
* A fully provisioned Plane instance
* Optional: ELB routing and private subnet setup
* Documented learnings per step

---
