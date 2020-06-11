pipeline {
	agent any
	stages {
	  stage('Setup the virtual environment') {
		  steps {
			  sh '''
				  python3 -m venv ~/.devops
			  '''
			}
		}
		stage('Install requirements') {
		  steps {
			  sh '''
				  source ~/.devops/bin/activate
				  which python
			  '''
			}
		}
    stage('Verifying the Dockerfile') {
		  steps {
			  sh '''
				  source ~/.devops/bin/activate
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
