aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 793553224113.dkr.ecr.eu-central-1.amazonaws.com
docker tag udacity_capstone_project_repository:latest 793553224113.dkr.ecr.eu-central-1.amazonaws.com/udacity_capstone_project_repository:latest
docker push 793553224113.dkr.ecr.eu-central-1.amazonaws.com/udacity_capstone_project_repository:latest
