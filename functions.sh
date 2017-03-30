
# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }


function mkdir
{
  command mkdir -p "$@"
}
