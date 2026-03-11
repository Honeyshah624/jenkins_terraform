pipeline {
    agent any

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev','stage','prod'],
            description: 'Select Terraform Workspace'
        )
    }

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh """
                terraform init \
                -backend-config="bucket=myproject-terraform-state-${ENV}" \
                -backend-config="region=${AWS_REGION}" \
                -backend-config="dynamodb_table=terraform-locks-${ENV}"
                """
            }
        }

        stage('Workspace Handling') {
            steps {
                script {
                    sh """
                    if terraform workspace list | grep -qw ${ENV}; then
                        echo "Workspace exists"
                        terraform workspace select ${ENV}
                    else
                        echo "Creating workspace"
                        terraform workspace new ${ENV}
                    fi
                    """
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                sh "terraform plan -var-file=env/${ENV}.tfvars"
            }
        }

        stage('Terraform Apply') {
            steps {
                input "Approve Apply?"
                sh "terraform apply -var-file=env/${ENV}.tfvars -auto-approve"
            }
        }

    }
}