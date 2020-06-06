## The Makefile includes instructions on environment setup and lint tests
setup-brew:
	# install brew
	./install_brew.sh

setup-docker:
	# install docker on ubuntu-linux
	./install_docker.sh
	sudo groupadd docker
	sudo usermod -aG docker ${USER}

setup-Jenkins:
	# install Jenkins

install:
	# Install dependencies of Brew
	brew install gcc
	# Install hadolint, see local hadolint install instructions:   https://github.com/hadolint/hadolint
	brew install hadolint
	# Install tidy, the html-linter
	brew install tidy-html5
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
