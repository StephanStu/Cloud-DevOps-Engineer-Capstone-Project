pipeline {
	agent any
	stages {
	  stage('Publish Purpose') {
		  steps {
			  sh 'echo "Jenkins runs the Pipeline on the Kubernetes Cluster now..."'
			}
		}
		stage('Verifying the Artifacts of the Website') {
		  steps {
			  sh 'tidy -q -e *.html'
			}
		}
    stage('Verifying the Dockerfile') {
		  steps {
			  sh 'hadolint Dockerfile'
			}
		}
    stage('Building the Docker-Image') {
		  steps {
        sh '''
          chmod u+x build_docker_image.sh
			    ./build_docker_image.sh
        '''
			}
		}
  }
}
