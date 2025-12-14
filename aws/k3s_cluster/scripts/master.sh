node_name=$1
version=$2

if [ -z "$node_name" ]; then
    echo "Usage: $0 <node_name> not given so setting to default master-n1"
    node_name="master-n1"
fi

if [ -z "$version" ]; then
    echo "Usage: $0 <node_name> <k3s_version> not given so setting to default v1.34.2+k3s1"
    version="v1.34.2+k3s1"
fi

replace_with="%2B"
version_for_url=${version//+/%2B}
download_link="https://github.com/k3s-io/k3s/releases/download/$version_for_url/k3s"


# Switch to root
# sudo su
# Set hostname
sudo hostnamectl set-hostname $node_name
# Download the latest K3s binary
sudo curl -Lo /usr/local/bin/k3s \
  $download_link \
  && sudo chmod a+x /usr/local/bin/k3s

# Start the server in the background, allow kubectl access to kubeconfig
sudo nohup k3s server --write-kubeconfig-mode 644 &

# Create kubectl symlink
sudo ln -sf /usr/local/bin/k3s /usr/local/bin/kubectl

# Save start/stop scripts
cat << 'EOF' > startk3s_cluster.sh
#!/bin/bash
nohup k3s server --write-kubeconfig-mode 644 &
EOF
sudo chmod +x startk3s_cluster.sh

cat << EOF > stopk3s_cluster.sh
#!/bin/bash
pkill -f k3s
EOF
sudo chmod +x stopk3s_cluster.sh

## Generate and display the node token for worker nodes to join the cluster
echo "K3s Master Node Token (use this to join worker nodes to the cluster):"
sudo cat /var/lib/rancher/k3s/server/node-token > /tmp/token.txt
sudo cat /tmp/token.txt

exit 0
