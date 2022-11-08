# project-terraform
This repo has the code for the create the infrastructure using terraform.
vpc.tf file contains code to create the vpc and subnet.
provider.tf file contains the code to create resources in us-east-1 with aws as provider.
bastion.tf file contains the code to create ec2 instance in public subnet.
jenkins-app.tf file contains the code to create jenkins and app instance is private subnet.
security.tf file contains code to create security group.
