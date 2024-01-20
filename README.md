# foodies
APP NAME = FOODIES

END TO END IMPLEMENTATION CI/CD PIPELINE DEPLOYING THE APPLICATION ON  KUBERNETES CLUSTER

Setup Jenkins Server on EC2 (OR) Local Machine:
Prerequisites:
    install below s/w in  jenkins server 
       
        1. install AWS Cli 
        2. install kubectl 
Steps:

1.Login into the jenkins server machine
    
    1.1 sudo apt update -y
    
    1.2 sudo apt install -y openjdk-11-jdk

    1.3 add the jenkins repository to the our ubuntu sources.list
        
        curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
        /usr/share/keyrings/jenkins-keyring.asc > /dev/null

        echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null

    1.4 sudo apt update -y
    1.5 Install the jenkins
        sudo apt install -y jenkins

    1.6 we can check the status of the jenkins by running 
        sudo systemctl status jenkins

    1.7 goto the web browser on the windows host and type 
        http://IP ADDRESS :8081 will open up the jenkins console
    
    1.8 In the first run, it prompts for password which is generated during the jenkins install and will be placed in initialAdminPassword file we can see the password  
    using below command.
     sudo cat /var/lib/jenkins/secrets/initialAdminPassword

    1.9 once we copy paste the password into the jenkins console, it prompts for installing suggested plugins, click on it will begin the setup and finally enter username, password to register and use jenkins


2. Docker install
   
   2.1 Install Docker Engine on Ubuntu Refer the below link
       Link : https://docs.docker.com/engine/install/ubuntu/
   
    2.2 Execute this command: sudo useradd -aG docker jenkins

3. Install Docker Plugin
  

Jenkins has a Docker plugin that enables communication with Docker hosts. To install the plugin in Jenkins, do the following:

 3.1 Select Manage Jenkins in the menu on the left side of the Jenkins dashboard.
 ![image](https://github.com/nazeerbasha96/foodies-k8s-cicd/assets/118157073/176f1c66-53cd-441d-a0c8-8377b15a32bc)

3.2. Click Manage Plugins in the Manage Jenkins window.

 ![image](https://github.com/nazeerbasha96/foodies-k8s-cicd/assets/118157073/2bca3656-5de3-4f55-92c9-edbc7d396a37)
3.3 Select the Available tab in the Plugin Manager window.

3.4 Type Docker in the search field, and select the box next to the Docker plugin that appears in the search results.

3.5 Click the Download now and install after restart button.
![image](https://github.com/nazeerbasha96/foodies-k8s-cicd/assets/118157073/9bdd4efc-71ab-4a38-b601-221009704983)
3.6 When all the necessary plugin components download, select the box at the bottom of the screen to restart Jenkins.
![image](https://github.com/nazeerbasha96/foodies-k8s-cicd/assets/118157073/1d43dae3-d767-449b-ba29-a33cbb72bb99)

4. install AWS plugin in jenkins server
   
5. install kubectl 

LINK :  
            
        https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/


6. Install AWS Cli refer this 

Link :  
    
    https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

To access the application need ALB Endpoint 
    1. login to aws account
    2. go to EC2 section
    3. go to load balancer section 

    URL to access the application is
        http:// (LOADBALANCER ENDPOINT ):8080/foodies/home

        

    
    
![Screenshot 2023-09-04 122249](https://github.com/nazeerbasha96/foodies-k8s-cicd/assets/118157073/4d4eb2a1-cee2-4739-b8a0-8935ad8fa063)





