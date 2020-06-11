pipeline {
		 agent any
		 stages {
				 stage('Setup a virtual environment') {
						 steps {
								 sh 'make setup'
						 }
				 }
				 stage('Install the requirements') {
						 steps {
								 sh 'source ~/.devops/bin/activate'
								 sh 'pwd'
							}
				 }
		 }
}
