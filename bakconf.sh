#!/bin/bash

# FUNCTION: to update a list of file and folder to another directory
# USAGE: 
# in file defined your variable,  run this script at terminal:
#       ./bakconf.sh   # A --> B
#       ./bakconf.sh r # A <-- B
# or you can just call function like
#       updateFD [file_name_list] [dirA] [dirB]
# then you should be done all the work  ...

A=~
B=/mnt/hgfs/shdir/bak

filelist=(\
    bakconf.sh \
    .xinitrc \
    .bashrc \
    .profile \
    .xprofile \
    .vimrc \ 
    .gvimrc \
    .vim \
    .i3 \
    .i3status.conf \
    .zshrc \
    .emacs.d/init.el \
)

updateFD(){
    baklist=("${!1}")
    dirA=$2
    dirB=$3
    for i in ${baklist[*]}
    do
        if [[ -d $dirA/$i ]]; then
            cp -u -a $dirA/$i $dirB
        elif [[ -f $dirA/$i ]]; then
            cp -u $dirA/$i $dirB
        fi
    done
}

if [[ $1 = r ]]; then
    updateFD filelist[*] $B $A
    echo  [$0]: restore from  \'$B\' to \'$A\' finish!
elif [[ $# = 0 ]]; then
    updateFD filelist[*] $A $B
    echo  [$0]: backup from \'$A\' to \'$B\' finish!
fi
