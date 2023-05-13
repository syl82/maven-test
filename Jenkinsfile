pipeline {
    agent any
    tools{
        maven 'M2_HOME'
    }
    environment {
    registry = '447921315641.dkr.ecr.us-east-1.amazonaws.com/devops-repo'
    registryCredential =  'aws-credentials'
    dockerimage = ''
  }
    stages {
        stage('Checkout'){
            steps{
                git credentialsId: '9ef3ad39-805a-4121-b6d1-049f135f3615', url: 'https://gitlab/engineering/automation/create_pass_criteria.git'
                git branch: 'main', url: 'https://github.com/syl82/maven-test.git'
            }
        }
        stage("sonarqube scan"){
          steps{
      withsonarQubeEnv('sonarQube'){
        sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=syl82_geolocation1'
      }


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
                    docker.withRegistry("https://"+registry,  "ecr:us-east-1:"+registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }  
    }
}


