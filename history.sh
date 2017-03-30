# History Options
# ###############

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups:ignorespace"

# Ignore some controlling instructions
export HISTIGNORE="[   ]*:&:bg:fg:exit"

# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"



shopt -s histappend
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
