#!/bin/bash

# I like to symlink a lot of config files from the root's home directory to my
# own personal directory.  It saves me time from having to update config files
# in the root's home every time I make a change in my personal home directory.

# NOTE: this script MUST be run in a `sudo' command

ROOT=/root
# put config files in here the you would like to be symlinked
configs=(.vimrc .inputrc .bashrc .bash_profile .irssi)
HOME=$(eval echo ~${SUDO_USER})

for config in ${configs[*]}
do
    if [ -e $HOME/$config ] ; then
        # make sure the user's config file exists
        if [ -e $ROOT/$config ] ; then
            # if root already has a config file of the same name, make a backup
            # of it
            echo "mv $ROOT/$config $ROOT/${config}.bak"
            mv $ROOT/$config $ROOT/${config}.bak
        fi
        # link the root's config file to the user's
        echo "ln -s $HOME/$config $ROOT/$config"
        ln -s $HOME/$config $ROOT/$config
        echo
    else
        echo $config does not exist!
    fi
done

exit 0
