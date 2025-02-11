# ACR-Webhooks-LogicAPP_Terraform

## Overview
This repository contains the code and configuration for automating the deployment and execution of containerized applications using Azure services. The workflow involves Azure Container Registry (ACR), Logic Apps, webhooks, and Terraform for infrastructure as code (IaC). The system ensures seamless image deployment, execution, and data output processing.

---

## Features
- Automates container deployment using **Azure Logic Apps** and **Webhooks**.
- Uses **Terraform** for provisioning infrastructure resources.
- Supports **Azure Container Registry (ACR)** to store and manage Docker images.
- Runs applications on **Azure Container Instances (ACI)**.
- Processes data outputs and stores results in **Azure Blob Storage**.
- Scalable and modular architecture.

---

## Workflow
1. **Dockerization**:  
   - The application is containerized, and the Docker image is pushed to **Azure Container Registry (ACR)**.

2. **Trigger with Webhooks**:  
   - ACR webhook triggers an **Azure Logic App** action when a new image is pushed.

3. **Container Deployment**:  
   - Logic App deploys the Docker image to an **Azure Container Instance (ACI)** and runs the application.

4. **Data Processing and Storage**:  
   - The application generates output (e.g., CSV files) stored in **Azure Blob Storage**.

5. **Visualization (Optional)**:  
   - The output data can be visualized in tools like **Power BI**.

---

## Prerequisites
- **Azure Subscription**  
- **Terraform** installed on your local machine.  
- **Docker** installed for building and testing images.  
- Access to Azure services:
  - Azure Container Registry (ACR)
  - Azure Logic Apps
  - Azure Container Instances (ACI)
  - Azure Blob Storage

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone 
cd ACR-Webhooks-LogicAPP_Terraform
```

### 2. Updating the Azure Subscription ID:
Before using Terraform, ensure you add your Azure Subscription ID in the /tfvars/qa.tfvars file.
Open the qa.tfvars file.
Replace the placeholder <"23XX45XXXXX"> with your actual Azure Subscription ID.

### 3. Initialize Terraform:
```bash
 Terraform init
```
### 4. Plan the deployment using the QA environment:
```bash
terraform plan -var-file=./tfvars/qa.tfvars
```
### 5. Apply the configuration:
```bash
terraform apply -var-file=./tfvars/qa.tfvars
```
