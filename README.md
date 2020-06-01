# Udacity's Cloud-DevOps-Engineer Nanodegree Program: The Capstone-Project
This repository contains my solution for the capstone-project of Udacity's Cloud DevOps Engineer Nanodegree Program.  For details of the program see [here](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991).
In this project the skills & knowledge which were developed throughout the Cloud DevOps Nanodegree program are applied in practice. These include:

* Working in AWS
* Using Jenkins to implement Continuous Integration and Continuous Deployment
* Building pipelines
* Working with Ansible and CloudFormation to deploy clusters
* Building Kubernetes clusters
* Building Docker containers in pipelines

## Section I: Project Overview
In this project the blue/green-deployment pattern is implemented in a cloud-native fashion with Jenkins and a set of services of Amazon Web Services. A static website is deployed in a web servers, which is a containerized application that runs in a Kubernetes Cluster.

## Section II: Results & Guideline to Build this Project
This section wraps up the achievements of this project.
The following section describe the details of the implementation of the blue/green-deployment pattern,

* Section III describes in detail how to spawn the infrastructure in Amazon Web Services using CloudFormation.
* Section IV describes in detail how to setup the web server, the operates the pipeline
* Section V describes the pipeline in detail.
* Section VI wraps up knowledge on Kubernetes, Docker and useful ways-of-working.

## Section III: Spawn the Infrastructure using CloudFormation
This section describes how to set up the infrastructure for the continuous integration / continuous deployment pipeline that this repository contains. The infrastructure is spawned using Amazon Web Service's CloudFormation, a language for deploying _infrastructure-as-code_. One of the many advantages of CloudFormation is, that the infrastructure can be deleted and updated from command line, so it is easy to keep track of a large number of entities in an account.


The _stack_ in Amazon Web Service is created by
`$ ./create.sh UdacityCapstoneProject infrastructure.yml parameters.json`.
After running the CloudFormation script with parameters, the stack appears with all resources and outputs as displayed in the figure below.

![spawn_infrastructure.png](doc/spawn_infrastructure.png)

To create the Kubernetes Cluster in Amazon Web Service, an additional command line interface is used, the _eksctl_ API. The installation is outlined below. To spawn the Kubernetes Cluster, run `$ chmod u+x run_docker_image_on_local_host.sh` to grant permission to execute followed by

`$ create_eks_cluster.sh `

A successful creation of the cluster and the nodes will be visible in CloudFormation as displayed in the figure below.

![spawn_eks_cluster](doc/spawn_eks_cluster.png)

**Note**: When the stack is deleted, all it's entities are removed as well. If the entities are created manually, one has to keep track of destruction of all entities after the infrastructure is not longer needed.

### Spawn a Repository in Elastic Container Registry
As part of the stack, a repository is created in Amazon Web Service' Elastic Container Registry (ECR).
The repository name is defined in _parameters.json_, by the variable `RepositoryName`.
Note: Inside _infrastructure.yml_, a user has been hardcoded with rights to push and pull containers, see `- "arn:aws:iam::793553224113:user/UdacityCapstoneDeveloper"`. If you pull this GitHub-Repository and spawn the infrastructure, be sure to add and / or replace your users here.

### Spawn a Security Group
A firewall solution that performs one primary function is needed: Filter incoming and outgoing traffic from an EC2 instance. In Amazon Web Service this solution is called a _Security Group_. It accomplishes this filtering function at the TCP and IP layers, via their respective ports, and source/destination IP addresses. The spawned filter allows

* outbound traffic to everyone.
* inboud traffic via SSH from one IP-Address - the IP-Address of the administrator / Cloud DevOps Engineer, who must ssh into the server (to be provided in _parameters.json_ as , `UdacityCapstoneDeveloperIP`)
* inbound traffic via TCP on port 80 from one IP-Address - the IP-Address of the administrator / Cloud DevOps Engineer, who must configure Jenkins (to be provided in _parameters.json_ as , `UdacityCapstoneDeveloperIP`)

### Spawn a Web Server for Continuous Integration & Deployment
A web server is needed to host Jenkins and run tools that implement the continuous integration- & deployment-pipeline. The web server is an instance of Amazon Web Service's EC2-Solutions with

* machine image: Ubuntu Bionic-18.04-amd64 (ami-0e342d72b12109f91)
* type: t2.micro

### Spawn a Kubernetes Cluster
A cluster is a set of nodes, that may be deployed on a number of Amazon EC2 instances. It is created prior to creation of _worker-nodes_.

### Spawn a Kubernetes Nodegroup
Worker machines in Kubernetes are called nodes. Nodes contain pods and pods contain the containerized applications - docker images. Amazon's implementation of Kubernetes lets worker nodes run in an account and connect to a cluster's control plane via the cluster API server endpoint. One or more worker nodes are deployed into a node group. A node group is one or more Amazon EC2 instances that are deployed in an Amazon EC2 Auto Scaling group.

## Section IV: Setup the Web Server for Continuous Integration & Deployment
After the infrastructure has been spawned, the next step is to _ssh into_ the web server and install the tools that execute continuous integration & deployment on the machine. First,

`$ sudo apt install make`

in order to install _make_. This allows to execute the _Makefile_.
The _Makefile_ can be found in the root of this repository; the repository must be checked out on the machine by

`$ git clone https://github.com/StephanStu/Cloud-DevOps-Engineer-Capstone-Project.git`

Then, cd into the created folder to and `$ ls` will display the _Makefile_.

### Install Amazon Web Service's Command Line Interface & Kubernetes Cluster Control
Amazon Web Service's Command Line Interface is needed to access the infrastructure from the web server in an automatic fashion, e.g. to upload container images to the container repository provided by Amazon Web Service. To install Amazon Web Service's Command Line Interface,

`$ curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"``

Then, `$ unzip awscliv2.zip` and `$ sudo ./aws/install`. The installation can be tested with `$ aws --version`. Next, download and extract the latest release of _eksctl_, the command line tool that allows control of the Kubernetes cluster,  with the following command:

`$ curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp`

Move the extracted binary, `$ sudo mv /tmp/eksctl /usr/local/bin` and test that installation was successful by `$ eksctl version`. These guidelines have been taken from [this source](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html).
**Note**: The GitTag version should be at least 0.20.0.

### Install Brew - A package management system
Brew is package management system that is needed to deploy necessary tools on the machine. To install brew, enable execution of _install_brew.sh_,

`$ chmod u+x install_brew.sh`

and

`$ make setup-brew`

After the installation is finished, configure Homebrew in your /home/ubuntu/.profile by running

`$ echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/ubuntu/.profile`

and add Homebrew to your PATH,

`$ eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)`

**Note:** This step requires the attention of the administrator, i.e. user input during execution is requested.

### Install Docker
To install Docker, enable execution of _install_docker.sh_,

`$ chmod u+x install_docker.sh`

and

`$ make setup-docker`

**Note:** This step requires the attention of the administrator, i.e. user input during execution is requested.

### Install GCC, hadolint & tidy
It is recommended by _Brew_, that GCC is installed on the server. Moreover, the pipeline requires to check Docker-Files and .html-files prior to their deployment. Checking the files for semantic errors and non-functional requirements is also called _linting_. Consequently, _linters_ for Dockerfiles and .html-files must be installed on the web server. These tasks are wrapped up by

`$ make install`

Two linters are deployed on the machine: The linter for Docker-files is _hadolint_ & The linter for html-files is _tidy_.

**Note:** This step requires the attention of the administrator, i.e. user input during execution may be requested because packages might be out-of-date. Successfull execution of this procedure exits with `Toolchain is installed.`.

**Note:** It is recommended to run `make test` to check if installation has been successfull. If this command does not exit with `Toolchain is ready.`, errors must be fixed before the next step.

### Run the Docker-Image on the Host
This file must be given permission to run (run `$ chmod u+x run_docker_image_on_local_host.sh` first). The docker image is build by

`$ chmod u+x build_docker_image.sh` (to allow execution) followed by `$ ./build_docker_image.sh`

After the image has been build, all images available on the host are listed.
Note, that the recently created image appears in the list.
The image can be run by

`$ ./run_docker_image_on_local_host.sh`

Then, the web server is running as a containerized application and publishes the static website on port 8000 of the host as displayed in the merged screenshots below.

![local_container_run](doc/local_container_run.png)

**Note:** If you see `Got permission denied while trying to connect to the Docker daemon socket at unix:///...`, search for help [here](https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket).

### Configure Credentials of Amazon Web Service's Command Line Interface & Upload the Image to the Container Repository
One goal of the pipeline is to keep track of healthy container images. Therefor, linted & tested images are kept in a container repository provided by Amazon Web Services, the Elastic Container Registry, that has been spawned as part of the infrastructure.
To enable this, configure the credentials of the command line interface on the server locally with appropriate user credentials (access to ECR is needed) by,

`$ aws configure`

Enter access key and secret access key of a user with appropriate credentials (administrator rights always work, but this is in conflict with the _least privilege policy_ taught in the class).
To upload container images to the container repository created as part of the stack in _infrastructure.yml_, run `$ chmod u+x upload_docker_to_ecr.sh` followd by

`$ ./upload_docker_to_ecr.sh`

The previously created docker image is now pushed into the container repository provided by Amazon Web Service (an alternative container repository is DockerHub, see the Knowledge section).

![push_containers_to_ecr](doc/push_containers_to_ecr.png)

### Install & Configure Jenkins - The Continuous Integration / Continuous Deployment Tool
Jenkins will be available on port 8080 of the web server. The URL can be found in the EC2-Management Console as shown in the figure below.

![get_jenkins_url_from_webserver.png](doc/get_jenkins_url_from_webserver.png)

To install Jenkins follow these steps:
#### Step 1: Update existing packages
Run

`$ sudo apt-get update`

on the host to complete this step.

#### Step 2:  Install Java
Run

`$ sudo apt install -y default-jdk`

on the host to complete this step.

#### Step 3: Download Jenkins package.
You can go to http://pkg.jenkins.io/debian/ to see the available commands. First, add a key to your system by

`$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -``

#### Step 4: Add the following entry in your /etc/apt/sources.list:
Run

`$ sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' `

on the host to complete this step.

#### Step 5a): Update your local package index
Run

`$ sudo apt-get update`

on the host to complete this step.

#### Step 5b): _Sometimes_ packages are not (yet) valid and keys must be added manually
This can be resolved shown in the figure below

![manage_packages_before_install_jenkins](doc/manage_packages_before_install_jenkins.png)

Run this command and replace the missing keys:

`$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <ENTER MISSING KEY HERE>`

#### Step 6: Install Jenkins
Run

`$ sudo apt-get install -y jenkins`

on the host to complete this step.

#### Step 7: Start the Jenkins server
Run

`$ sudo systemctl start jenkins`

on the host to complete this step.

#### Step 8: Enable the service to load during boot
Run

`$ sudo systemctl enable jenkins`

and

`$ sudo systemctl status jenkins`

on the host to complete this step. This should lead to the outputs displayed below.

![start_jenkins_on_host](doc/start_jenkins_on_host.png)

#### Step 9: Get initial password and unlock Jenkins
Catch the initial password on the host and go to port 8080 of the server. Here, Jenkins waits to be unlocked. Use the password obtained at the host above and arrive at what is displayed in the figure below.

![say_hello_to_jenkins](doc/say_hello_to_jenkins.png)

#### Step 10: Install PlugIns
"Blue Ocean" and other required plugins need to be installed. Logged in as an admin, go to the top left, click 'Jenkins', then 'manage Jenkins', and select 'Manage Plugins'.
Use the "Available" tab, filter by "Blue Ocean," select the first option ("BlueOcean aggregator") and install without a restart. Filter once again for "pipeline-aws" and install, this time selecting "Download now and install after restart."
One the host, run

`$ sudo systemctl restart jenkins`

 An "Open Blue Ocean" link should show up in the sidebar. Click it, and it will take you to the "Blue Ocean" screen, where projects will be managed.

## Section V: Configure the Continuous Integration & Deployment Pipeline

### Generate Token and Add Repository
A token is needed for Jenkins to access the _GitHub_ repository. Generate a token in GitHub. Then, in Jenkins select _BlueOcean_, set up a project, select _GitHub_ as source and enter the token. The pipeline will now show up with a run. The _classic Jenkins View_  will look like displayed in the figure below

![classic_jenkins_view](doc/classic_jenkins_view.png)


### Scan Repository Triggers
In the _classic Jenkins View_ go the project, "Cloud-DevOps-Engineer-Capstone-Project" and then select _Configure_ on the left hand. select _Scan Repository Triggers_ and switch to 1 Minute.
Now Jenkins will scan the GitHub repository each minute for changes; if there are changes, the pipeline will run.

## Section VI: Continuous Integration & Deployment Pipeline At Work
This section describes the individual components of the continuous integration / continuous deployment pipeline that this repository contains.

### Lint the Dockerfile
The Dockerfile gives docker instructions how to build the image and what to do with it, e.g. run the image with port-forwarding. The Dockerfile is checked both syntactically and with respect to non-functional guidelines (e.g. _Dockerfile:2 DL3006 Always tag the version of an image explicitly_), such that one can be sure, the image builds correctly before kicking off the build. The tool used to perform these checks is hadolint, to run the checks

`$ hadolint Dockerfile`





## Section VII: Knowledge
This section wraps up useful knowledge that is needed in the context of cloud-native development operations.

### Docker-Commands
Docker-Containers can be considered as single-purpose virtual machines that can be deployed on a host to provide a single service; many base-images can be found on the DockerHub that can be re-used to produce high-quality of service products. This sub-section wraps up some Docker-Commands that are frequently needed:

* To build a container from Dockerfile: `$ docker build --tag=[name-of-image] .`
* To list all images on the host: `$ docker image ls`
* To remove an image from the host: `$ docker rmi [name-of-image]`
* To list running containers: `$ docker container ls`
* To stop a container running: `$ docker container stop [ID-of-container]`

### DockerHub: An Alternative Container Repository: _upload docker to dockerhub.sh_
For those, who do not work inside Amazon Webs Service and use their local, native distribution of Kubernetes, there is an alternative to managing Docker-Images - the [DockerHub](https://hub.docker.com/). To upload an image, you have to register in DockerHub. Then,
this file must be given permission to run (run `$ chmod u+x upload_docker_to_dockerhub.sh` first). The docker image is uploaded to DockerHub by

`$ ./upload_docker_to_dockerhub.sh`

After the image has been uploaded, it is visible in the DockerHub-Account as a new (or refreshed) repository.

![repository_in_dockerhub](doc/repository_in_dockerhub.png)

### GitHub
When working with continuous integration & deployment Pipelines and GitHub as configuration management tool, one must be able to create access tokens for tools to operate on the repositorys. To generate these, visit
https://github.com/settings/tokens/new?scopes=repo,read:user,user:email,write:repo_hook
and create a token with your credentials.

### Jenkins
After installation of Jenkins a few more commands are needed to manage the pipelines:

* Get the initial password of Jenkins: `$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
* Restart Jenkins on the host: `$ sudo systemctl restart jenkins`

### Kubernetes
Kubernetes is a free & open-source container-orchestration system for automating application deployment, scaling, and management initially designed by Google (see [here](https://en.wikipedia.org/wiki/Kubernetes)). It aims to provide a platform for automating deployment, scaling, and operations of application containers across clusters of hosts, as illustrated by the following image (taken from [here](https://kubernetes.io/de/docs/tutorials/kubernetes-basics/explore/explore-intro/)),

![cluster](doc/cluster.svg)

Containers usually means Docker-Images but a range of container tools is supported. Many cloud services offer a Kubernetes-based platform or infrastructure as a service (PaaS or IaaS) on which Kubernetes can be deployed as a platform-providing service. Many vendors also provide their own branded Kubernetes distributions, such as Amazon Web Service's [Elastic Kubernetes Services](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html).

### Python-Commands for Virtual Environments
Creating a virtual environment makes it easier to provide necessary packages for an application in a location on the host that is _under full management of the user_.

* To create a virtual environment: `$ python3 -m venv [name-of-environment]`
