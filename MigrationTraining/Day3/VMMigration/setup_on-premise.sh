#!/bin/bash

# Variables
resourceGroup="OnPremisesRG"
location="eastus"
frontendVM="FrontendVM"
backendVM="BackendVM"
databaseVM="DatabaseVM"
vnetName="OnPremisesVNet"
subnetName="OnPremisesSubnet"
nsgName="OnPremisesNSG"
adminUsername="azureuser"
adminPassword="P@ssw0rd1234!"
vmSize="Standard_B1s"
vmImage="Ubuntu2204" # Corrected Image Identifier

# Create Resource Group
az group create --name $resourceGroup --location $location

# Create Virtual Network
az network vnet create \
  --resource-group $resourceGroup \
  --name $vnetName \
  --address-prefix 10.0.0.0/16 \
  --subnet-name $subnetName \
  --subnet-prefix 10.0.0.0/24

# Create Network Security Group
az network nsg create \
  --resource-group $resourceGroup \
  --name $nsgName

# Create Network Security Group Rules
az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name $nsgName \
  --name AllowHTTP \
  --protocol tcp \
  --priority 1000 \
  --destination-port-range 80 \
  --access allow

az network nsg rule create \
  --resource-group $resourceGroup \
  --nsg-name $nsgName \
  --name AllowSSH \
  --protocol tcp \
  --priority 1001 \
  --destination-port-range 22 \
  --access allow

# Create Public IPs and NICs for each VM
for vmName in $frontendVM $backendVM $databaseVM
do
  az network public-ip create \
    --resource-group $resourceGroup \
    --name "${vmName}PublicIP"

  az network nic create \
    --resource-group $resourceGroup \
    --name "${vmName}NIC" \
    --vnet-name $vnetName \
    --subnet $subnetName \
    --network-security-group $nsgName \
    --public-ip-address "${vmName}PublicIP"
done

# Create VMs
az vm create \
  --resource-group $resourceGroup \
  --name $frontendVM \
  --size $vmSize \
  --image $vmImage \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --nics "${frontendVM}NIC"

az vm create \
  --resource-group $resourceGroup \
  --name $backendVM \
  --size $vmSize \
  --image $vmImage \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --nics "${backendVM}NIC"

az vm create \
  --resource-group $resourceGroup \
  --name $databaseVM \
  --size $vmSize \
  --image $vmImage \
  --admin-username $adminUsername \
  --admin-password $adminPassword \
  --nics "${databaseVM}NIC"

# Install and configure a simple web server on the Frontend VM
az vm run-command invoke \
  --resource-group $resourceGroup \
  --name $frontendVM \
  --command-id RunShellScript \
  --scripts "sudo apt-get update && sudo apt-get install -y nginx && sudo systemctl start nginx && echo '<h1>Welcome to Frontend VM</h1>' | sudo tee /var/www/html/index.html"

# Install and configure a simple backend server on the Backend VM
az vm run-command invoke \
  --resource-group $resourceGroup \
  --name $backendVM \
  --command-id RunShellScript \
  --scripts "sudo apt-get update && sudo apt-get install -y nodejs npm && echo 'const http = require(\"http\"); const server = http.createServer((req, res) => { res.statusCode = 200; res.setHeader(\"Content-Type\", \"text/plain\"); res.end(\"Hello from Backend VM\"); }); server.listen(3000, \"0.0.0.0\", () => { console.log(\"Server running at http://0.0.0.0:3000/\"); });' > ~/server.js && node ~/server.js &"

# Install and configure a simple database server on the Database VM
az vm run-command invoke \
  --resource-group $resourceGroup \
  --name $databaseVM \
  --command-id RunShellScript \
  --scripts "sudo apt-get update && sudo apt-get install -y mysql-server && sudo systemctl start mysql && sudo mysql -e \"CREATE DATABASE sampledb;\" && sudo mysql -e \"CREATE USER 'sampleuser'@'%' IDENTIFIED BY 'samplepass';\" && sudo mysql -e \"GRANT ALL PRIVILEGES ON *.* TO 'sampleuser'@'%';\" && sudo mysql -e \"FLUSH PRIVILEGES;\""
