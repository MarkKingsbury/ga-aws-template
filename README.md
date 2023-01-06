# ga-aws-template
looking at github actions + terraform to make environments in aws

basic pre-requisites for github secrets to get going:

- role using oidc (for github actions) and wth appropriate permissions 
-> and a git secret with that ARN_ROLE per environment
- s3 bucket with state for the environments & a dynamodb table for backend locks
-> then a param in param store with those backend details
-> and a git secret for that AWS_PARAM_STORE_TF_BACKEND_KEY

also need to provide:
- s3 bucket for plans to go to
- param in param store with variables passed to tf
- log groups for plan per environment and one for errors

