# devops_challenge

# Pre-requisites
This IAC was created taking in account some pre-requisites.
1. The project(s) must be created.
2. The bucket for the terraform state must created.
3. The service account used as for GITLAB must be created, also its key must be encoded in base64.
4. Create a new project in GITLAB.

# Description
1. The folder environments will contains all the terraform templates, each folder is used to deploy the resources into the environment with the same name.
Ex. environments/dev/ will contains all the needed code to deploy the resources into the development environment.

2. The folder init_scripts/ contains the scripts to be executed during the provisioninig state of the virtual machines.
3. The folder modules contains some custom modules of terraform created for this challenge.
4. the file named .gitlab-ci.yml contains the pipeline to deploy the IAC with terraform.

# Detail of terraform templates
1. backend.conf
   1. Contains some configurations for the backend like the path of the credentials, the bucket name of the tfstate, etc.
2. backend.tf
   1. Here is where is located the configuration where is going to be stored the terraform tfstate, this must be created before to init the project.
3. version.tf
   1. Here you can find the declaration of the required providers nad the required version of terraform to execute.
4. providers.tf
   1. Here you can find the configuration of the google provider like region, project_id and the path where is stored the credentials.
5. terraform.auto.tfvars
   1. the default file to set up some input for the variables
6. variables.tf
   1. Here we declare the variables to be used by terraform.
7. storage.tf
   1. Here we call the child module modules/storage to create the bucket and adding the storage admin role to the service accounts.
8. sa.tf
   1. Here we created the service accounts to be used the VM.
9. vm.tf
   1.  Here we call the child module modules/instance(2) and modules/instance_group(2), these allow us to create 2 virtual machines and 2 instance groups in each zone.
10. lb.tf
    1.  Here we call the child module modules/lb to create the load balancer.

# Modules
1. instance
   1. Here you can find the resource google_compute_instance which allows us to create the virtual machine.
2. instance_group
   1. Here you can find the resource google_compute_instance_group which allows us to create the instance groups.
3. storage
   1. Here you can find the resource google_storage_bucket which allows us to create the bucket and the resource google_storage_bucket_iam_member which allow us to add the role storage.admin to each service account.
4. lb
   1. Here you can find all the configurations to create a load balancer and redirect to the vms.

# Deployment
1. This deployment is by folder or directory. If you add a new resource for the environments/dev which represents the dev environment after pushing to the master branch the gitlabci pipeline will detect the change and start to executing terraform init, validate, plan and apply. 
2. For example if you want to start deploying to the qa environment(environments/qa), you need to copy all the terraform files under the qa folder, then push your commint in the main branch, this will trigger the pipeline.
3. For example if you want to start deploying to the prod environment(environments/prod), you need to copy all the terraform files under the prod folder, then push your commint in the main branch, this will trigger the pipeline.

# GitlabCI pre requisites
1. the set up the variable IAC_SA which the value is an encoded base 64 key of the service account with permissions to deploy the resources.

# GitlabCI
1. Here you can find the image of terraform v0.13.5, in each stage you will find the configuration of the key of the service account. The same stages for all the environments. validate, plan and apply.

2. There are some rules that will identify where the changes where applied so this will change the directory according to the environment.

# NOTES
1. Will be required to change the name of the resources in qa or prod environment.
2. Resources has been deleted at the moment to send this solution.