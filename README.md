# AWS-3-Tier-Architecture-and-Web-application-Deploying-via-Terraform
AWS 3 Tier Architecture and Web application Deploying via Terraform

Introduction
Infrastructure as code or IaC allows an architect to deploy services using code rather than logging into the console and deploying using the GUI. The benefits of this over deploying through the console are that it allows for a more consistent environment and also the code can be reused and edited as needed which saves time. The IaC tool that I will be using in this project is Terraform which is compatible with most major cloud providers.

This project will involve building out a three-tier architecture on AWS using Terraform. In a three-tier architecture, an application is broken down into a web-facing presentation layer, and internal application and database layers. This is a change from the previous ways of building an application where the frontend, backend, and database are all sitting in the same place. The services that we will be using to build out this architecture will be Virtual Private Cloud (VPC), Elastic Compute Cloud (EC2), Elastic Load Balancer (ELB), Route 53 Record, Amazon S3 Backend, DynamoDB state lock, Security Groups, Route Tables, and Internet Gateway (IGW).

## Diagram
![image](https://github.com/Sivaprakash-pk/AWS-3-Tier-Architecture-and-Web-application-Deploying-via-Terraform/assets/118121843/8ae47872-6f81-4fbc-943a-97e2903e36f8)

### Why Should We Architect This Way?
1. Modularity: One benefit of building our architecture out this way is that each layer can be managed separately. This can be beneficial to keep a secure environment where users can only log in and manage the specific servers and services that they need to be working on ie. The DB developer works on the DB, front-end developer works on the front end. Another benefit of this is more efficient troubleshooting and if one layer were to go down we can focus on that specifically without needing to take down the entire application.

2. High Availability: Another thing we will be focusing on is high availability which we will address by building in two separate AWS availability zones. In case one availability zone were to go down for whatever reason our application would still be running in the other. This is a huge benefit of the cloud compared to the traditional on-site server where if power were to go out or the internet connection was lost the application would be completely down.

3. Security: We will be building the front end on a public subnet which will be accessed through a load balancer. Our application and database layers will be on private subnets which can only be accessed using SSH from specified security groups, or IP addresses. The security groups will allow us to set the criteria for ingress and egress traffic and specify which protocols can be used from what CIDR blocks.

4. Consistency: An important part of rolling out these projects is maintaining consistency. When we make any changes to this project, we will be doing so using Terraform and not the AWS console. The reason for this is that if we need to find out any kind of information on the configuration, we can look through our Terraform files which will let us know exactly how things are set up. Another benefit of this is we can reuse the code again, for example, if we need to add a server or if we are working on another similar project, we can use the code for this project to deploy the architecture which saves us time.

## For a detailed explanation of the architecture and its benefits, check out our blog post:
https://sivaprakash-s.hashnode.dev/automating-aws-3-tier-architecture-deploying-with-terraform-and-jenkins

## Prerequisites for Automating Infrastructure with Terraform and Jenkins
### 1. AWS Account:

First and foremost, you'll need an AWS account to access the vast array of cloud services offered by Amazon Web Services. This account will serve as your playground for creating and managing infrastructure resources like EC2 instances, S3 buckets, and much more.

### 2. Jenkins Server:

As your automation hub, Jenkins plays a crucial role in managing your infrastructure deployments. This open-source continuous integration and continuous delivery (CI/CD) server will automate your Terraform code execution, ensuring consistent and reliable deployments across environments.

### 3. Terraform and AWS CLI Installation:

To interact with AWS resources and automate their creation, we need two essential tools:

Terraform: This Infrastructure as Code (IaC) tool allows you to define your infrastructure in code, enabling repeatable and consistent deployments.

AWS CLI: The AWS Command Line Interface provides a command-line interface for interacting with AWS services. It allows you to manage resources directly and integrate with Terraform scripts for automated deployments.

### 4. S3 Bucket for State Storage:

Terraform requires a secure location to store its state file, which contains information about your infrastructure resources. An S3 bucket on your AWS account offers a perfect solution for storing the state file and ensuring its durability and accessibility.

### 5. GitHub Account for Code Repository:

Version control is essential for managing your Terraform code and tracking changes. A GitHub repository provides a centralized platform to store your code, collaborate with team members, and maintain different versions of your infrastructure configurations.

## Benefits of Setting Up Your Environment:

Automation: Achieve consistent and repeatable deployments through automation with Terraform and Jenkins.

Scalability: Easily scale your infrastructure as your needs grow.

Reliability: Reduce the risk of manual errors and ensure consistent configurations.

Collaboration: Facilitate collaborative development and management of infrastructure code.

Security: Leverage the power of AWS and secure your infrastructure with S3 and IAM policies.

## Managing Terraform State with S3 and DynamoDB: A Secure and Scalable Approach
Storing your Terraform state file is crucial for managing your infrastructure effectively. While the default local storage option is convenient, it lacks scalability and security for collaborative environments. This is where the power of Amazon S3 and DynamoDB comes into play.

### Why S3 and DynamoDB?
#### S3:

Durable storage: S3 offers high durability and redundancy, ensuring your state files are always available and protected against accidental deletion or hardware failures.

Versioning: S3 enables versioning of your state files, allowing you to roll back to previous states if needed.

Scalability: S3 scales seamlessly to accommodate any amount of state data you throw at it.

#### DynamoDB:

Locking mechanism: DynamoDB's atomic operations provide a robust locking mechanism, preventing concurrent modifications to your state file and avoiding conflicts during collaboration.

High availability: DynamoDB offers high availability across multiple regions, ensuring your state files are accessible even during outages.

Fast performance: DynamoDB delivers fast read and write speeds, optimizing your Terraform workflow.

Implementing S3 and DynamoDB Backend
Here's a breakdown of implementing the S3 and DynamoDB backend:

#### 1. Create an S3 bucket:

Configure the bucket with appropriate access permissions.

Enable versioning for additional security and rollback capabilities.

#### 2. Create a DynamoDB table:

Define a primary key for locking purposes (e.g., terraform_state).

Set the appropriate access permissions for Terraform to access the table.

#### 3. Configure Terraform backend:

In your Terraform configuration, specify the backend block.

Provide the S3 bucket name and DynamoDB table name.

Define workspace configuration (optional).

## Testing
Once the services have been created, take the DNS name of our Route 53 record. We will copy and paste this into our browser to make sure that we can access the site.

## Clean Up
Whenever we are finished with this project it is important to delete our infrastructure so that we don't continue to get charged. To do so we issue the Terraform destroy command which will delete everything we have created via running the Jenkins pipeline job by choosing ‘destroy’ in the choice parameter.

## Final Thoughts
When I first started using AWS I wondered why people would use the CLI or an IaC tool when creating their architecture instead of the GUI. For a beginner, the GUI just seems so much easier to use, but after playing around with Terraform I can see why this is the preferred way.

It is much easier and quicker to create services this way, and as an added benefit you have the code that you can reuse for other projects which saves a lot of time, and while Terraform code may look daunting for someone new to the tool, it is easy to understand. Also, the documentation on the Terraform website is amazing and makes using the tool so much easier.
