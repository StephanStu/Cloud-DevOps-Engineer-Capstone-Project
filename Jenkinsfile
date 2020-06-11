pipeline {
		 agent any
		 stages {
				 stage('Install requirements') {
						 steps {
								 sh 'make setup'
								 sh 'source ~/.devops/bin/activate && make install'
						 }
				 }
				 stage('Lint artifacts') {
						 steps {
						 		 sh """
								 		 source ~/.devops/bin/activate
								  	 make lint
								"""
							}
				 }
				 stage('Build the image') {
				 		 steps{
						 		 sh 'make build'
						 }
				 }
				 stage('Run functional tests on the host') {
				 		 steps{
						 		 sh 'echo "Include some regression tests on the host here."'
								 sh 'echo "Assume that tests have passed..."'
						 }
				 }
				 stage('Upload the image') {
				 		 steps{
						 		 withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
								   sh '''
									   docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
									   docker push stephanstu/predictor
								   '''
								 }
						 }
				 }
				 stage('Configure Kubernetes') {
				 		 steps{
						 			withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
										sh '''
											aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectKubernetesCluster
											kubectl config use-context arn:aws:eks:eu-central-1:793553224113:cluster/UdacityCapstoneProjectKubernetesCluster
										'''
									}
						 }
				 }
				 stage('Purge the test-environment') {
				 		 steps{
						 			withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
								 		sh 'kubectl delete service test-loadbalancer'
								 		sh 'kubectl delete pod test'
								 		sh 'kubectl get pods'
								 		sh 'kubectl get service'
								  }
						 }
				 }
				 stage('Deploy for testing') {
				 		 steps{
						 			withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
										sh '''
											kubectl run test  --replicas=1 --labels='app=test' --image=stephanstu/predictor --port=80
											kubectl create -f loadbalancer_for_test.yaml
											kubectl get nodes
											kubectl get pods
											kubectl get service
										'''
									}
						 }
				 }
				 stage('Run functional tests in target environment') {
		 		  	 steps{
		 				  	  input "Go to host; paste the URL of the loadbalancer in test_predicition.sh and run it. The expected result is 20.35373177134412."
		 				 }
		 		 }
		 }
}
