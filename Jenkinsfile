pipeline {
    agent any 

    tools {
        // Make sure 'node' is the name of the NodeJS installation configured in Jenkins
        nodejs 'node'
    }

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
