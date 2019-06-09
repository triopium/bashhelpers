#!/bin/bash
################################
dst="/media/kacabaj/TRUE/BACKUP_CENTRAL/_DEL_980/"
srcd="/home/kacabaj/"
declare -a arr=(
"Gop" 
"Notes" 
"Scripts"
"runs"
".config"
".cinnamon"
".emacs.d"
".cert"
".docker"
".fonts"
".mozilla"
"Downloads"
"Ebooks"
"Games"
"Isos"
"Pictures"
"fonts"
"netrc"
"git-completion.bash"
"thunderbird"
)

declare -a dots=(
"git-completion.bash"
".mozzila"
".tmux"
".ssh"
".vim"
".bash_aliases"
".bashrc"
".emacs.desktop"
".emacs_backup"
".gitconfig"
".gvimrc"
".inputrc"
".gtktermrc"
".netrc"
".profile"
".vimrc"
".tmux.conf"
)

cdate=$(date +%Y-%m-%d_%H-%M-%S)
mkdir -p "$dst/$cdate"
for i in "${arr[@]}"
do
   # tar -cvf 
   if [ -d "$srcd$i" ] ; then
	   tar -cvf "$dst$cdate/$i.tar" -C "$srcd$i" .
   fi
done
