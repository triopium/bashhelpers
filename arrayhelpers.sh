#!/bin/bash
################

#############################
# araprint prints input array
function arrprint(){
	local -n ara=$1
	for i in "${ara[@]}"; do
		echo $i
	done
}


# araprint prints input array with indexes
function arrprintv(){
	local -n ara=$1
	for i in "${!ara[@]}"; do
		printf '%4d | %s\n' $i "${ara[$i]}"
	done
}

#TEST: araprint
#unset abc
#declare -a abc[0]="jamaka"
#declare -a abc[1]="bamaka"
#declare -a abc[3]="kundre"
#arrprint abc
#arrprintv abc
############################

############################
# arrprint prints array (function just for code)
function arrprintver2(){
	argA="${1}"
	argA="${argA}[@]"
	for i in "${!argA}"; do
		echo $i
	done
}

# TEST: arrprintv2
#artest=(
#a
#b
#c
#)
#arrprint artest 

################################################
# comarrcol extracts command ($1) output column ($3) to array ($2)
# 'comarcol command arrayname column n'
# Note: also the name of array is printed (strange)
function comarrcol(){
	readarray -t "$2" <<< $($1 | awk -v var=$3 '{print $var}')
	echo "Array start:"
		arrprint $2
	echo "Array End:"
}

# TEST: comarrcol
unset abc
comarrcol "ls -la" abc 3 
echo "${abc[@]}"
arrprintv abc
################################################

function getcol(){
    local  __resultvar=$1
	local  myresult=$($2 | awk -v var="$3" '{print $var}')
    if [[ "$__resultvar" ]]; then
        eval $__resultvar="'$myresult'"
    else
        echo "$myresult"
    fi
}


# works
function getcv(){
	readarray -t ara <<< $($2 | awk '{print $1}')
	echo "Start extracted:"
		for i in "${ara[@]}"; do
			echo "  " $i
		done
	echo "End"
}

#declare -a abc[0]="jamaka"
#declare -a abc[1]="bamaka"
#getcv ab ls
##echo $ab

