node_name=$1
version=$2
node_ip=$3
token=$4

if [ -z "$node_name" ]; then
    echo "Usage: $0 <node_name> not given so setting to default master-n1"
    node_name="worker-n1"
fi

if [ -z "$version" ]; then
    echo "Usage: $0 <node_name> <k3s_version> not given so setting to default v1.34.2+k3s1"
    version="v1.34.2+k3s1"
fi

replace_with="%2B"
version_for_url=${version//+/%2B}
download_link="https://github.com/k3s-io/k3s/releases/download/$version_for_url/k3s"


# Switch to root

# Set hostname
sudo hostnamectl set-hostname $node_name
sudo echo "$node_ip $node_name" >> /etc/hosts
# Download the latest K3s binary
sudo curl -Lo /usr/local/bin/k3s \
  $download_link \
  && sudo chmod a+x /usr/local/bin/k3s

# Start the server in the background, allow kubectl access to kubeconfig
#nohup k3s server --write-kubeconfig-mode 644 &

# Create kubectl symlink
sudo ln -sf /usr/local/bin/k3s /usr/local/bin/kubectl


echo "nohup k3s agent --server https://$node_ip:6443 --token $token &"
echo "sudo nohup k3s agent --server https://$node_ip:6443 --token $token  &" > setupNode.sh
sudo chmod +x setupNode.sh
if [ -z "$token" ]; then
    echo "Error: K3s token is required to join the worker node to the cluster."
    exit 1
else
    sudo ./setupNode.sh
fi
exit 0