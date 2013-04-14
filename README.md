ReverseTunnel
=============

Create a reverse tunnel with an Amazon EC2 instance. In case your macbook get stolen you can access it from anywhere perform actions like: grabbing keychain, use iCapture, screenshot, locate machine, wipe machine.

In this example I'm going to use a free EC2 instance but it can be any linux server.
If don't you have an AWS account go ahead and signup for one. (http://aws.amazon.com/)

Part A (sever setup):
* 1.	Before you create an ec2 instance you need to setup a firewall
	* A. From EC2 console > Select security group
	* B. There should be a default group, select that one
  	* C. Select inbound tab, delete all the rules since its opening all your ports
	* D. Add a rule to open port 22 and forwarding port, in this example I will use 2222
  	* Apply rule changes
* 2.	From EC2 console > launch instance > choose classic wizard
	* A. Choose AMI - choose any linux flavor you like
	* B. Instance details - use defaults and hit and continue
	* C. Create Key Pair - This key will be used to authenticate you into your instance, you can only download it once so save it to a proper place.
							 In this example I named it "mykey" and saved it to my user root folder on my laptop. So my key is sitting at ~/mykey.pem
	* D. Firewall - Select the default security group you modified in step 1
	* E. And launch!!

Give it a few seconds before your instance is running. Click on your instance and see your DNS, it should be something like this


		Public DNS: ec2-99-999-9-999.us-west-2.compute.amazonaws.com
Now check if it accessible, use the key you saved earlier and ssh into it:

		ssh -i ~/mykey.pem ec2-user@ec2-99-999-9-999.us-west-2.compute.amazonaws.com



Part B (laptop setup):

1. Install the following dependencies:

		ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
		brew install autossh

2. Start your ssh server on your laptop
		
		launchctl start com.openssh.sshd
		or
		System Preferences > Sharing > Check Remote Login
3. Autossh is a tool to maintain a persistent connection should your connection drop. More info (http://linux.die.net/man/1/autossh). 
The following command will create a reverse tunnel to your ec2 instance and persist it:

		autossh -M 3000 -R 2222:localhost:22 -i ~/mykey.pem ec2-user@ec2-99-999-9-999.us-west-2.compute.amazonaws.com
		
		-M flag specifies the port autossh will use to send test packets to your connection
		3000 is used in this case but autossh will also use port 3001 to receive inbound packets
		so whatever port you pick make sure port+1 is also available

		2222 is the port I opened on the ec2 which will forward to my localhost:22 (ssh) 
		

4. Now you can access your laptop from anywhere in the world.
		
		!!Note the username here will be your laptop's uername not the EC2's 
		ssh username@ec2-99-999-9-999.us-west-2.compute.amazonaws.com -p 2222

5. One big problem, how will autossh run if my laptop reboot? 
		
		Autossh default behavior will run 30s after reboot and completely terminate if it fails on its 1st attempt
		Your machine might not be able to establish wifi connection within 30s
		Setting this env variable to 0, enable autossh to retry infinitely
		export AUTOSSH_GATETIME=0

		sudo crontab -u root -e
		add a new entry
		@reboot autossh -M 3000 -R 2222:localhost:22 -i ~/mykey.pem ec2-user@ec2-99-999-9-999.us-west-2.compute.amazonaws.com
		
		Tada! problem solved.
		
6. 
		
		
		
		

		
		
									 
		
		

