// pipeline{
//     agent any
    
//     environment{
//         DOCKERHUB_CREDENTIALS = credentials('Dockerhub-Cred')
//     }
//     stages{
//         stage('Git Checkout'){
//             steps{
                
//                git branch:'master' ,url: 'https://github.com/Bhim-Kumar/MavenBuild.git'
//             }
//         }
//         stage('Maven Build'){
//             steps{
//                 sh 'mvn clean install'
//             }
//              post {
//         success {
//           archiveArtifacts artifacts: '**/target/*.war'
//         }
//       }
//         }
//         stage('Maven Test'){
//             steps{
//                 sh 'mvn test'
//             }
//         }
        
//         stage('Docker Build'){
//             steps{
//                 sh 'docker build -t java-app:latest .'
//                 sh 'docker tag java-app bhimkumar/java-app:latest'
//             }
//         }
        
//         stage('Login to Dockerhub'){
//             steps{
//                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u    $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      
//             }
            
//         }
        
//         stage('Push Image to Dockerhub'){
//             steps{
//                 sh 'docker push bhimkumar/java-app:latest'
//             }
//             post{
//                 always{
//                     sh 'docker logout'
//                 }
//             }
//         }
        
//         stage('Pull the Image from Dockerhub '){
//             steps{
//                 sh 'docker pull bhimkumar/java-app:latest'
//             }
//         }
//         stage('Docker Run'){
//             steps{
//                 sh 'docker run -d -p 8081:8080 java-app:latest'
//             }
//         }
//     }
// }

pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    stages {

        stage('Git Checkout') {
            steps {
                echo '>>> Pulling code from GitHub...'
                git branch: 'master',
                    url: 'https://github.com/Malaika-tech/Maven_webApp.git'
            }
        }

        stage('Maven Build') {
            steps {
                echo '>>> Building WAR file...'
                sh 'mvn clean package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: '**/target/*.war',
                                     fingerprint: true
                }
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                echo '>>> Deploying to Tomcat...'
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'tomcat-creds',
                        path: '',
                        url: 'http://localhost:9090'
                    )
                ],
                contextPath: 'java-example',
                war: '**/target/*.war'
            }
        }
    }

    post {
        success {
            echo '✅ BUILD & DEPLOY SUCCESSFUL!'
            echo 'App: http://localhost:9090/java-example'
        }
        failure {
            echo '❌ PIPELINE FAILED!'
        }
    }
}