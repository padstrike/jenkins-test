pipeline {
    agent any 

    environment {
        BUILD_VERSION = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("YYYYMMddHHmmss"))
    }

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'master', description: 'Name of the branch to build')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "${params.BRANCH_NAME}"]],
                    userRemoteConfigs: [
                        [
                            // credentialsId: 'your-credentials-id'
                            , url: 'https://github.com/padstrike/jenkins-test.git'
                        ]
                    ]
                ])
            }
        }

        stage('Build & Test') {
            steps {
                // Add your build and test steps here
                echo "Building ${params.BRANCH_NAME} branch."
            }
        }
    }
}

node {
    def branchName = params.BRANCH_NAME
    
    stage("Deploy - ${branchName}") {
        when {
            expression { 
                branchName in ['develop', 'feature', 'hotfix', 'master', 'qa', 'test-uat'] 
            }
        }

        steps {
            script {
                echo "Deploying ${branchName} branch."
                
                if (branchName == 'develop') {
                    echo 'Deploying to Development Environment'
                    // Insert your deployment steps for the develop branch
                } else if (branchName.startsWith('feature/')) {
                    echo 'Deploying Feature Branch to Feature Environment'
                    // Insert your deployment steps for feature branches
                } else if (branchName.startsWith('hotfix/')) {
                    echo 'Deploying Hotfix to Hotfix Environment'
                    // Insert your deployment steps for hotfix branches
                } else if (branchName == 'master') {
                    echo 'Deploying to Production Environment'
                    // Insert your deployment steps for the master branch
                } else if (branchName == 'qa') {
                    echo 'Deploying to QA Environment'
                    // Insert your deployment steps for the QA branch
                } else if (branchName == 'test-uat') {
                    echo 'Deploying to UAT Environment'
                    // Insert your deployment steps for the test-uat branch
                } else {
                    echo 'Branch not recognized for deployment'
                }
            }
        }
    }
    
    post {
        always {
            echo 'This will always be executed.'
            // Add steps to perform actions that should always be executed, regardless of the build status
        }
    }
}

