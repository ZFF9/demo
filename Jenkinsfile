pipeline {
    agent any
    
    // 自动清理工作空间的配置
    options {
        skipDefaultCheckout(true)
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs() 
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // 把前端构建和镜像打包合并在一个 stage 里
        stage('Build Image') {
            steps {
                // 这一句 docker build 会自动执行 npm install 和 build
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