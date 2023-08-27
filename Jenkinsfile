pipeline {
    agent any
    tools {
        maven 'mvn'
        terraform 'tf'
    }
     environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION= 'ap-south-1'
    }

    stages {
        stage ('Clone Code') {
            steps {
                git url: "https://github.com/nazeerbasha96/foodies-k8s-cicd.git" , branch: "master"
            }
        }
        stage ('Create a k8s cluster' ){
            steps{
                sh '''
                    terraform -chdir=Terraform/Golbal/ init
                    terraform -chdir=Terraform/Golbal/ plan
                    terraform -chdir=Terraform/Golbal/ apply --auto-aprove
                '''
            }
        }
        stage('test') {
            steps {
                sh(script: 'mvn --batch-mode  test')
                //-Dmaven.test.failure.ignore=true
            }
        }
        stage ('build artfact'){
            steps {
                sh ' mvn  clean verify'
            }
        }
        stage('bulid Docker Image'){
            steps {
                echo"building the foodies docker image"
                sh "docker build -t foodies ."
            }
        }
        stage ('push Image'){
            steps{
                withCredentials([usernamePassword(credentialsId:"dockerhub",passwordVariable:"dockerhubpass",usernameVariable:"dockerhubuser")]){
                sh "docker image tag foodies ${env.dockerhubuser}/foodies:latest"
                sh "docker login -u ${env.dockerhubuser} -p ${env.dockerhubpass}" 
                sh "docker push ${env.dockerhubuser}/foodies:latest"
            }
        }
        stage('deploy app in K8s cluster'){
            steps{
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'AWS_KEYS',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')])
                sh ''' 
                    aws eks update-kubeconfig --region ap-south-1 --name devops_eks
                    kubectl create -f .
                '''
            }
        }  
    }
}






















        