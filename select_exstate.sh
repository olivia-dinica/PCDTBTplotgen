octave ../../select_exstate.m | tail -400 | awk '{if ($1>0) print }' > list_of_selected_exstates

for((l=500;l<=50000;l+=500))
do
s=`awk -v l=$l 'BEGIN{s=0}{if ($2==l) s=$1}END{print s}' list_of_selected_exstates`
echo $l $s
awk -v s=$s '{if ($1=="state") {print " state         ", s} else print}' ../excited/$l/restart.inpt > restartemp
cp restartemp ../excited/$l/restart.inpt
rm restartemp
done
