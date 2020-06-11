pipeline {
	agent any
	stages {
	  stage('Publish Purpose') {
		  steps {
			  sh '''
				  echo "Jenkins runs the Pipeline on the Kubernetes Cluster now..."
			  '''
			}
		}
    stage('Verifying the Dockerfile') {
		  steps {
			  sh '''
				  python3 -m venv .devops
				  source /.devops/bin/activate
					make lint
				'''
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
		stage('Push the Docker-Image to Elastic Container Registry') {
		  steps {
        sh '''
				  echo "UPLOAD GOES HERE"
        '''
			}
		}
		stage('Run Load Tests, Functional Tests,...') {
		  steps {
				  input "Approve that all tests outputs are OK by hitting ENTER."
				}
		}
  }
}
