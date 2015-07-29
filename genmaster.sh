#1: step
#2: state #
#3: excited state energy
#4: occupied [yes(1)no(0)]
#5: exciton(0) ct(1) C60ex(5) other(6)
#6: osc strength

for ((n=1;n<=84;n++)) 
do
    cd $n
    echo $n

    maxstate=`grep ntully start.inpt | awk '{print $1}'`

    head -$((200*300)) gap.dat > gaptrunc
    
    awk -v maxstate=$maxstate '{if($3<=maxstate) print $1*1000, $3, $4}' gaptrunc > 123_$n
    grep occupied run.out | awk '{print $4}' > exstateTOT 
    ./../../../../../../Utils/PCDTBTplotgen/ExState $n $maxstate > 4_$n
    
    bash ../../../../../../Utils/PCDTBTplotgen/make_attach.sh
    sort -k1n,1 -k2n,2 e-h_dens > e-h_dens_sorted

    #0: exciton
    #1: CT
    #5: C60 exciton
    awk '{if($3>0.8 && $6>0.8) print 1; else if($3>0.8 && $4>0.8) print 0; else if($5>0.8 && $6>0.8) print 5; else print 6;}' e-h_dens_sorted > 5_$n

    awk -v maxstate=$maxstate '{if($3<=maxstate) print $5}' gaptrunc > 6_$n

    paste 123_$n 4_$n 5_$n 6_$n > master_$n
    
    rm 123_* 4_* 5_* 6_*
    awk '{if($4==1) print}' master_$n > justoccup_$n;

    cd ..
done
