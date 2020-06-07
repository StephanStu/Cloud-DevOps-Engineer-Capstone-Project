## The Makefile includes instructions on environment setup and lint tests
# Instructions for creation of the infrastructure in AWS::EC2, e.g. the server
# for Jenkins and the SecurityGroup.
infrastructure:
	chmod u+x create.sh
	./create.sh UdacityCapstoneProject infrastructure.yml parameters.json

# Instructions for installing the command line tools of AWS: aws cli & eksctl.
# This is intended to be executed on the AWS::EC2-Instance, the server.
# Should result in aws-cli/2.0.7 Python/3.7.4 Darwin/19.4.0 botocore/2.0.0dev11
aws-command-line-tools:
	sudo apt install unzip
	$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
	aws --version
	# Install eksctl
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin
	eksctl version
	# Confiure aws cli, be ready to provide credentials...
	aws configure

# Instructions for creation of the Kubernetes-Cluster in AWS::EKS. This is intended
# to be executed on the server after installing the aws cli and configuring
# credentials with $ aws configure.
kubernetes-cluster:
	eksctl create cluster --name UdacityCapstoneProjectCluster --version 1.13 --nodegroup-name standard-workers --node-type t2.micro --nodes 2 --nodes-min 1 --nodes-max 3 --node-ami auto --region eu-central-1 --zones eu-central-1a --zones eu-central-1b


# Instructions for creation of the Jenkins-Server. This is intended
# to be executed on the server after installing the aws cli and configuring
# credentials with $ aws configure.
jenkins-server:
	# Install brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	# Missing commands here...
	# Install docker on ubuntu-linux
	./install_docker.sh
	sudo groupadd docker
	sudo usermod -aG docker ${USER}
	# Install kubectl
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
	# Install dependencies of Brew
	brew install gcc
	# Install hadolint, see local hadolint install instructions:   https://github.com/hadolint/hadolint
	brew install hadolint
	# Install virtual environments for python3
	sudo apt-get install python3-venv
	# Install linter for python3
	sudo apt install pylint

# Instructions to update kubectl with the cluster to be controlled on the server.
update-kubernetes-configuration:
	aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectCluster

test:
	# Check, if Docker is installed
	docker --version
	# Check, if brew is available
	brew help
	# Check, that hadolint is available
	hadolint -v
	# Check, that kuebctl is available
	kubectl version --client
	# Check, that aws cli is available
	aws --version
	# Check, that eksctl is available
	eksctl version
	# Return an OK
	echo "Toolchain is ready."

lint:
	# Run linter for Dockerfiles
	hadolint Dockerfile
	# Run linter for html-files
	tidy index.html
	# Return an OK
	echo "Files are OK."

all: test lint
