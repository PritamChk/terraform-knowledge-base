# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
#
alias ll='ls -lrth'
alias l='ls -lrth'
alias size='du -sh | sort -hr'
alias tf='terraform'
alias tfh='terraform --help'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'


export AWS_ACCESS_KEY=$(cat .aws_secrets/access_key | base64 -d)
export AWS_SECRET_KEY=$(cat .aws_secrets/secret_key | base64 -d)
export AWS_DEFAULT_REGION=$(cat .aws_secrets/default_region | base64 -d)
