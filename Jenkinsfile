pipeline {
				environment{
				app = "predictor"
				}
				agent any
				stages {
					stage('Setup a virtual environment') {
							steps {
							sh 'make setup'
							}
					}
				}
}
