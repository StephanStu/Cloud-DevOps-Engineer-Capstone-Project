sudo apt-get update
sudo apt install -y default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
# This might be necessary to fix packaes...
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <ENTER MISSING KEY HERE>
# install jenkins
sudo apt-get install -y jenkins
# allow docker with Jenkins
sudo usermod -a -G docker jenkins
# get initial pasword for jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
# start jenkins
sudo systemctl start jenkins
# enable jenkins at launch
sudo systemctl enable jenkins
# check status of jenkins and finish
sudo systemctl status jenkins
