# Packer Project for Building Azure Images (VHDs)

## Project Summary

This project demonstrates how to automate the creation of Azure Virtual Machine images using Packer and deploy a VM using Terraform. It follows best practices for infrastructure as code (IaC), making VM deployments scalable and repeatable.

It follows these steps:
1.	Creating a Packer template for Azure.
2.	Writing a provisioner script to configure the image.
3.	Validating and building the image.
4.	Deploying an Azure Virtual Machine using Terraform.

---

## Step 1: Install Packer and Set Up Azure Credentials

### 1.1 Install Packer
- Linux/MacOS:
```bash
curl -fsSL https://releases.hashicorp.com/packer/1.8.6/packer_1.8.6_linux_amd64.zip -o packer.zip
unzip packer.zip
sudo mv packer /usr/local/bin/
```
- Windows:
Download Packer from the official website and follow the installation instructions.
- Verify installation:
```bash
packer version
```
### 1.2 Configure Azure Authentication
- Install the Azure CLI (if not already installed):
```bash
az login
az account set --subscription "<SUBSCRIPTION_ID>"
```
- Retrieve your Azure Subscription ID:
```bash
az account show --query "{subscriptionId:id}" --output json
```

## Step 2: Create a Packer Template for Azure

### 2.1 Get the Packer Template

- Clone the project repository:
```bash
git clone https://github.com/Here2ServeU/packer-azure-project.git
cd packer-azure-project
```

### 2.2 Define the Packer Template (azure-packer.json)

- Create a **azure-packer.json** file with the following content:
```json
{
  "builders": [
    {
      "type": "azure-arm",
      "client_id": "<YOUR_CLIENT_ID>",
      "client_secret": "<YOUR_CLIENT_SECRET>",
      "subscription_id": "<YOUR_SUBSCRIPTION_ID>",
      "tenant_id": "<YOUR_TENANT_ID>",
      "managed_image_resource_group_name": "packer-images",
      "managed_image_name": "t2s-azure-image-{{timestamp}}",
      "os_type": "Linux",
      "image_publisher": "Canonical",
      "image_offer": "UbuntuServer",
      "image_sku": "18.04-LTS",
      "location": "East US",
      "vm_size": "Standard_B1s"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "script": "provisioner.sh"
    }
  ]
}
```
- Replace <YOUR_CLIENT_ID>, <YOUR_CLIENT_SECRET>, <YOUR_SUBSCRIPTION_ID>, and <YOUR_TENANT_ID> with actual values from your Azure Active Directory.

## Step 3: Create a Provisioner Script

### 3.1 Define a Script to Install Required Packages

- Create a **provisioner.sh** file:
```bash
#!/bin/bash

# Wait for any pending system updates or processes to finish
sleep 10

# Update and install Apache
sudo apt update -y
sudo apt install -y apache2

# Enable and start Apache service
sudo systemctl enable apache2
sudo systemctl start apache2

# Create a simple index.html page for verification
echo "<html><body><h1>Welcome to T2S Web Server on Azure</h1></body></html>" | sudo tee /var/www/html/index.html
```
### 3.2 Make the Script Executable
```bash
chmod +x provisioner.sh
```
## Step 4: Validate and Build the Image

### 4.1 Validate the Packer Template
```bash
packer validate azure-packer.json
```
### 4.2 Build the Image
```bash
packer build azure-packer.json
```
- This will create a custom Azure Image in your packer-images resource group.

## Step 5: Deploy a VM using Terraform

### 5.1 Modify Terraform Variables

- Move to the **web-app-create/backend-setup** directory. 
```bash
cd web-app-create/backend-setup
```
- Run the following commands: 
```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

- The commands above will create the backend storage where we want to store the state file of our infrastructure. 

- Next, go to the **environments/dev** directory. This directory defines the environment where you want to deploy your infrastructure.  
```bash
cd environments/dev
```
- Run the following commands: 
```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```
- This will provision an Azure VM using the custom image created by Packer.

---

## Clean Up Resources

- To avoid unnecessary costs, delete unused resources:

### Delete the Azure Image
```bash
az image delete --name t2s-azure-image --resource-group packer-images
```

- Destroy the Terraform Infrastructure in the **backend setup** and **environment/dev** directories. 
```bash
terraform destroy
```

