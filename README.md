ReverseTunnel
=============

Create a reverse tunnel with an Amazon EC2 instance. In case your macbook get stolen you can access it from anywhere perform actions like: grabbing keychain, use iCapture, locate machine, wipe machine.

In this example I'm going to use a free EC2 instance but it can be any linux server.
If don't you have an AWS account go ahead and signup for one. (http://aws.amazon.com/)

Part A (sever setup):
1.	Before you create an ec2 instance you need to setup a firewall
		A. From EC2 console > Select security group
		B. There should be a default group, select that one
		C. Select inbound tab, delete all the rules since its opening all your ports
		D. Add a rule to open port 22 and forwarding port, in this example i will use 2222
		E. Apply rule changes
		
2.	From EC2 console > launch instance > choose classic wizard
		A. Choose AMI - choose any linux flavor you like
		B. Instance details - use defaults and hit and continue
		C. Create Key Pair - Select create new key pair and enter in any name you like, this key will be used to authenticate you into your instance, you can only download it once so save it to a proper place.
							 In this example I named it "mykey" and saved it to my user root folder on my laptop. So my key is sitting at ~/mykey.pem							 
		D. Firewall - Select the default security group you modified in step 1.
		E. And launch!!

