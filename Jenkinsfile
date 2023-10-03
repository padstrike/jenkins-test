pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                // Get the latest code from the version control system.
                checkout scm 
            }
        }

        stage('Build and Push Image') {
            steps {
                script {
                    // Build and push the Docker image with a new tag.
                    sh '''
                        docker build -t jenkins-test:latest .
                        docker push jenkins-test:latest
                    '''
                }
            }
        }

        stage('Update Application Container') {
            steps {
                script {
                    // Update the running application container.
                    // This might involve stopping the old container, pulling the new image, and starting a new container.
                    sh '''
                        docker pull jenkins-test:latest
                        docker stop jenkins-test-container
                        docker rm jenkins-test-container
                        docker run -d -p 3000:3000 --name jenkins-test-container jenkins-test:latest
                    '''
                }
            }
        }
    }
}
