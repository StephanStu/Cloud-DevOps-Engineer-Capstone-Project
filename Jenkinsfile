pipeline {
		 agent any
		 stages {
				 stage('Install requirements') {
						 steps {
								 sh 'python3 -m venv .devops'
								 sh 'source .devops/bin/activate'
						 }
				 }
				 stage('Next') {
						 steps {
								 sh 'echo "Hello"'
							}
				 }
		 }
}
