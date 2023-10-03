pipeline {
    agent any 

    stages {
        stage('Checkout') {
            steps {
                checkout scm 
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def appImage = docker.build("myapp:latest")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    docker.image('myapp:latest').run("-p 3000:3000")
                }
            }
        }
    }
}
