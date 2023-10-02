pipeline {
    
    agent any 
    
    stages {
        stage('Checkout') {
            steps {
                // Get the code from the version control system
                checkout scm 
            }
        }

        stage('Install') {
            steps {
                // Install dependencies
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                // Run tests
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                // Build the project
                sh 'npm run build'
            }
        }
    }
}
