# foodies
APP NAME = FOODIES
END TO END IMPLEMENTATION CI/CD PIPELINE DEPLOYING THE APPLICATION ON  KUBERNETES CLUSTER

Setup Jenkins Server on EC2 (OR) Local Machine:
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
