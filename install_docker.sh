sudo apt update
sudo apt upgrade
# Install Prerequisite Packages
# apt-transport-https – lets the package manager transfer tiles and data over https
# ca-certificates – lets the web browser and system check security certificates
# curl – transfers data
# software-properties-common – adds scripts to manage the software
sudo apt-get install curl apt-transport-https ca-certificates software-properties-common
# Now we have to add the Docker repositories. This will make the installation process much easier. This enables us to use the officially supported method of the installation.
# First, we add the GPG key, by entering the following command in the command line:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
