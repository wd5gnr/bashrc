#!/bin/bash
echo This script will link your sync\'d files to other parts of the file
echo system. If you have not customized check.sh.txt, you should press
echo ^C now to exit, otherwise press Enter to continue
read
cd ~/.bash.d/sync
RV=0
while IFS='' read -r  I 
do
    [[ "$I" == "" ]] && continue
    [[ "$I" =~ ^[[:space:]]*$ ]] && continue
    [[ "$I" =~  ^# ]] && continue
    I1=x
    I2=x
    OPT=
    if [ -d "$I" ]
    then
	OPT=-d
    fi
    I1=`ls -iH $OPT "$I"|cut -f 1 -d ' '`
    I2=`ls -iH $OPT "$HOME/$I"|cut -f 1 -d ' '`

    if [ "$I1" == "$I2" ]
    then
	echo $I link ok
    else
	echo $I link not ok 
	if [ -f "$HOME/$I" -o -d "$HOME/$I" -o -L "$HOME/$I" ]
	then
	    echo Backing up original to ~/$I.backup
	    mv -f "$HOME/$I" "$HOME/$I.backup"
        fi
	echo Creating link
	ln -s "$HOME/.bash.d/sync/$I" "$HOME/$I"
	RV=1
    fi
done <"$0.txt"
exit $RV
