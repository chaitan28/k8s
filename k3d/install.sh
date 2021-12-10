echo "installing docker"
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt install docker-ce -y
sudo curl -LO https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl
echo "Installing kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "installing rancher/k3d using curl"
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=v4.0.0 bash
echo "k3d installed "
echo "Creating Multi-Node Clusters"
sudo k3d cluster create multinode --agents 2 --servers 1
sleep 5
echo "check your cluster"
sudo kubectl get nodes
