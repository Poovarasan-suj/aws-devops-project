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
        stage('push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_TOKEN'
                )] ) {
                    sh '''
                        echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USER" --password-stdin
                        docker tag devops-flask:$BUILD_NUMBER $DOCKER_USER/aws-devops-project:$BUILD_NUMBER
                        docker push $DOCKER_USER/aws-devops-project:$BUILD_NUMBER
                        docker logout
                    '''
                }
            }
        }
        
        stage('deploy') {
            steps {
                withCredentials([usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_TOKEN'
            ) ]) {
                sh  '''
                  ssh sujith@192.168.56.103 "
                  echo '$DOCKER_TOKEN' | docker login -u '$DOCKER_USER' --password-stdin
                  export IMAGE_TAG=$BUILD_NUMBER
                  cd ~/aws-devops-project/app
                  docker compose pull
                  docker compose up -d 
                "
                '''
             }
        }
    }
}