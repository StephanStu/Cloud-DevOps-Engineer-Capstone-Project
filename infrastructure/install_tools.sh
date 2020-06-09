# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# Install docker on ubuntu-linux
chmod u+x install_docker.sh
./install_docker.sh
sudo groupadd docker
sudo usermod -aG docker ${USER}
# Install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
# Install pip
sudo apt update
sudo apt install python-pip
# Install dependencies of Brew
brew install gcc
# Install hadolint, see local hadolint install instructions:   https://github.com/hadolint/hadolint
brew install hadolint
# Install virtual environments for python3
sudo apt-get install python3-venv
# Install linter for python3
sudo apt install pylint
# Create the virtual environment and source it
python3 -m venv .devops
source .devops/bin/activate
# Install requirements of application
pip install --upgrade pip &&\
  pip install -r requirements.txt
# Add brew to shell:
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/ubuntu/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# Add to path /home/ubuntu/.local/bin, s.t. flask and other python adds run
export PATH="/home/ubuntu/.local/bin:$PATH"
