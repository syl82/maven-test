pipeline {
    agent any
    tools {
        maven 'M2_HOME'
    }
    environment {
        registry = '447921315641.dkr.ecr.us-east-1.amazonaws.com/devops-repo'
        registryCredential = 'aws-credentials'
        dockerImage = ''
        SONAR_TOKEN = credentials('sonarqubeID')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/syl82/maven-test.git'
            }
        }
        stage("sonarqube scan") {
            steps {
                withCredentials([string(credentialsId: 'sonarqubeID', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('sonarQube') {
                        
                            sh 'mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
     -Dsonar.projectKey=syl82_geolocation1'
                        
                    }
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
                script {
                    dockerImage = docker.build(registry + ":$BUILD_NUMBER")
                }
            }
        }
        stage('Deploy image') {
            steps {
                script {
                    docker.withRegistry("https://" + registry, "ecr:us-east-1:" + registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}


