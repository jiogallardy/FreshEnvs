# newDevEnv

## Repo design 


```setup_env.sh ```: main entry point for this bash application, checks OS type, then delegates to subscripts intended for specific OS type. 

### Scripts by OS type  

#### Linux  
```setup_linux_dev.sh```, checks if user wants to install typical apt packages enumerated in ```apt_packages.txt```, (thefuck, xclip, tree etc) then moves to installations to see if user wants to install packages in ```installations.txt```, ie (Terraform, npm, python etc)

#### Mac  
See ```./mac```

#### Windows
See ```./windows```

Other scripts: 
```copy_to_target.sh``` Bash script for copying repository to a target ssh computer over scp

