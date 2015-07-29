for ((l=500;l<=50000;l+=500))
do

st=`awk '{if ($1=="state") s=$2}END{print s}' $l/restart.inpt`
echo $st
rm $l/start.inpt.what
cp $l/start.inpt $l/start.inpt.tmp

awk -v st=$st '{if ($2=="(ntully)") print st+3, "             (ntully) Number of excited states that may be occupied in surface hopping"; el\
se print}' $l/start.inpt.tmp > $l/start.inpt

done
