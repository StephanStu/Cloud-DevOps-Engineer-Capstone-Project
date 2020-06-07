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
# Install requirmeents of application
pip install --upgrade pip &&\
  pip install -r requirements.txt
