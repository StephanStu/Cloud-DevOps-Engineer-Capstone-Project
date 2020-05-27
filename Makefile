## The Makefile includes instructions on environment setup and lint tests
setup-brew:
	# install brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

setup-Jenkins:
	# install Jenkins

install:
	# Install dependencies of Brew
	brew install gcc
	# Install hadolint, see local hadolint install instructions:   https://github.com/hadolint/hadolint
	brew install hadolint
	# Install tidy, the html-linter
	brew install tidy-html5

test:
	# Check, if Docker is installed
	docker --version
	# Check, if brew is available
	brew help
	# Check, that tidy is available
	tidy -v
	# Check, that hadolint is available
	hadolint -v
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# Run linter for Dockerfiles
	hadolint Dockerfile
	# Run linter for html-files
	tidy index.html

all: install lint test
