for ((i=1;i<=1;i++))
do
    cd onlyLEXtoCT/$i
    echo $i
#    rm inith-e_carb inith-e_spread                                                                                                             
    awk '{if ($2=="(norb)") print $1}' start.inpt > norb
    timeinit1=`head -n $((($i*4)-1)) ../table_path_raw_altered | tail -1 | awk '{lim=$1}END{print lim}'`
    timeinit2=`bc <<< $timeinit1/1`
    time=$(($timeinit2-1))
    state_end=`head -n $(($time-1)) exstateTOT | tail -1`
    state_start=`head -1 exstateTOT`
    #echo "time" $time "state_end" $state_end "state_start" $state_start

    awk -v s=$state_start '{if($1==0 && $2==s) print $1, $2, $4, $5, $6}' CI_coefs.dat | tail -200 > CIstart
    awk -v t=$time -v s=$state_end '{if($1==t && $2==s) print $1, $2, $4, $5, $6}' CI_coefs.dat > CIend
    
    head -124 MO_coefs.dat > MOstart
    head -n $time MO_coefs.dat | tail -124 > MOend

    python ../../../../../../Utils/PCDTBTplotgen/wavefn.py CIstart CIend MOstart MOend norb
    cd ..
done
