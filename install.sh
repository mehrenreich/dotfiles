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
		ln -vsf $symlink $HOME/.${basename/\.symlink/}
	done
}

execute_preinstall_scripts
create_symlinks
execute_postinstall_scripts