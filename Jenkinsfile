pipeline {
    agent any 

    environment {
        DOCKER_CREDENTIALS = credentials('admin') // Using credentials from Jenkins credentials manager
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // No credentials needed for public repo
            }
        }

        stage('Build and Push Image') {
            steps {
                script {
                    sh '''
                        docker build -t myapp:latest .
                        docker tag myapp:latest $DOCKER_CREDENTIALS_USR/myapp:latest
                        echo "$DOCKER_CREDENTIALS_PSW" | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin
                        docker push $DOCKER_CREDENTIALS_USR/myapp:latest
                    '''
                }
            }
        }

        stage('Update Application Container') {
            steps {
                script {
                    // Pulling the new image and updating the container
                    sh '''
                        docker pull tuer12033/jenkins-test:latest
                        docker stop jenkins-test-container || true
                        docker rm jenkins-test-container || true
                        docker run -d -p 3000:3000 --name jenkins-test-container tuer12033/jenkins-test:latest
                    '''
                }
            }
        }
                // ... other stages as needed
    }
}