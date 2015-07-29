rm hex_timetoCT cex_timetoCT

for ((l=1;l<=84;l++))
do
##ONLY FOR mid-***-sift#####################################
    typ=`head -1 $l/justoccup_$l | awk '{if ($2>20) print 100; else print 0}'`
    awk '{if ($5==1) print}' $l/justoccup_$l > $l/temp
    
############################################################
    head -1 $l/temp > $l/itime

    if [ $typ -eq 100 ]
    then
	awk '{print $1}' $l/itime >> hex_timetoCT
    else
        awk '{print $1}' $l/itime >> cex_timetoCT
    fi

    rm $l/temp $l/itime
done

