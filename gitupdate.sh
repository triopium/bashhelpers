#!/bin/bash
################################
# CLONES REPOSITORIES GIVEN IN ARRAY OR UPDATES THEM WITH GIT PULL

declare -a arr=(
"ssh://git@ssh.git.eltoversum.cz:12345/StrategickyRozvoj/citidea/elgolog.git"
"ssh://git@ssh.git.eltoversum.cz:12345/StrategickyRozvoj/citidea/natszilla.git"
"ssh://git@ssh.git.eltoversum.cz:12345/StrategickyRozvoj/citidea/postgisdb.git"
)
#base="/home//"
dest="/media/kacabaj/TRUE/BACKUP_CENTRAL/_DEL_980/Gopgit/"
mkdir -p "$dest"
for i in "${arr[@]}"
do
	a="${i##*/}"
	b="${a%.git}"
	dstp="$dest$b/"
	if [ ! -d "$dstp" ] ; then
		mkdir -p "$dstp/"
		git clone --progress "$i" "$dstp/"
	else
		cd "$dstp"
		git pull --progress -v
	fi
done
