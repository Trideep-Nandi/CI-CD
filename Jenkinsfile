pipeline {
    agent any
    tools {
        dockerTool 'docker'
    }
    environment {
        DOCKER_IMAGE = "trideepnandi/jenkins-nodejs:${env.BUILD_NUMBER}"
        GITHUB_REPO = 'https://github.com/Trideep-Nandi/CI-CD.git'
    }

    stages {
        stage('Checkout Code') {
          steps {
            script {
              git branch: 'main', url: "${GITHUB_REPO}"
            }
          }
        }

        stage('Build Docker Image') {
          steps {
            script {
          dockerImage = docker.build("${DOCKER_IMAGE}")
            }
          }
        }

        stage('Push Docker Image') {
          environment {
            DOCKERHUB_CREDENTIALS = credentials('docker-cred')
          }
          steps {
            script {
              docker.withRegistry('', ${ DOCKERHUB_CREDENTIALS }) {
                dockerImage.push()
            }
          }
        }
    }
}

    post {
        always {
      echo 'Pipeline completed.'
        }
        success {
      echo 'Build and push to Docker Hub succeeded.'
        }
        failure {
      echo 'Build or push failed.'
        }
    }
}
