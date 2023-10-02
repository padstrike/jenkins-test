pipeline {
    agent any 
    
    stages {
        stage('Check Node & NPM') {
            steps {
                sh '''
                    node -v
                    npm -v
                '''
            }
        }

        stage('Checkout') {
            steps {
                checkout scm 
            }
        }

        stage('Install') {
            steps {
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    }
}
