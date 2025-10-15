pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/<your-username>/<your-repo>.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'echo Build successful!'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'echo Tests passed!'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                // Example for Docker deploy
                // sh 'docker build -t my-app .'
                // sh 'docker run -d -p 8080:80 my-app'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully!'
        }
        failure {
            echo '❌ Build failed!'
        }
    }
}
