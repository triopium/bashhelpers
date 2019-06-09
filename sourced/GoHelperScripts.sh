#!/bin/bash
################################

# Creates main.go file
function GoCreateMain(){
cat <<EOT >> main.go
package main

import (
	aux "git.eltoversum.cz/StrategickyRozvoj/citidea/auxlib.git"
	// aux "git.eltoversum.cz/StrategickyRozvoj/citidea/auxlib.git"
	log "git.eltoversum.cz/StrategickyRozvoj/citidea/elgolog.git"
	//log "git.eltoversum.cz/StrategickyRozvoj/citidea/elgolog.git"
	n "git.eltoversum.cz/StrategickyRozvoj/citidea/natszilla.git"
	// rcat "git.eltoversum.cz/StrategickyRozvoj/citidea/registerin-cat.git"
)

func main(){
	aux.Sleeper(1,"s")
	log.SetLogLevel("debug")
	c := n.Config{}
}
EOT
}

# Creates go .gitignore
function GoCreateGitignore(){
cat <<EOT >> .gitignore
# IntelliJ project files
.idea
.idea/project-template.iml
out
gen
pkg

# dep
.netrc
.netrc*

# emacs, vim backup files
\#*
\.\#*
*~

EOT
}

# Creates new go project with structure name/src/name
function gopNew(){
	pname=$1
	if [ -z $pname ]; then
		read -n1 -r -p "No project name specified" key
		return
	fi

	if [ -d "$pname" ] ; then
		read -n1 -r -p "Appears the project $pname already exists" key
		return
	fi

	echo "Create project?:" "$pname/src/$pname/main.go"
	select yn in yes no; do
	    case $yn in
	        yes)
				mkdir -p "$pname"
				cd "$pname"
				# auto-completion for private repos
				gocode set autobuild true
				GOPATH=`pwd`
				GoCreateGitignore
				mkdir -p "src/$pname"
				cd "src/$pname"
				GoCreateMain
				echo "Current gopath:" $GOPATH
				dep init -v
				dep ensure -v
				cd ..
				cd ..
				break
				;;
			no) 
				break
				;;
			*) echo "kak" "$yn"; break;;
	    esac
	done
}

# Force update go projecte dependencies to latest
function gopDepForce(){
	bs=$(basename $PWD)
	a="$PWD/pkg" 
	b="$PWD/src/$bs/vendor"
    c="$PWD/src/$bs/Gopkg.lock"
    d="$PWD/src/$bs/Gopkg.toml"

	if [ ! -d $a ] ; then
		echo ""
		echo "$a is not present"
		read -n1 -r -p "Appears not to be a go project base dir" key
		return
	fi

	echo "Delete?:" 
	echo "$a"
	echo "$b"
	echo "$c"
	echo "$d"

	select yn in yes no; do
	    case $yn in
	        yes)
				rm -rf "$a" "$b" "$c" "$d"
				cd "$PWD/src/$bs"
				dep init -v
				dep ensure -v -update
				break
				;;
			no) 
				break
				;;
			*) echo "kak" "$yn"; break;;
	    esac
	done
}

function gopQuickTest(){
	cd ~/Scripts/GO/quicktest/
	gopNew "$1"
	currentGOPATH="$GOPATH"
	GOPATH=`pwd`
	export GOPATH
	emacs . & disown
	GOPATH="$currentGOPATH"
	export GOPATH
}
