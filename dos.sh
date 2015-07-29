morph=bt
files=94
block=5
rm dos
rm dos-$morph
rm gap0-$morph

for ((f=1; f<=$files; f++))
do
    awk '{if ($1==0 && $4<350) print}' mid-$morph-sift/$f/gap.dat >> gap0-$morph
done

for ((i=60; i<350; i+=$block)) #max of 400 kj/mol cuz the rest is excessive
do
    awk -v i=$i -v block=$block 'BEGIN{c=0}{if ($4>(i-block) && $4<(i+block)) c++} END{print i/96.48, c}' gap0-$morph >> dos
done

max=`awk 'BEGIN{max=0}{if ($2>max) max=$2}END{print max}' dos`
awk -v max=$max '{print $1, $2/max}' dos > dos-$morph
