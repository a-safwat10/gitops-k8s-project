# GitOps Kubernetes Platform on AWS

A production-style GitOps platform built on AWS EKS, provisioned with Terraform and deployed via Argo CD with a fully automated CI/CD pipeline.

## Architecture

GitHub → GitHub Actions → Terraform Cloud → AWS EKS
                                             ├── Helm (App Deployment)
                                             └── Argo CD (GitOps Sync)


## Tech Stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure as Code — provisions VPC, subnets, IAM roles, EKS cluster |
| AWS EKS | Managed Kubernetes cluster |
| Helm | Application packaging and deployment |
| Argo CD | GitOps continuous delivery — auto-syncs app state from GitHub |
| GitHub Actions | CI/CD pipeline — validates and plans Terraform on every push |
| Terraform Cloud | Remote state management |

## Infrastructure

- VPC with public subnets across 2 Availability Zones
- EKS cluster (Kubernetes 1.31) with 2 worker nodes (t3.medium)
- IAM roles and policies for EKS cluster and node groups
- Internet Gateway and Route Table for public access

## CI/CD Pipeline

Every `git push` to `main` triggers:

1. Terraform Format Check
2. Terraform Validate
3. Terraform Plan
4. Terraform Apply (requires manual approval)

## GitOps Flow

Code change → git push → GitHub Actions → Manual Approval → Terraform Apply
                                                                  ↓
                                                            EKS Cluster
                                                                  ↓
                                                        Argo CD detects drift
                                                                  ↓
                                                      Auto-sync to desired state



## How to Use

### Prerequisites

- AWS Account with credentials
- Terraform Cloud account
- kubectl and Helm installed

### Deploy Infrastructure

```bash
cd terraform
terraform init
terraform apply
```

### Deploy Application

```bash
helm install myapp ./helm/myapp
```

### Access Argo CD

```bash
kubectl get svc -n argocd
# Username: admin
# Password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Project Structure

gitops-k8s-project/
├── terraform/
│ ├── main.tf
│ ├── eks.tf
│ ├── iam.tf
│ ├── routing.tf
│ ├── variables.tf
│ └── outputs.tf
├── helm/
│ └── myapp/
├── .github/
│ └── workflows/
│ └── terraform.yml
└── argocd-app.yaml
