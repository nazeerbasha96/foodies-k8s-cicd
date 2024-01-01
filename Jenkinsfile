pipeline {
    agent any
    tools {
        maven 'mvn'
        terraform 'terraform'
    }
    environment {
        // AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        // AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION= 'ap-south-1'
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage ('Clone Code') {
            steps {
                git url: "https://github.com/nazeerbasha96/foodies-k8s-cicd.git" , branch: "master"
            }
        }
        stage ('Create a k8s cluster' ){
            steps{
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'AWS_KEYS',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]){
                        // S3 bucket Configuring Remote State Backend 
                          // K8S creation using terraform 
                    sh '''                  
                        aws s3 mb s3://foodies.0-tfstate-bucket --region ap-south-1
                
                        terraform -chdir=Terraform/Golbal/ init
                        terraform -chdir=Terraform/Golbal/ plan
                        terraform -chdir=Terraform/Golbal/ apply --auto-approve
                    ''' 
                }
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
                // withCredentials([usernamePassword(credentialsId:"dockerhub",passwordVariable:"dockerhubpass",usernameVariable:"dockerhubuser")])
               script{
                    withDockerRegistry(credentialsId: 'dockerhub', toolName: 'docker'){
                        // sh "docker login -u ${env.dockerhubuser} -p ${env.dockerhubpass}" 
                        sh '''
                            docker image tag foodies $DOCKERHUB_CREDENTIALS_USR/foodies:latest
                            docker push $DOCKERHUB_CREDENTIALS_USR/foodies:latest
                        '''
                    }  
                } 
                
            }
            post {
                always{
                    sh "docker logout"
                }
            }
        }
            // to work this stage need install (CloudBees AWS Credentials Plugin) OR (Pipeline AWS Steps plugin) add access key and screct key in credentials in aws credentials 
        stage('deploy app in K8s cluster'){
            steps{
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'AWS_KEYS',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]){
                    sh ''' 
                        aws eks update-kubeconfig --region ap-south-1 --name devops_eks
                        kubectl create -f .
                     '''
                    }
            }
        }
        stage ('input step for destroy'){
            input {
                message  'Do you want destroy? k8s cluster and s3 bucket also confirm it'
                ok "yes"
            }
            steps {
                withCredentials([aws(accessKeyVariable:'AWS_ACCESS_KEY_ID',credentialsId:'AWS_KEYS',secretKeyVariable:'AWS_SECRET_ACCESS_KEY')]){
                    sh ''' 
                        kubectl delete -f .
                        terraform -chdir=Terraform/Golbal/ destroy --auto-approve
                        aws s3 rb s3://foodies.0-tfstate-bucket --force
                    '''
                }
                
            }
        }
        
    }
}