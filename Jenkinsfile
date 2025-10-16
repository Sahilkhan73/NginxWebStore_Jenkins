pipeline {
    agent any

    environment {
        // 👇 Replace this with your Docker Hub username
        IMAGE_NAME = "sahilkhan73/webstore"
        // 👇 Jenkins credentials ID you’ll create for Docker Hub login
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-token')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📥 Cloning GitHub repository..."
                // 👇 Replace with your actual repo URL
                git branch: 'main', url: 'https://github.com/Sahilkhan73/NginxWebStore_Jenkins.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🐳 Building Docker image..."
                    dockerImage = docker.build("${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "🚀 Pushing Docker image to Docker Hub..."
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-token') {
                        dockerImage.push("${BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                echo "🧹 Cleaning up Docker images..."
                sh 'docker rmi $(docker images -q) || true'
            }
        }
    }

    post {
        success {
            echo "✅ Successfully built and pushed ${IMAGE_NAME}:${BUILD_NUMBER} to Docker Hub!"
        }
        failure {
            echo "❌ Build failed. Please check the Jenkins console output for details."
        }
    }
}
