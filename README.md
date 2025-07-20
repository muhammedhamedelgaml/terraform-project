# 🌐 Full-Stack Web App on AWS with Terraform
## 🚀 Architecture Overview
![Architecture Diagram](screenshot/project.png)

# AWS VPC Architecture: Nginx Reverse Proxy with Internal Web App Backends

## 📘 Overview

This project sets up a secure, scalable, and modular AWS VPC infrastructure with public-facing Nginx reverse proxies and private backend application servers. Traffic flows through multiple layers to ensure proper routing, security, and load balancing.

---

## 🖥️ Deployed Application

👉 **Full-Stack Node.js + React App Repository**  
GitHub: [muhammedhamedelgaml/fullStack-node.js-react](https://github.com/muhammedhamedelgaml/fullStack-node.js-react)

This repository contains the full-stack application (React frontend + Node.js backend) deployed in this VPC setup.

---





## 🌐 Network Design

### VPC
- Custom VPC with multiple subnets across 2 Availability Zones.

### Subnets
- **2 Public Subnets**: Host Nginx Reverse Proxy EC2 instances.
- **2 Private Subnets**: Host Web Application EC2 instances (Node.js backend).

### Gateways
- **Internet Gateway**: Provides internet access to the public subnets and NAT Gateway.
- **NAT Gateway**: Allows private subnet instances to access the internet (e.g., for updates, API calls).

---

## ⚙️ Load Balancers

### Public ALB
- Internet-facing.
- Accepts HTTP(S) requests from the public.
- Routes requests to Nginx EC2 instances in the public subnet.

### Internal ALB
- Private/internal.
- Accepts requests from Nginx reverse proxies.
- Routes requests to backend application EC2 instances in private subnets.

---

## 🧱 EC2 Instances

### Nginx Reverse Proxy (Public Subnets)
- Acts as the first point of entry.
- Routes incoming traffic to the internal load balancer.

### Web Application Backends (Private Subnets)
- Hosts application code from the [Node.js + React Repo](https://github.com/muhammedhamedelgaml/fullStack-node.js-react).
- Processes requests passed from the reverse proxy via the internal ALB.
- Can connect to databases, message queues, or external APIs via NAT.

---

## 🔐 Security Best Practices

- Use **Security Groups** to tightly control access between layers.
- Public ALB: Open only HTTP to the world.
- Nginx EC2s: Accept traffic only from Public ALB.
- Internal ALB: Accept traffic only from Nginx EC2s.
- Backend EC2s: Accept traffic only from Internal ALB.

---

## 📈 Scalability & Availability

- Deployed across **2 Availability Zones** for high availability.
- Load balancers ensure traffic is evenly distributed.
- Infrastructure supports auto scaling of EC2 instances (optional).

---

## 🚀 Getting Started

### Prerequisites
- AWS CLI configured
- IAM permissions to provision EC2, ALB, VPC, IGW, NAT, etc.
- Terraform
- backend  Optional(remote backend  go to AWS and create s3 bucket and dynamodb_table with The table must have a partition key named (LockID)with a type of String. ):[terraform_Docs](https://developer.hashicorp.com/terraform/language/backend/s3) 
 note that delete backend.tf file if you won't use remote backend




---

### LoadBalancer link 
![ELB LINK](screenshot/app.png)

## 🔧 Prerequisites
- **Terraform**: [Install Terraform](https://www.terraform.io/downloads)
- **AWS CLI**: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- **AWS Credentials**: Configure the CLI with:
  ```bash
  aws configure
  ```



#### 🚀 Usage

1. **clone repo**
    ```
    git clone https://github.com/muhammedhamedelgaml/terraform-project.git 
    cd terraform-project

2. **Initialize Backend**
   ```bash
   terraform init

3. **create new work space(Optional)**
   ```bash
   terraform workspace new dev   

4. **Terraform plan**
   ```bash
   terraform plan   
  


5. **Terraform apply**
   ```bash
   terraform apply 




6. **Terraform CleanUp Delete resources**
   ```bash
   terraform destroy
-------

