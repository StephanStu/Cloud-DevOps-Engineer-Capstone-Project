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
				 stage('Test the image') {
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
		 }
}
