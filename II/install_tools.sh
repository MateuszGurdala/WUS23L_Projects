#Install jq
sudo apt update
sudo apt install jq -y

#Install yq
sudo apt install snap -y
sudo snap install yq

#Azure CLI
sudo apt install ca-certificates curl apt-transport-https lsb-release gnupg -y
sudo mkdir -p /etc/apt/keyrings

curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/keyrings/microsoft.gpg >/dev/null

sudo chmod go+r /etc/apt/keyrings/microsoft.gpg

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt install azure-cli -y

#Ansible
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y

sudo apt upgrade -y
