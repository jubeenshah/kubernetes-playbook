sudo baker status
sudo baker destroy
cd server/ansible-srv
sudo baker bake
echo "Preliminary Ansible server is setup"
cd ../kubernetes-srv/
sudo baker destroy
sudo baker bake
echo "Preliminary Kubernetes server is setup"
sudo baker status
ssh-keygen -t rsa -b 4096 -C "web-srv-k" -f web-srv-k
echo "Created a public and private key with name web-srv in server/kubernetes-srv/"
