pipeline {
    agent any

    environment {
        // 👇 Replace this with your Docker Hub username and image name
        IMAGE_NAME = "sahilkhan73/webstore"
        // 👇 Jenkins credentials ID you created for Docker Hub
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-token')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📥 Cloning GitHub repository..."
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
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        dockerImage.push("${BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    echo "⚙️ Deploying latest Docker container..."
                    // Stop any existing container first
                    sh """
                        docker ps -q --filter "name=webstore" | grep -q . && docker stop webstore && docker rm webstore || true
                        docker pull ${IMAGE_NAME}:latest
                        docker run -d --name webstore -p 9090:80 ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Clean Up') {
            steps {
                echo "🧹 Cleaning up unused Docker images..."
                sh 'docker image prune -af || true'
            }
        }
    }

    post {
        success {
            echo "✅ Successfully built, pushed, and deployed ${IMAGE_NAME}:${BUILD_NUMBER}!"
        }
        failure {
            echo "❌ Build failed. Please check the Jenkins console output for details."
        }
    }
}
