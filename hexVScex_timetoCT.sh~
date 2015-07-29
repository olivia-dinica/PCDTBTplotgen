rm timetoCT

for ((l=1;l<=94;l++))
do
##ONLY FOR mid-***-sift#####################################
#awk '{if ($4==1 && $5==1) print}' $l/master_$l > $l/temp
############################################################

##ONLY FOR NEXT300 folder###################################
    awk '{if ($4==1 && $5==1) print}' $l/concat_master_$l > $l/temp
############################################################

head -1 $l/temp >> timetoCT
rm $l/temp
done

