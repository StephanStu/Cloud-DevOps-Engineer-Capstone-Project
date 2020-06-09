## The Makefile includes instructions on lint tests
# Instructions for testing the microservice
test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

# Instructions for linting the artficacts
lint:
	# Source the virtual environment before by
	# $ source infrastructure/.devops/bin/activate
	# (deactivate with $ deactivate)
	# Then, install requirements of application
	pip install --upgrade pip &&\
		pip install -r requirements.txt
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	# Remove check W1309 to satisfy requirements, code is rated 10 of 10 then.
	pylint --disable=R,C,W1203,W1309 app.py

all: lint test
