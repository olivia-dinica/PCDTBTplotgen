#1: timestep
#2: state #
#3: state E
#4: occupied or not
#5: exciton or ct


for ((t=0;t<300;t++))
do
    count=0
    echo $t
    for ((n=1;n<=84;n++))
    do
	num=`awk -v t=$t 'BEGIN{c=0}{if ($1==t && $4==1 && $5==1) c=1}END{print c}' $n/master_$n`
	let "count += $num"
    done
    echo $t $count >> initrateCT
done

awk '{print $1, -$2/84}' initrateCT > rateCT

rm initrateCT

