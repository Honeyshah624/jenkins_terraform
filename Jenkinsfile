pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_DEFAULT_REGION    = 'ap-south-1'
        TF_IN_AUTOMATION      = 'true'
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stage', 'prod'],
            description: 'Select environment'
        )

        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Select Terraform action'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Honeyshah624/jenkins_terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                terraform init -reconfigure \
                -backend-config="bucket=terraform-remote-state-workspace2" \
                -backend-config="key=terraform/terraform.tfstate" \
                -backend-config="region=ap-south-1"
                '''
            }
        }

        stage('Workspace Setup') {
            steps {
                sh """
                if terraform workspace list | grep -w ${params.ENVIRONMENT}
                then
                    terraform workspace select ${params.ENVIRONMENT}
                else
                    terraform workspace new ${params.ENVIRONMENT}
                fi
                """
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh 'terraform plan'
            }
        }

        stage('Approval for Destroy (Prod Only)') {
            when {
                allOf {
                    expression { params.ACTION == 'destroy' }
                    expression { params.ENVIRONMENT == 'prod' }
                }
            }
            steps {
                input message: "Are you sure you want to DESTROY the PROD infrastructure?"
            }
        }

        stage('Terraform Apply / Destroy') {
            steps {
                script {
                    if (params.ACTION == 'apply') {
                        sh 'terraform apply -auto-approve'
                    } else {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully."
        }
        failure {
            echo "Pipeline failed. Please check logs."
        }
    }
}