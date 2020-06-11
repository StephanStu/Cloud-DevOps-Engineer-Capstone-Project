pipeline {
		 agent any
		 stages {
				 stage('Install requirements') {
						 steps {
								 sh 'python3 -m venv .devops'
								 sh 'ls -a'
						 }
				 }
				 stage('Next') {
						 steps {
								 sh 'echo "Hello"'
							}
				 }
		 }
}
