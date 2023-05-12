pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    environment {
    registry = '447921315641.dkr.ecr.us-east-1.amazonaws.com/devops-repo'
    registryCredential =  'aws-Credentials'
    dockerimage = ''
  }
    stages {
        stage('Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/syl82/maven-test.git'
            }
        }
        stage('Code Build') {
            steps {
                sh 'mvn clean install package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build Image') {
            steps {
                script{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                } 
            }
        }
        stage('Deploy image') {
            steps{
                script{ 
                    docker.withRegistry("https://"+registry,":us pipeline-ecr-east-1:"+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }  
    }
}


