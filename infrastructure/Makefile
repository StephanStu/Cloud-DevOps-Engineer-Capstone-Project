## The Makefile includes instructions on environment setup and lint tests
# Instructions for creation of the infrastructure in AWS::EC2, e.g. the server
# for Jenkins and the SecurityGroup.
infrastructure:
	chmod u+x create_infrastructure.sh
	./create_infrastructure.sh UdacityCapstoneProject infrastructure.yml parameters.json

# Instructions for installing the command line tools of AWS: aws cli & eksctl.
# This is intended to be executed on the AWS::EC2-Instance, the server.
# Should result in aws-cli/2.0.7 Python/3.7.4 Darwin/19.4.0 botocore/2.0.0dev11
aws-command-line-tools:
	chmod u+x install_aws_cli_and_eksctl.sh
	./install_aws_cli_and_eksctl.sh

# Instructions for creation of the Jenkins-Server. This is intended
# to be executed on the server after installing the aws cli and configuring
# credentials with $ aws configure. This section has two parts, the tools and
# Jenkins.
tools:
	chmod u+x install_tools.sh
	./install_tools.sh

jenkins-server:
	chmod u+x install_jenkins.sh
	./install_jenkins.sh
# Instructions for creation of the Kubernetes-Cluster in AWS::EKS. This is intended
# to be executed on the server after installing the aws cli and configuring
# credentials with $ aws configure.
kubernetes-cluster:
	chmod u+x create_kubernetes_cluster.sh
	./create_kubernetes_cluster.sh

# Instructions to update kubectl with the cluster to be controlled on the server.
update-kubernetes-configuration:
	update_kubernetes_configuration.sh
	./update_kubernetes_configuration.sh

# Instructions to check if the infrastructure is ready for the pipeline
test-infrastructure:
	# Check, if Docker is installed
	docker --version
	# Check, if brew is available
	brew -v
	# Check, that pip is available
	pip3 --version
	# Check, that hadolint is available
	hadolint -v
	# Check, that kuebctl is available
	kubectl version --client
	# Check, that aws cli is available
	aws --version
	# Check, that eksctl is available
	eksctl version

test-and-update: test-infrastructure update-kubernetes-configuration
