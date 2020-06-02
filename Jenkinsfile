pipeline {
	agent any
	stages {
	  stage('Publish Purpose') {
		  steps {
			  sh '''
				  echo "Jenkins runs the Pipeline on the Kubernetes Cluster now..."
			  '''
			}
		}
		stage('Verifying the Artifacts of the Website') {
		  steps {
			  sh 'tidy -q -e *.html'
			}
		}
    stage('Verifying the Dockerfile') {
		  steps {
			  sh '''
			    /home/linuxbrew/.linuxbrew/bin/hadolint Dockerfile
				'''
			}
		}
    stage('Building the Docker-Image') {
		  steps {
        sh '''
          chmod u+x build_docker_image.sh
			    ./build_docker_image.sh
        '''
			}
		}
		stage('Push the Docker-Image to Elastic Container Registry') {
		  steps {
			  withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
          sh '''
            chmod u+x upload_docker_to_ecr.sh
			      ./upload_docker_to_ecr.sh
          '''
				}
			}
		}
		stage('Deploy the Docker Image in the Blue Environment') {
		  steps {
			  withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
          sh '''
					  aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectCluster
            kubectl config use-context arn:aws:eks:eu-central-1:793553224113:cluster/UdacityCapstoneProjectCluster
          '''
				}
			}
		}
  }
}
