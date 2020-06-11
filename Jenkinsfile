pipeline {
		 agent any
		 stages {
				 stage('Install requirements') {
						 steps {
								 sh 'make setup'
								 sh 'source ~/.devops/bin/activate'
								 sh 'make install'
						 }
				 }
				 stage('Lint artifacts') {
						 steps {
						 		 sh 'source ~/.devops/bin/activate'
								 sh 'make lint'
							}
				 }
		 }
}
