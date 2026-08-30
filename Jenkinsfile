pipeline {
    agent any
    stages {
        stage('checkout') {
            steps {
                echo 'Checking out the code...'
            }
        }
        stage('Test') {
            steps {
                sh 'echo Running tests...'
                sh 'python3 --version'
            }
        }
        stage('build') {
            steps {
               sh  'docker build -t devops-flask:$BUILD_NUMBER ./app'
            }
        }
        stage('deploy') {
            steps {
               sh  'echo Deploying the application...'
            }
        }
    }
}