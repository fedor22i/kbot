pipeline {
agent any
    parameters {
        choice(
            name: 'OS',
            choices: ['linux', 'darwin', 'windows'],
            description: 'Target operating system'
        )
        choice(
            name: 'ARCH',
            choices: ['amd64', 'arm64'],
            description: 'Target architecture'
        )
    }
    
    environment {
        REPO = 'https://github.com/fedor22i/kbot'
        BRANCH = 'main'
    }
    stages {
        
        stage("clone") {
            steps {
            echo 'CLONE REPOSITORY'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }
        
        stage("test") {
            steps {
            echo 'TEST EXECUTION STARTED'
                sh 'make test'
            }
        }
        
        stage("build") {
            steps {
            echo 'BUILD EXECUTION STARTED'
                sh sh "make build TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
            }
        }
        
        stage("image") {
            steps {
                script {
                    echo 'BUILD EXECUTION STARTED'
                    sh "make image TARGETOS=${params.OS} TARGETARCH=${params.ARCH}"
                }
            }
        }
        
        stage("push") {
            steps {
                script {
                    docker.withRegistry( '', 'dockerhub') {
                        sh 'make push'
                    }
                }
            }
        }
    }
}
