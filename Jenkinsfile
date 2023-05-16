pipeline {   
    agent any
    
    tools {
        maven 'M2_HOME'
    }
    
    environment {
        registry = 'registry URL'
        registryCredential = 'credentials ID'
        dockerImage = '' 
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/syl82/maven-test.git'       
            }   
        }
         
        stage("SonarQube Scan") {
            steps {
                withCredentials([string(credentialsId: 'sonarqubeID', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv('sonarQube') {
                        sh 'mvn verify sonar:sonar  -Dsonar.projectKey=syl82_geolocation1'
                         
                    }   
                }    
            }
        }  
        
        stage('Build') {
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
                
        stage('Deploy Image') {      
            steps {  
                script {
                     docker.withRegistry("https://" + registry, registryCredential) {
                           dockerImage.push()
                      }
                 }
            }     
        }   
    }
}


