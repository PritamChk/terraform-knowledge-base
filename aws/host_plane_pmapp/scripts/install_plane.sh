set -ex
###################### STEPS #################
### S1: SETUP Server TIMEZONE and HOSTNAME
server_name="$1"    # e.g., plane-server
time_zone="$2"      # e.g., Asia/Thimphu
server_pub_ip="$3"  # e.g., 10.191.89.101

# set hostname and timezone
sudo echo "Setting up Server Hostname and Timezone"
sudo hostnamectl set-hostname ${server_name}
sudo timedatectl  set-timezone "${time_zone}"
sudo timedatectl  status
sudo echo "${server_pub_ip} ${server_name}" >> /etc/hosts
sudo echo "Date Time : `date` | Timezone : $(sudo timedatectl  status | grep -i "time zone" | tr -d ' ') | Hostname : $(hostname) | Server IP : $(hostname -i)"

##############################################
### S2: Install and Setup Docker and Docker-Compose
echo "Installing Docker"

sudo yum install -y docker
sudo usermod -aG docker ec2-user

sudo echo "Installing Docker Compose"
sudo mkdir -p ~/.docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 \
  -o ~/.docker/cli-plugins/docker-compose
sudo chmod +x ~/.docker/cli-plugins/docker-compose

sudo echo "Starting Docker Service"
sudo systemctl start docker
sudo systemctl enable docker

sudo echo "Docker Version:"
sudo docker --version
sudo echo "Docker Compose Version:"
sudo docker-compose --version    
##############################################

## S3: Install and Setup Plane Self-Hosted Control Plane
### set bash profile variables
echo "export LISTEN_HTTP_PORT=$4" >> ~/.bash_profile
echo "export LISTEN_HTTPS_PORT=$5" >> ~/.bash_profile
echo "export WEB_URL='http://$pub_ip:$LISTEN_HTTP_PORT'" >> ~/.bash_profile
echo "export CORS_ALLOWED_ORIGINS='http://$pub_ip:$LISTEN_HTTP_PORT'" >> ~/.bash_profile
echo "export TMOUT_DURATION=0" >> ~/.bash_profile
echo "export TMOUT=0" >> ~/.bash_profile
echo "export TIMEMOUT=0" >> ~/.bash_profile

source ~/.bash_profile
. ~/.bash_profile

mkdir -p plane-selfhost
cd plane-selfhost

curl -fsSL -o setup.sh https://github.com/makeplane/plane/releases/latest/download/setup.sh
chmod -R +x ../
echo "Installing Plane Self-Hosted Control Plane"
./setup.sh install
echo "Starting Plane Self-Hosted Control Plane"
./setup.sh start
##############################################


