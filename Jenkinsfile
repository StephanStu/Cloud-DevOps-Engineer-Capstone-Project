pipeline {
		 agent any
		 stages {
				 stage('Create a virtual environment') {
						 steps {
								 sh 'make setup'
						 }
				 }
				 stage('Lint artifacts') {
						 steps {
						 		 sh 'source ~/.devops/bin/activate'
								 sh 'make install'
								 sh 'make lint'
							}
				 }
		 }
}
