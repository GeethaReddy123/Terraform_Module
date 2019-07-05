Clone the repository on your linux machine and export the AWS Access Key, Secret Key and Region as environment variables with below command.

```bash
export AWS_ACCESS_KEY_ID="Your Access Key" && export AWS_SECRET_ACCESS_KEY="Your Secret Key" && export AWS_DEFAULT_REGION="us-east-1"
```

Then, go ahead and execute the below.

```bash
terraform init

terraform plan

terraform apply -auto-approve
```

This will create VPC with a Subnet and Internet Gateway which will be associated to the Subnet allowing the Internet access. An EC2 instance will be created in that Subnet and the docker_install.sh file will be executed on this EC2 which will install docker and spinup a Nodejs container. The container port is forwarding from 3000 to 8081. 
Also, an ELB will be created and this EC2 will be a added to this ELB allowing you to access the application using the ELB URL.

Whenever you wish to kill this setup, execute the below.

```bash
terraform destroy -auto-approve
```

I have received this task as a pre-screening test for an interview. This was how I have done it.

Let me know if you have any questions. 
