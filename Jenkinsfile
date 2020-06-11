pipeline {
		 agent any
		 stages {
				 stage('Install requirements') {
						 steps {
								 sh 'python3 -m venv .devops && source .devops/bin/activate'
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
