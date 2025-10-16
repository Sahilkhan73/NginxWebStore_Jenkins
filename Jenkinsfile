pipeline {
    agent any

    environment {
        IMAGE_NAME = "nginx-webstore"
        DOCKERHUB_USER = "skpdevops"
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo "Cloning GitHub repository..."
                git branch: 'main', url: 'https://github.com/Sahilkhan73/NginxWebStore_Jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Test Image') {
            steps {
                echo "Testing Docker image..."
                sh 'docker run -d --name test-nginx -p 9090:80 $IMAGE_NAME'
                sh 'sleep 5'
                sh 'curl -I http://16.171.28.22:9090 | grep "200 OK"'
                sh 'docker stop test-nginx && docker rm test-nginx'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker tag $IMAGE_NAME $DOCKER_USER/$IMAGE_NAME:latest'
                    sh 'docker push $DOCKER_USER/$IMAGE_NAME:latest'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Deploying latest image..."
                sh 'docker stop nginx-container || true'
                sh 'docker rm nginx-container || true'
                sh 'docker run -d --name nginx-container -p 9090:80 $DOCKERHUB_USER/$IMAGE_NAME:latest'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
    }
}
