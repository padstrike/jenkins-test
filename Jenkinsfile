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
                bat 'npm install'
            }
        }

        stage('Test') {
            steps {
                // Run tests
                bat 'npm test'
            }
        }

        stage('Build') {
            steps {
                // Build the project
                bat 'npm run build'
            }
        }
    }
}
