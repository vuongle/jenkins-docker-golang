pipeline {
    agent any

   tools {
       go 'go_1.22.3'
    }

    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN') // Reference Jenkins credential ID
        GIT_SHORT_HASH = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
        DOCKER_IMAGE = "vuongle/golang-todo-${GIT_SHORT_HASH}"
        DOCKER_TAG = "v1"
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

        stage('Build Docker') {
           steps {
               script {
                   sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
               }
           }
       }
        stage("Push Docker"){
            agent any
            steps {
                withDockerRegistry(credentialsId: "vuongle-dockerhub", url: "https://index.docker.io/v1/"){
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
    }

    post{
        success{
            // remove image after pushing
            sh "docker image rm ${DOCKER_IMAGE}:${DOCKER_TAG}"
        }
    }
}