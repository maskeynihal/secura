read -p "Enter URL for vault: " vault_url

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault

sudo apt install certbot

sudo certbot certonly --standalone -d $vault_url

sudo chown -R vault:vault /etc/letsencrypt

sudo cp ./vault.service /etc/systemd/system/vault.service

sudo cp ./vault.hcl /etc/vault.d/vault.hcl

sudo systemctl reload-daemon

sudo systemctl enable vault

sudo systemctl start vault