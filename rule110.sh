input="x01010101000000000000000000000000000010x"
gens=20
cap=40
declare -A board
declare -A map=( ["111"]="0" ["110"]="1" ["101"]="1" ["100"]="0" ["011"]="1" ["010"]="1" ["001"]="1" ["000"]="0" )
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'
declare -A colors=( [0]=$GREEN [1]=$RED [2]=$BLUE [3]=$CYAN [4]=$NC )
dt="          $(date +"%D %T")"
welcome="          Welcome $USER"
len=$(echo $welcome | wc -c)
col=$(( $RANDOM % 5))
for ((i=0;i<gens;i++)) do
	for((j=0;j<cap;j++)) do
		board[$i,$j]="${input:$j:1}"
	done
done
b=1
for ((g=1;g<gens;g++)) do
	for((i=2;i<cap-2;i++)) do
		curr="${board[$(( $g-1 )),$(( $i-1 ))]}${board[$(( g-1 )),$i]}${board[$(( g-1 )),$(( $i+1 ))]}"
		board[$g,$i]="${map["${curr}"]}"
	done
done

for (( g=0; g < gens; g++ )); do
	for (( i=2; i<cap; i++ )); do
		if [ "${board[$g,$i]}" == "1" ];
		then
			printf "${colors[$col]}*" 
		else
			if [ $i -lt $((11+$len)) ] && [ $g -eq 4 ];
			then
				printf "${NC}${welcome:$((i-2)):1}"
			elif [ $i -lt $((11+$len)) ] && [ $g -eq 5 ];  
			then
				printf "${NC}${dt:$((i-2)):1}"	
			else	
				printf " "
			fi
		fi
	done	
	printf "\n"
done

