pipeline {
    agent any 

    parameters {
        choice(name: 'ACTION', choices: ['Build', 'Deploy', 'Hotfix', 'Feature', 'Bugfix'], description: 'What action to perform')
        string(name: 'VERSION', defaultValue: '0.0.0', description: 'Version to deploy or hotfix')
        string(name: 'ISSUE_ID', defaultValue: '', description: 'Issue ID for feature or bugfix')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm 
            }
        }
        
        stage('Build') {
            when {
                expression { params.ACTION == 'Build' }
            }
            steps {
                echo 'Building the application'
                // Insert build steps here
            }
        }

        stage('Deploy') {
            when {
                expression { params.ACTION == 'Deploy' }
            }
            steps {
                echo 'Deploying version: ' + params.VERSION
                // Insert deploy steps here
            }
        }

        stage('Hotfix') {
            when {
                expression { params.ACTION == 'Hotfix' }
            }
            steps {
                echo 'Applying hotfix for version: ' + params.VERSION
                // Insert hotfix steps here
            }
        }

        stage('Feature') {
            when {
                expression { params.ACTION == 'Feature' }
            }
            steps {
                echo 'Building feature for issue: ' + params.ISSUE_ID
                // Insert feature build steps here
            }
        }

        stage('Bugfix') {
            when {
                expression { params.ACTION == 'Bugfix' }
            }
            steps {
                echo 'Fixing bug for issue: ' + params.ISSUE_ID
                // Insert bugfix steps here
            }
        }
        
        stage('Release') {
            when {
                // You can add a condition to trigger release, e.g. when on a certain branch
            }
            steps {
                echo 'Releasing version: ' + params.VERSION
                // Insert release steps here, including tagging and version increment
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline finished'
        }
    }
}
