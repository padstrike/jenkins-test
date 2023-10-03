pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                checkout scm 
            }
        }

        stage('Build and Push Image') {
            steps {
                script {
                    // Building the Docker image and push to Docker Hub (or any other registry)
                    sh '''
                        docker build -t jenkins-test:latest .
                        docker tag jenkins-test:latest yourusername/jenkins-test:latest
                        docker login -u yourusername -p yourpassword
                        docker push yourusername/jenkins-test:latest
                    '''
                }
            }
        }

        stage('Update Application Container') {
            steps {
                script {
                    // Pulling the new image and update the container
                    sh '''
                        docker pull yourusername/jenkins-test:latest
                        docker stop jenkins-test-container || true
                        docker rm jenkins-test-container || true
                        docker run -d -p 3000:3000 --name jenkins-test-container yourusername/jenkins-test:latest
                    '''
                }
            }
        }
    }
}
