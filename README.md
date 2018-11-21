# bash-script

###1. getGitInfoProject.sh
  Use:
  
    ```bash
    ./getGitInfoProject.sh /path/to/dir/project
    ```
    
    Or (replace default projectDir(projectDir=~/domains/;) in file)
    
    ```bash
    ./getGitInfoProject.sh
    ```
    
    Setting .gitconfig for faster load
    
    ```
      [core]
              preloadindex = true
              fscache = true
      [gc]
              auto = 256
    ```
