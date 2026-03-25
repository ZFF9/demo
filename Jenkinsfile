pipeline {
    agent any

    stages {
        stage('Install & Build') {
            agent {
                docker {
                    image 'node:18'
                    args '-v $PWD:/app -w /app'
                }
            }
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t demo-app:latest .'
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop demo-app || true
                docker rm demo-app || true
                docker run -d -p 3000:80 --name demo-app demo-app:latest
                '''
            }
        }
    }
}