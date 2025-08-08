pipeline {
    agent any
    tools {
        jdk 'JAVA_HOME'
        maven 'maven3'
    }
    environment {
        SCANNER_HOME=tool 'sonar'
    }
    stages {
        stage('Git checkout') {
            steps {
                git
            }
        }
        stage('compile code') {
            steps {
                bat "mvn clean compile"
            }
        }
        stage('code test') {
            steps {
                bat "mvn test"
            }
        }
        stage('sonar analysis') {
            steps {
                 withSonarQubeEnv('sonar') {
                    bat "\"%SCANNER_HOME%\\bin\\sonar-scanner\" -Dsonar.projectName=sonar-qube-analsys1 -Dsonar.java.binaries=. -Dsonar.projectKey=sonar-qube-analsys"
                }
            }
        }
    }
}