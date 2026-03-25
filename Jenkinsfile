pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Frontend') {
            steps {
                // 注意这里改成了双引号 """
                sh """
                docker run --rm \
                -v ${WORKSPACE}:/app \
                -w /app \
                node:18 \
                sh -c "npm install && npm run build"
                """
            }
        }

        stage('Build Image') {
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