
Steps to run: (Some terminologies maybe specific to Mac Terminal)

1) login to terminal by ssh.
2) Create a folder called “Rlib” in your root directory.
3) Create a file called .Rprofile in your root directory and add the following
  .libPaths(“<Path to the directory created in step 2>”)
4) Type R in terminal and install packages eg:
  install.packages('randomForest', repos='http://cran.us.r-project.org')
5) Copy runscript.sh and ML4.R to ur home folder.
6) Type the command : ./runscript.sh

Note: you may have to set the right permissions by folowing command: chmod 777 <filename>