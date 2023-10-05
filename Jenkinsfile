pipeline {
    agent any 

    environment {
        DOCKER_CREDENTIALS = credentials('admin') 
        IMAGE_NAME = "jenkins-test"
        IMAGE_TAG = "latest"
        FULL_IMAGE_NAME = "${DOCKER_CREDENTIALS_USR}/${IMAGE_NAME}:${IMAGE_TAG}"
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
                    def dockerImage
                    echo "Building Image..."
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")

                    echo "Tagging Image..."
                    dockerImage.push("${IMAGE_TAG}")
                    dockerImage.push("latest")
                }
            }
        }

        stage('Update Application Container') {
            steps {
                script {
                    echo "Pulling Image..."
                    docker.image("${FULL_IMAGE_NAME}").pull()

                    echo "Stopping Existing Container..."
                    sh 'docker stop jenkins-test-container || true'
                    echo "Removing Existing Container..."
                    sh 'docker rm jenkins-test-container || true'

                    echo "Running New Container..."
                    docker.run("--name jenkins-test-container -p 3000:3000", "${FULL_IMAGE_NAME}")
                }
            }
        }
    }
}
