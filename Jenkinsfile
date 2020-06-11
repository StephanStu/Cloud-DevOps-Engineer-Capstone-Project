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
				 stage('Next') {
						 steps {
								 sh 'echo "Hello"'
							}
				 }
		 }
}
