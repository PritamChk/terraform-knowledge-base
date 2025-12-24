# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
#


export AWS_ACCESS_KEY=$(cat ~/.aws_secrets/access_key | base64 -d)
export AWS_SECRET_KEY=$(cat ~/.aws_secrets/secret_key | base64 -d)
export AWS_DEFAULT_REGION=$(cat ~/.aws_secrets/default_region | base64 -d)

alias ll='ls -lrth'
alias l='ls -lrth'
alias size='du -sh | sort -hr'
alias aws='cd PRITAM/terraform-knowledge-base/aws/'
alias tf='terraform'
alias tfh='terraform --help'
alias tfi='terraform init'
alias tfp='terraform plan -var secret_key=$AWS_SECRET_KEY -var access_key=$AWS_ACCESS_KEY'
alias tfpo='terraform plan -var secret_key=$AWS_SECRET_KEY -var access_key=$AWS_ACCESS_KEY -out plan$(date +'%d%b%Y_%H%M%S').plan'
alias tfa='terraform apply -var secret_key=$AWS_SECRET_KEY -var access_key=$AWS_ACCESS_KEY -var region=$AWS_DEFAULT_REGION'
alias tfd='terraform destroy -var secret_key=$AWS_SECRET_KEY -var access_key=$AWS_ACCESS_KEY --auto-approve'
alias tfv='terraform validate'
alias tfr='terraform refresh -var access_key=$AWS_ACCESS_KEY -var secret_key=$AWS_SECRET_KEY'

