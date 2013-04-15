export AUTOSSH_LOGFILE=/autossh.log
export AUTOSSH_LOGLEVEL=7
export AUTOSSH_GATETIME=0

autossh -M 3000 -R 2222:localhost:22 -i ~/mykey.pem ec2-user@ec2-99-999-9-999.us-west-2.compute.amazonaws.com
