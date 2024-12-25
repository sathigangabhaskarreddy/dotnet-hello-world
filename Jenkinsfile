pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', credentialsId: 'Github', url: 'https://github.com/sathigangabhaskarreddy/dotnet-hello-world.git'
            }
        }
    }
}
