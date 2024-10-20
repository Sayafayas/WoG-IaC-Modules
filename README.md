# AWS Infrastructure as Code (IaC) Project

## Project Overview
This project is a **Terraform/Terragrunt-based Infrastructure as Code (IaC) setup** to deploy an **Amazon EKS cluster** along with supporting resources in AWS. The goal is to manage all necessary components for the **WoG application** in a scalable and maintainable manner using Terraform, orchestrated via Terragrunt. The resources in this project include networking, security, compute, and data layers.

## Project Structure
The project is structured as follows:

```
terraform-iac-non-prod
├───dev
│   │   terragrunt.hcl
│   │
│   ├───ecr
│   │   └───project-wog
│   │       └───wog-app
│   │               terragrunt.hcl
│   │
│   ├───eks
│   │       terragrunt.hcl
│   │
│   ├───kms
│   │       terragrunt.hcl
│   │
│   ├───networking
│   │   ├───sg
│   │   │       terragrunt.hcl
│   │   │
│   │   └───vpc
│   │           terragrunt.hcl
│   │
│   └───rds
│       └───demo
│               terragrunt.hcl
│
modules
├───ecr
├───eks
├───kms
├───networking
│   ├───sg
│   └───vpc
└───rds
```

Each directory represents a different **Terraform module** for deploying individual AWS resources in a modular way. Each resource is managed with a `terragrunt.hcl` file to ensure reusability and configuration management. The `modules` directory stores the Terraform configuration for all modules, allowing for easy reuse and consistency.

## Key Components and Their Functions
### 1. VPC and Subnets (`networking/vpc`)
- **Virtual Private Cloud (VPC)**: A dedicated network environment for your application.
- **Subnets**: Public and private subnets, distributed across multiple availability zones for high availability.

### 2. Security Groups (SG) (`networking/sg`)
- Defines **firewall rules** to control inbound and outbound traffic for components such as EC2 instances, EKS nodes, and RDS.

### 3. Amazon EKS (`eks`)
- Deploys the **EKS cluster** for running Kubernetes workloads.
- Uses **security groups**, and **node groups** for managing the cluster and nodes.
- Integrates with existing **VPC and subnets** for networking and uses **managed node groups** for scaling worker nodes.
- Uses **KMS** to provide encryption for Kubernetes secrets, ensuring that sensitive data within the cluster is securely managed.

### 4. Amazon Elastic Container Registry (ECR) (`ecr/project-wog/wog-app`)
- Stores Docker images used by the application.
- Provides secure storage, versioning, and management of application images.

### 5. AWS Key Management Service (KMS) (`kms`)
- Manages **encryption keys** used for data security in other services, such as encrypted data volumes and secrets.
- Provides encryption for EKS secrets, RDS, and other sensitive data.

### 6. Amazon RDS (`rds/demo`)
- Sets up a **relational database** (MySQL) to store persistent application data.
- Uses **AWS Secrets Manager** to manage database credentials securely.
- **Security Groups** are configured to allow inbound traffic from Kubernetes nodes and additional CIDR blocks if required.
- **Random Password Generation**: A random password is generated for the RDS master user and stored in Secrets Manager.

### 7. Terragrunt
- **Terragrunt** is used to manage consistent configurations, state management, and module reuse across different environments (e.g., `dev`, `prod`).
- Facilitates the orchestration of the deployment, reduces duplication, and manages remote states.

## Functionality
- **Automated Deployment**: The entire setup is automated using **Terraform modules** and **Terragrunt** for easy deployment, management, and teardown of infrastructure.
- **Scalable Kubernetes Cluster**: Amazon EKS is used for containerized workloads, providing automated scaling and management of **Kubernetes control plane**.Additionally, KMS is integrated to encrypt secrets and sensitive data used by the cluster.
- **Container Registry (ECR)**: Stores Docker images for the workloads running on EKS.
- **Secure Configuration**: Security groups, KMS, and AWS Secrets Manager ensure secure access, encryption, and permissions management.
- **High Availability**: Multiple subnets across different **availability zones** ensure the application remains available in case of a failure in one zone.
- **Database Management**: RDS provides persistent storage with encryption via KMS, and **Secrets Manager** handles secure password management.

## Workflow Summary
1. **Network Setup**: Deploy VPC, subnets, route tables, and internet gateway.
2. **Security Configuration**: Create security groups for each resource type.
3. **Database and Registry Setup**: Deploy RDS for persistent storage and configure ECR for container image storage.
4. **EKS Cluster Setup**: Deploy managed node groups and configure add-ons such as **CoreDNS** and **Amazon VPC CNI**.
5. **Application Deployment**: Application containers are pulled from ECR and deployed on the EKS cluster.

## Key Benefits
- **Automation**: Full automation with Infrastructure as Code (IaC) ensures consistent setup and management.
- **Scalability and Flexibility**: The use of **EKS** allows dynamic scaling of workloads.
- **Security**: Best practices are followed for **encryption**, IAM roles, **Secrets Manager**, and **security groups**.
- **Maintainability**: Modular project structure ensures easy updates and reusability of components.

---
Let me know if you need more details or further adjustments in the project documentation!

