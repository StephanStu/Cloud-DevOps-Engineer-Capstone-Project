## The Makefile includes instructions on lint tests
# Instructions for testing the microservice
setup:
	# Create python virtualenv & source it with source ~/.devops/bin/activate
	python3 -m venv ~/.devops
install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt
# Instructions for linting the artficacts
lint:
	# Source the virtual environment before by
	# $ source infrastructure/.devops/bin/activate
	# (deactivate with $ deactivate)
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	#hadolint Dockerfile
	/home/linuxbrew/.linuxbrew/bin/hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	# Remove check W1309 to satisfy requirements, code is rated 10 of 10 then.
	pylint --disable=R,C,W1203,W1309 app.py
# Instructions for building the docker image
build:
	# Building the image
	docker build -t stephanstu/predictor .
	# List all images on this host
	docker image ls
# Instructions for removing the (old) images from the host
remove-image:
	# Remove all images on the host (to save disc space...)
	docker rmi $(docker images -a -q) --force
# Instructions for deployment in test environment:
# A ReplicationController ensures that a specified number of pod
# replicas are running at any one time, see
# https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/ .
# On cloud providers which support external load balancers, setting the
# type field to LoadBalancer provisions a load balancer for your Service, see
# https://kubernetes.io/docs/concepts/services-networking/service/
deploy-test:
	aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectKubernetesCluster
	kubectl config use-context arn:aws:eks:eu-central-1:793553224113:cluster/UdacityCapstoneProjectKubernetesCluster
	#kubectl run test  --replicas=1 --labels='app=test' --image=stephanstu/predictor --port=80
	kubectl apply -f controller_for_test.yaml
	kubectl describe replicationcontrollers
	kubectl create -f loadbalancer_for_test.yaml
	kubectl describe service
	kubectl get nodes
	kubectl get pods
	kubectl get service
# Instructions for deployment in production environment:
# A ReplicationController ensures that a specified number of pod
# replicas are running at any one time, see
# https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/ .
# On cloud providers which support external load balancers, setting the
# type field to LoadBalancer provisions a load balancer for your Service, see
# https://kubernetes.io/docs/concepts/services-networking/service/
deploy-production:
	aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectKubernetesCluster
	kubectl config use-context arn:aws:eks:eu-central-1:793553224113:cluster/UdacityCapstoneProjectKubernetesCluster
	#kubectl run production  --replicas=1 --labels='app=production' --image=stephanstu/predictor --port=80
	kubectl apply -f controller_for_production.yaml
	kubectl describe replicationcontrollers
	kubectl create -f loadbalancer_for_production.yaml
	kubectl describe service
	kubectl get nodes
	kubectl get pods
	kubectl get service
# Instructions to purge the environment (test & production)
purge:
	kubectl delete replicationcontrollers --all
	kubectl delete service test-loadbalancer
	kubectl delete service production-loadbalancer
	kubectl get pods
	kubectl get service

all: lint test build deploy-test deploy-production
