pipeline {
    agent any
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/sathigangabhaskarreddy/dotnet-hello-world.git'
            }
        }
        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t bhaskar7669/bhaskar_docker:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    withDockerRegistry(credentialsId: 'Docker'){
                    sh '''
                    echo 'Push to Repo'
                    docker push bhaskar7669/bhaskar_docker:${BUILD_NUMBER}
                    '''
                }
                }     
            }
        }
        
    }
}
