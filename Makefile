## The Makefile includes instructions on environment setup and lint tests
setup-brew:
	# install brew
	./install_brew.sh

setup-docker:
	# install docker on ubuntu-linux
	./install_docker.sh
	sudo groupadd docker
	sudo usermod -aG docker ${USER}

setup-kubectl:
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

setup-aws-cli:
	sudo apt install unzip
	$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install

setup-eksctl:
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin

setup-Jenkins:
	# install Jenkins

install:
	# Install dependencies of Brew
	brew install gcc
	# Install hadolint, see local hadolint install instructions:   https://github.com/hadolint/hadolint
	brew install hadolint
	# Install tidy, the html-linter
	brew install tidy-html5
	# Install kubectl
	#curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.4/bin/linux/amd64/kubectl
	#chmod +x ./kubectl
	#sudo mv ./kubectl /usr/local/bin/kubectl
	#kubectl version --client
	# Return an OK
	echo "Toolchain is installed."

test:
	# Check, if Docker is installed
	docker --version
	# Check, if brew is available
	brew help
	# Check, that tidy is available
	tidy -v
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
