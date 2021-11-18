input="x00000000000000000000000000000000000010x"
gens=30
cap=40
declare -A board
declare -A map=( ["111"]="0" ["110"]="1" ["101"]="1" ["100"]="0" ["011"]="1" ["010"]="1" ["001"]="1" ["000"]="0" )
welcome="     Welcome solbob"
for ((i=0;i<gens;i++)) do
	for((j=0;j<cap;j++)) do
		board[$i,$j]="${input:$j:1}"
	done
done

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
			printf "*" 
		else
			if [ $i -lt 18 ] && [ $g -eq 4 ];
			then
				printf "${welcome:$((i-2)):1}"
			else	
				printf " "
			fi
		fi
	done	
	printf "\n"
done

