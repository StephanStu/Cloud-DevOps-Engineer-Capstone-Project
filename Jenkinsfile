pipeline {
		 agent any
		 stages {
				 stage('Create a virtual environment') {
						 steps {
								 sh 'make setup'
								 sh 'source ~/.devops/bin/activate && make install'
						 }
				 }
				 stage('Lint artifacts') {
						 steps {
						 		 sh """
								 		 source ~/.devops/bin/activate'
								  	 make lint
								"""
							}
				 }
		 }
}
