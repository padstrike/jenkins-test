pipeline {
    agent any 

    environment {
        DOCKER_CREDENTIALS = credentials('docker-hub-credentials') 
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
                        docker -H tcp://localhost:2375 build -t jenkins-test:latest .
                        echo "Tagging Image..."
                        docker -H tcp://localhost:2375 tag jenkins-test:latest $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                        echo "Logging in to Docker Hub..."
                        echo "$DOCKER_CREDENTIALS_PSW" | docker -H tcp://localhost:2375 login -u $DOCKER_CREDENTIALS_USR --password-stdin
                        echo "Pushing Image..."
                        docker -H tcp://localhost:2375 push $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                    '''
                }
            }
        }

        stage('Update Application Container') {
            steps {
                script {
                    sh '''
                        echo "Pulling Image..."
                        docker -H tcp://localhost:2375 pull $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                        echo "Stopping Existing Container..."
                        docker -H tcp://localhost:2375 stop jenkins-test-container || true
                        echo "Removing Existing Container..."
                        docker -H tcp://localhost:2375 rm jenkins-test-container || true
                        echo "Running New Container..."
                        docker -H tcp://localhost:2375 run -d -p 3000:3000 --name jenkins-test-container $DOCKER_CREDENTIALS_USR/jenkins-test:latest
                    '''
                }
            }
        }
    }
}
