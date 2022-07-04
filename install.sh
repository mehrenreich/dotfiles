#!/bin/bash

THIS_DIR=$(cd `dirname $0`; pwd -P)

function execute_preinstall_scripts () {
	find $THIS_DIR -name "*.preinstall" -exec bash {} \;
}

function execute_postinstall_scripts () {
	find $THIS_DIR -name "*.postinstall" -exec bash {} \;
}

function create_symlinks () {
	for symlink in $(find $THIS_DIR -name "*.symlink") ; do
		basename=$(basename $symlink)
        if [[ $basename =~ ^__ ]] ; then
            path=$(echo $basename | sed s%__%/%g | sed s%^/%%)
            path="$HOME/.${path/\.symlink/}"
            dirname=$(dirname $path)
            if [[ ! -d $dirname ]] ; then
                mkdir -vp $dirname
            fi
            ln -vsf $symlink $path
        else
            ln -vsf $symlink $HOME/.${basename/\.symlink/}
        fi
	done
}

execute_preinstall_scripts
create_symlinks
execute_postinstall_scripts
