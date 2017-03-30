# This needs to get into your .bashrc somewhow
# for example: . .bash.d/bashrc
# Or just symlink this file as .bashrc or .bash_profile

# if you make sure this runs from
# .bash_profile instead of .bashrc or remove the
# interactive check from .bashrc then you can have the profile version
# of scripts run for all shells, not just interactive ones




if  [ -f $HOME/.bash.d/local/profile/$(hostname)_.sh ]
then
   source $HOME/.bash.d/local/profile/$(hostname)_.sh     
fi 
if  [ -f $HOME/.bash.d/local/profile/${USER}@$(hostname)_.sh ]
then
   source $HOME/.bash.d/local/profile/${USER}@$(hostname)_.sh     
fi

if  [ -f $HOME/.bash.d/os/profile/${OSTYPE}_.sh ]
then
   source $HOME/.bash.d/os/profile/${OSTYPE}_.sh     
fi 

for i in $HOME/.bash.d/profile/*.sh; do source $i; done
unset i
if  [ -f $HOME/.bash.d/local/profile/$(hostname).sh ]
then
   source $HOME/.bash.d/local/profile/$(hostname).sh     
fi 
if  [ -f $HOME/.bash.d/local/profile/${USER}@$(hostname).sh ]
then
   source $HOME/.bash.d/local/profile/${USER}@$(hostname).sh     
fi
if  [ -f $HOME/.bash.d/os/profile/${OSTYPE}.sh ]
then
   source $HOME/.bash.d/os/profile/${OSTYPE}.sh     
fi 

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return


if  [ -f $HOME/.bash.d/local/$(hostname)_.sh ]
then
   source $HOME/.bash.d/local/$(hostname)_.sh     
fi 
if  [ -f $HOME/.bash.d/local/${USER}@$(hostname)_.sh ]
then
   source $HOME/.bash.d/local/${USER}@$(hostname)_.sh     
fi

if  [ -f $HOME/.bash.d/os/${OSTYPE}_.sh ]
then
   source $HOME/.bash.d/os/${OSTYPE}_.sh     
fi 

for i in $HOME/.bash.d/*.sh; do source $i; done
unset i
if  [ -f $HOME/.bash.d/local/$(hostname).sh ]
then
   source $HOME/.bash.d/local/$(hostname).sh     
fi 
if  [ -f $HOME/.bash.d/local/${USER}@$(hostname).sh ]
then
   source $HOME/.bash.d/local/${USER}@$(hostname).sh     
fi
if  [ -f $HOME/.bash.d/os/${OSTYPE}.sh ]
then
   source $HOME/.bash.d/os/${OSTYPE}.sh     
fi 
