mkdir terraform_bin
cd terraform_bin/
wget https://releases.hashicorp.com/terraform/1.14.1/terraform_1.14.1_linux_amd64.zip
yum install unzip
unzip terraform_1.14.1_linux_amd64.zip
ll
ls -lrth /usr/local/bin/
cp -v terraform /usr/local/bin/