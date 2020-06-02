pipeline {
	agent any
	stages {
	  stage('Publish Purpose') {
		  steps {
			  sh 'echo "Jenkins creates the Kubernetes Cluster and Nodes now..."'
			}
		}
		stage('Create Cluster and Nodes') {
			steps {
				withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
					sh '''
						eksctl create cluster \
						--name UdacityCapstoneProjectCluster \
						--version 1.13 \
						--nodegroup-name standard-workers \
						--node-type t2.small \
						--nodes 2 \
						--nodes-min 1 \
						--nodes-max 2 \
						--node-ami auto \
						--region eu-central-1 \
						--zones eu-central-1a \
						--zones eu-central-1b \
					'''
				}
			}
		}
		stage('Create the Cluster Configuration File') {
			steps {
				withAWS(region:'eu-central-1', credentials:'UdacityCapstoneDeveloper') {
					sh '''
						aws eks --region eu-central-1 update-kubeconfig --name UdacityCapstoneProjectCluster
					'''
				}
			}
		}

	}
}
