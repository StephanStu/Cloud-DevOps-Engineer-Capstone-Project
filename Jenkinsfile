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
						 		 sh 'chmod u+x build_docker_image.sh'
								 sh './build_docker_image.sh'
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
						     sh '$DOCKER_USERNAME'
						 		 sh 'chmod u+x upload_docker_image.sh'
								 sh './upload_docker_image.sh'
								 sh 'docker rmi $(docker images -a -q) --force'
						 }
				 }
		 }
}
