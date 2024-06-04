pipeline {
    agent any

   tools {
       go 'go_1.22.3'
    }

    environment {
        SONAR_TOKEN = credentials('sonar_token') // Reference Jenkins credential ID
    }

    stages {
        stage('Unit Test') {
            steps {
                script {
                    sh 'go test'
                }
            }
        }

        stage('Coverage Report') {
            steps {
                script {
                    sh 'go test -coverprofile=coverage.out'
                    sh 'go tool cover -html=coverage.out -o coverage.html'
                }
                archiveArtifacts 'coverage.html'
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                script {
                        sh '/usr/local/sonar/bin/sonar-scanner -X -Dsonar.organization=vuongle -Dsonar.projectKey=vuongle_jenkins-docker-golang -Dsonar.sources=. -Dsonar.host.url=https://sonarcloud.io'
                }
            }
        }
    }
}