# Page deploy using Packer and Terraform

This repo contains Packer and Terraform configurations to pack and deploy web page.

# Prerequisite

### 1. Install on your workstation:**

 [Terraform CLI >0.13](https://learn.hashicorp.com/tutorials/terraform/install-cli)
 
 [homebrew](https://brew.sh/)

### 2. Clone this repo locally to a folder of your choice**
```
git clone https://github.com/51r/terraform-packer-page.git
```

### 3. Make sure you are in the main directory of the repo:
```
cd terraform-packer-page
```

### 4. Configure AWS:
Set your AWS access key ID as an environment variable:

```
export AWS_ACCESS_KEY_ID="<YOUR_AWS_ACCESS_KEY_ID>"
```

Set your secret key:

```
export AWS_SECRET_ACCESS_KEY="<YOUR_AWS_SECRET_ACCESS_KEY>"
```

Set your AWS region:
```
export AWS_DEFAULT_REGION="<YOUR_AWS_REGION>"
```

In the guide I have used `eu-west-2`

If you don't have access to IAM user credentials, you can authenticate AWS using different methods described [here](https://www.packer.io/plugins/builders/amazon#authentication)


# Build your Packer image AMI

* Initialize Packer:
```
packer init .
```

* Build your environment:
```
packer build template.hcl
```

The installation log will be printed to the screen.In the end you should get the following output: 
```
==> Builds finished. The artifacts of successful builds are:
--> learn-packer.amazon-ebs.ubuntu: AMIs were created:
<YOUR_AWS_REGION: ami-ID
```

# Deploy your Packer AMI image using Terraform

* Initialize Terraform:
```
terraform init
```

* Make sure that you have added your var when applying the plan:
```
terraform apply -var "ami_id=YOUR-AMI-ID-FROM-PACKER"
```

* The terraform will deploy the AMI and will printout the website IP, as you can see from the screenshot below, I have run curl command to check if the website is available:

<img width="580" alt="Screen Shot 2022-06-13 at 1 43 35 PM" src="https://user-images.githubusercontent.com/52199951/173337056-96819e0f-9467-4360-a4ea-b47f3710c26a.png">
