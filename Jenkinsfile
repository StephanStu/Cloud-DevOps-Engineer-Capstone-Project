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
				 stage('Deploy for testing') {
				 		 steps{
						 			withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
										sh 'make deploy-test'
									}
						 }
				 }
				 stage('Run functional tests in target environment') {
		 		  	 steps{
						     sh 'echo "The machine learning application is called at the URL of the load-balancer:"'
		 				  	 sh 'chmod u+x test_prediction.sh'
								 sh './test_prediction.sh'
								 sh 'echo "If this step fails: Fix the URL of the load-balancer in test_prediction.sh!"'
								 input "Verify that the result is 20.35373177134412."
		 				 }
		 		 }
				 stage('Deploy in production'){
				 		 steps{
						 			withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
									  sh 'make deploy-production'
									}
						 }
				 }
		 }
}
