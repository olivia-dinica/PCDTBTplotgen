#1: timestep
#2: state #
#3: state E
#4: occupied or not
#5: exciton or ct

folders=94
type=10 #1 is for low ex, 10 is for any type of state in high abs peak

f=0
for ((t=1;t<600;t++))
do
    c=0
    echo "time" $t
    for ((n=1;n<=$folders;n++))
    do
	start=`head -1 ../$n/justoccup_$n | awk 'BEGIN{b=0}{if ($5==0 && $2>20) b=10; if ($5==0 && $2<=20) b=1; if ($5==5) b=10; if ($5==6) b=10}END{print b}'`
#	echo "start state" $start
	if [ $start -eq $type ]
	then
	    ct=`awk -v t=$t 'BEGIN{c=0}{if ($1==t && $4==1 && $5==1) c=1}END{print c}' $n/concat_master_$n`
	    let "c += $ct"
	    let "f++"
#	    echo "f" $f
	fi
    done
    echo $t $c >> initrateCT$type
done

awk -v f=$f '{print $1, -$2/(f/600)}' initrateCT$type > rateCT$type

rm initrateCT$type

