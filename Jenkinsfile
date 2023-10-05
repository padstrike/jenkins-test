pipeline {
    agent any 

    environment {
        DOCKER_CREDENTIALS = credentials('admin') 
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  
            }
        }

        stage('Build and Push Image') {
            steps {
                script {
                    sh '''
                        echo "Building Image..."
                        docker build -t jenkins-test:latest .
                        echo "Tagging Image..."
                        docker tag jenkins-test:latest $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                        echo "Logging in to Docker Hub..."
                        echo "$DOCKER_CREDENTIALS_PSW" | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin
                        echo "Pushing Image..."
                        docker push $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                    '''
                }
            }
        }

        stage('Update Application Container') {
            steps {
                script {
                    sh '''
                        echo "Pulling Image..."
                        docker pull $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                        echo "Stopping Existing Container..."
                        docker stop jenkins-test-container || true
                        echo "Removing Existing Container..."
                        docker rm jenkins-test-container || true
                        echo "Running New Container..."
                        docker run -d -p 3000:3000 --name jenkins-test-container $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                    '''
                }
            }
        }
    }
}