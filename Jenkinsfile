pipeline {
	   agent any
	   stages {
         stage ('Publish Purpose') {
             steps{
                 sh 'echo "This is the default Jenkinsfile."'
             }
         }
         stage ('Guideline for Building the Infrastructure') {
             steps{
                 sh 'echo "Use the Jenkinsfile in ~/infrastructure to build the kubernetes cluster."'
             }
         }
         stage ('Guideline for Running the Pipeline') {
             steps{
                 sh 'echo "Use the Jenkinsfile in ~/pipeline to build the kubernetes cluster."'
             }
         }
     }
}
