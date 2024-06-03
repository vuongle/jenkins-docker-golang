pipeline {
    agent any

   tools {
       go 'go_1.22.3'
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
    }
}