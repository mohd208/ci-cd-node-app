pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "waseemdevops/logo-server:latest" // Replace if using DockerHub
        DOCKER_CREDENTIALS = "dockerhub-cred-id"                     // Replace with your Jenkins DockerHub credentials ID
        CONTAINER_NAME = "logo-server"
        HOST_PORT = "3000"      // Change if your app uses a different port
        CONTAINER_PORT = "3000" // Container port exposed in Dockerfile
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub'
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                echo 'Installing dependencies and running tests'
                sh 'npm install'
                sh 'npm test'
            }
        }

        stage('Dockerize') {
            steps {
                echo 'Building Docker image'
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push to DockerHub') {
            when {
                expression { env.DOCKER_IMAGE != '' }
            }
            steps {
                echo 'Pushing Docker image to DockerHub'
                withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push $DOCKER_IMAGE"
                }
            }
        }

        stage('Deploy on Ubuntu Server') {
            steps {
                echo 'Deploying Docker container on Ubuntu server'
                sh """
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                    docker run -d --name $CONTAINER_NAME -p $HOST_PORT:$CONTAINER_PORT $DOCKER_IMAGE
                """
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}

