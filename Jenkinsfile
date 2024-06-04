pipeline {
    agent any

   tools {
       go 'go_1.22.3'
    }

    environment {
        SONAR_TOKEN = credentials('SONAR_TOKEN') // Reference Jenkins credential ID
        DOCKER_IMAGE = "vuongle/golang-todo-api"
        DOCKER_TAG = "v1"
        shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
        GIT_SHORT_HASH = "${env.GIT_COMMIT.substring(0,8)}"
    }

    stages {
        stage('Unit Test') {
            steps {
                script {
                    echo "${env.GIT_COMMIT}"
                    echo "${shortCommit}"
                    echo "${GIT_SHORT_HASH}"
                    //sh 'go test'
                }
            }
        }

    //     stage('Coverage Report') {
    //         steps {
    //             script {
    //                 sh 'go test -coverprofile=coverage.out'
    //                 sh 'go tool cover -html=coverage.out -o coverage.html'
    //             }
    //             archiveArtifacts 'coverage.html'
    //         }
    //     }

    //     stage('Run SonarQube Analysis') {
    //         steps {
    //             script {
    //                     sh '/usr/local/sonar/bin/sonar-scanner -X -Dsonar.organization=vuongle -Dsonar.projectKey=vuongle_jenkins-docker-golang -Dsonar.sources=. -Dsonar.host.url=https://sonarcloud.io'
    //             }
    //         }
    //     }

    //     stage('Build Docker Image') {
    //        steps {
    //            script {
    //                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
    //            }
    //        }
    //    }
    }
}