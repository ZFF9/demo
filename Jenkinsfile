pipeline {
    agent any

    stages {
        stage('Install & Build') {
            steps {
                sh '''
                docker run --rm \
                -v $PWD:/app \
                -w /app \
                node:18 \
                sh -c "npm install && npm run build"
                '''
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