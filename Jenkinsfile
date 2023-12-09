pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
        AWS_DEFAULT_OUTPUT    = 'json'
    }


    stages {
        stage('Configure AWS') {
            steps {
                // Use the environment variables to configure AWS
                sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
                sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
                sh "aws configure set default.region ${AWS_DEFAULT_REGION}"
                sh "aws configure set default.output ${AWS_DEFAULT_OUTPUT}"
            }
        }

        stage('Checkout Code') {
            steps {
                // Checkout your Terraform configuration files from version control
                git branch: 'main', url: 'https://github.com/Sivaprakash-pk/AWS-3-Tier-Architecture-and-Web-application-Deploying-via-Terraform.git'
            }
        }
        
        stage('Terraform Init') {
            steps {
                // Initialize the Terraform working directory
                sh 'terraform init'
            }
        }
        

        stage('Terraform Plan') {
            steps {
                // Generate and show an execution plan
                sh 'terraform plan'
            }
        }

        stage('Terraform Action') {
            steps {
                script {
                    // Apply or destroy based on user choice
                    if (params.ACTION == 'apply') {
                        sh 'terraform apply -auto-approve'
                    } else if (params.ACTION == 'destroy') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
        stage('Remove AWS Configuration') {
            steps {
                sudo rm .aws/credentials
                sudo rm .aws/config
            }
        }
    }

    post {
        success {
            // This block will run if the pipeline is successful
            echo 'Pipeline succeeded!'
        }
        failure {
            // This block will run if the pipeline fails
            echo 'Pipeline failed!'
        }
    }
}
