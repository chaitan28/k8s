cd ./k8s
echo "Installing MicroK8s with kubernetes version 1.20"
sudo snap install microk8s --classic --channel=1.20/stable
echo "waiting to confirm installation"
sudo microk8s status --wait-ready
echo "Enabling admin privileges to microk8s"
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
echo "now run join link which is generated on master node, if not yet generated run command: sudo microk8s add-node    on master node "
