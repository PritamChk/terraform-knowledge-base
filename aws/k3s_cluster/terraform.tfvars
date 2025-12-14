access_key="AKIAS2VS4OCCSRUOBJGI"
master_vm_tag={
    Name = "k3s-master-node"
}
worker_vm_tag={
    Name = "k3s-worker-node"
}
vm_type = "t2.medium"
os="ami-00ca570c1b6d79f36"
key_name = "aws-k3s-key"
private_key_path = "/home/ec2-user/.ssh/aws-k3s-key.ppk"