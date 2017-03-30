# Bash Startup Scripts
The purpose of this is to organize your .bashrc scripts and sync them between machines. This started out fairly simple, but now can also handle your .profile and keep things synchronized between machines like .inputrc, emacs start up files, etc.

## How to Use
There are basically three parts to installing this setup. First, you have to wire the ~/.bash.d/bashrc script as a sourced element in your .bashrc or .bash_profile. You can create a symlink, cut and paste, or add a source line to your existing script (see step 1 below). Then you can create files that execute at bash startup. You can control the order they run in and you can also create scripts that only run for certain hosts, certain operating systems, and certain kinds of bash shells (interactive/non-interactive). Ideally, you'd remove all the content from your existing bash startup files and move that content here, leaving the startup files nearly empty except for the code in bashrc.

If you don't want to synchronize, that's the only two steps you need. However, if you want to you can synchronize the directory with git, rsync, rclone, dropbox, etc. These instructions assume git which is nice because it resolves conflicts and gives you revision history.

## Step-by-Step
1. Use bashrc as your ~/.bashrc or add: source ~/.bash.d/bashrc to the end of your .bashrc. You can also use this in .bash_profile if you want to get rid of .bashrc all together. One easy thing to do is make .bashrc or .bash_profile a
symlink to ~/.bash.d/bashrc

2. Store scripts you don't want automatically run in ~/.bash.d/lib. Scripts in ~/.bash.d/local will only run for your user ID on a specific host.

3. The first file sourced will be local/hostname_.sh, if present. (That is, local/darkstar_.sh for host darkstar.)

4. Next is local/user@hostname_.sh (if present; e.g., local/snoopy@darkstar_.sh)

5. Then os/ostype_.sh is sourced, if present. Typical values for ostype  are linux-gnu, cygwin, etc. Do "echo ${OSTYPE}" to see your current value.

6. After that all files ending in .sh that reside in ~/.bash.d will be sourced.

7. Next local/user@hostname.sh and local/hostname.sh will be sourced, if present. (For example, local/snoopy@darkstar.sh).

8. Finally, os/ostype.sh will source if present. (For example, os/linux_gnu.sh).

9. Place other files you want to sync in the sync directory (for example, .emacs). You can create symlinks to them in the local file systems If you add them to the check.sh script and have the locations parallel
(that is, ~/foo/bar/config.txt => ~/.bash.d/sync/foo/bar/config.txt) then the check.sh script can ensure the links are installed.

## Interactive vs Non-interactive
Because .bashrc usually exits for non-interactive shells, all of the above only occurs for interactive shells. However, if you ensure that bashrc is sourced for all bash shells (e.g., replace .bash_profile or take out the interactive check that makes .bashrc only for interactive shells) you can place similar scripts in the profile subdirectories. These occur first and will run for all shells, not just interactive ones.

In other words, if bashrc runs for all shells the order is:
1. ~/.bash.d/local/profile/hostname_.sh
2. ~/.bash.d/local/profile/user@hostname_.sh
3. ~/.bash.d/os/profile/ostype_.sh
4. ~/.bash.d/profile/*.sh
5. ~/.bash.d/local/profile/hostname.sh
6. ~/.bash.d/local/profile/user@hostname.sh
7. ~/.bash.d/os/profile/ostype.sh
*** If shell is non-interactive, things stop here
8. ~/.bash.d/local/hostname_.sh
9. ~/.bash.d/local/user@hostname_.sh
10. ~/.bash.d/os/ostype_.sh
11. ~/.bash.d/*.sh
12. ~/.bash.d/local/hostname.sh
13. ~/.bash.d/local/user@hostname.sh
14. ~/.bash.d/os/ostype.sh

However, if bashrc only runs for interactive shells, steps 1-7 will still run for interactive shells, but only interactive shells and at that point, it is no different than not using the profile directories at all.

## More about Sync
For sync to work, the 000sync.sh script causes a git pull to occur. If you don't have your git repo set to automatically log in or if it is slow, or you don't sync across machines, you might want
to remove the file or comment the line in it out. Then you can sync manually by using git pull. When you make changes you should commit your changes locally and use git push. You could use other methods to synchronize and you'd change 000sync.sh to suit. If you don't want to sync, just remove 000sync.sh.

Currently, the script only updates to the repository. If you make changes, it is up to you to push your changes up when you are sure it is right.

In the sync directory is a sample script named check.sh. This is a proper script and you can execute it directly. However, you should modify the check.sh.txt file to reflect the files you want synchronized. The way it is set up, the files must be in the right location relative to the home directory. That is, to link the ~/x/y/z directory or file you need to have the file in ~/.bash.d/sync/x/y/z. Then check.sh will create that link for you (if you list the file in check.sh.txt). For example, check.sh.txt might look like this:

    .emacs.d/lisp
    .emacs.d/init.el
    .emacs.d/auto
    .emacs.d/elpa
    .inputrc
    
    
    
The output of running check.sh should look like this:

    $ ./check.sh 
    This script will link your sync'd files to other parts of the file
    system. If you have not customized check.sh.txt, you should press
    ^C now to exit, otherwise press Enter to continue
    
    .emacs.d/lisp link ok
    .emacs.d/init.el link ok
    .emacs.d/auto link ok
    .emacs.d/elpa link ok
    .inputrc link ok
    
   This has the effect of:

       ln -s ~/.bash.d/sync/.emacs.d/lisp ~/.emacs.d/lisp
       ln -s ~/.bash.d/sync/.emacs.d/init.el ~/.emacs.d/init.el
       ln -s ~/.bash.d/sync/.emacs.d/auto ~/.emacs.d/auto
       ln -s ~/.bash.d/sync/.emacs.d/elpa ~/.emacs.d/elpa
       ln -s ~/.bash.d/sync/.inputrc ~/.emacs.d/.inputrc
       
The script only creates links if they don't exist and will rename any previous file to have a .backup extension.

## Note about Scripts
NOTE: The .sh files are NOT proper shell scripts. They are sourced. You do not need to start them with #!/bin/bash (although you can) and they do not need to have executable permissions.


----------


Al Williams
al.williams@awce.com

