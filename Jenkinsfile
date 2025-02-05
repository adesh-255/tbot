pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('telegram-bot-token')
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                   sh 'make build'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    
                        sh 'make tests'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    
                    sh 'make deploy'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}