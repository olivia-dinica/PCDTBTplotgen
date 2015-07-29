for ((i=1;i<=1;i++))
do
    cd onlyLEXtoCT/$i
    echo $i

    timeinit1=`head -n $((($i*4)-1)) ../table_path_raw_altered | tail -1 | awk '{lim=$1}END{print lim}'`
    timeinit2=`bc <<< $timeinit1/1`
    time=$(($timeinit2-1))

    head -124 MO_coefs.dat > MOstart
    head -n $(($time*124)) MO_coefs.dat | tail -124 > MOend

    python ../../../../../../Utils/PCDTBTplotgen/dist_from_C60_bt.py MOstart MOend
    cd ..
done
