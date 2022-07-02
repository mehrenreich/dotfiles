# dotfiles

When executing the `install.sh` script, this happens:

1. All scripts `*.preinstall` found in this folder are executed
2. Symlinks are created inside of your `$HOME` pointing to a `*.symlink` file accordingly in this folder
3. All scripts `*.postinstall` found in this folder are executed
