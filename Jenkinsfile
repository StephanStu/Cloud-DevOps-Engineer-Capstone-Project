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
		stage('Deploy in the Blue Environment & Direct Traffic here for Testing') {
		  steps {
			  withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
          sh '''
					  aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectCluster
            kubectl config use-context arn:aws:eks:eu-central-1:793553224113:cluster/UdacityCapstoneProjectCluster
						kubectl apply -f ./replication_controller_for_blue_environment.json
						kubectl apply -f ./load_balancer_service_for_blue_environment.json
          '''
				}
			}
		}
		stage('Run Load Tests, Functional Tests,...') {
		  steps {
				  input "Approve that all tests outputs are OK by hitting ENTER."
				}
		}
		stage('Deploy in the Green Environment, Direct Traffic to Production Environment') {
		  steps {
			  withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
          sh '''
					  aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectCluster
            kubectl config use-context arn:aws:eks:eu-central-1:793553224113:cluster/UdacityCapstoneProjectCluster
						kubectl apply -f ./replication_controller_for_green_environment.json
						kubectl apply -f ./load_balancer_service_for_green_environment.json
          '''
				}
			}
		}
  }
}
