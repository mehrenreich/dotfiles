#!/bin/bash

THIS_DIR=$(cd `dirname $0`; pwd -P)

function execute_preinstall_scripts () {
    if [[ ! -z $1 ]] ; then
        path=$THIS_DIR/$1
    else
        path=$THIS_DIR
    fi
    find $path -name "*.preinstall" -exec bash {} \;
}

function execute_postinstall_scripts () {
    if [[ ! -z $1 ]] ; then
        path=$THIS_DIR/$1
    else
        path=$THIS_DIR
    fi
	find $path -name "*.postinstall" -exec bash {} \;
}

function create_symlinks () {
    if [[ ! -z $1 ]] ; then
        path=$THIS_DIR/$1
    else
        path=$THIS_DIR
    fi
	for symlink in $(find $path -name "*.symlink") ; do
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

item=$1

execute_preinstall_scripts $item
create_symlinks $item
execute_postinstall_scripts $item
