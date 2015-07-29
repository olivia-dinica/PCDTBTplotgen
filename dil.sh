##############################################################################################################################
#

#
##############################################################################################################################

rm h-e_spread_tot 
dist="distcarb"
#folder="mid-carb-sift"
files=24
for ((i=1;i<=$files;i++))
do
    cd onlyLEXtoCT/$i
    echo $i

    limstepinit=`head -n $((($i*4)-1)) ../table_path_raw_altered | tail -1 | awk '{lim=$1}END{print lim}'`
    echo $limstepinit
    limstep=`bc <<< $limstepinit/1`

    grep occupied run.out | awk '{print $4}' | head -n $limstep > exstate
    
    nnuc=`grep nnuc start.inpt | awk '{print $1}'`
    nci=`grep nci start.inpt | awk '{print $1}'`
    npi=`grep "(npi)" start.inpt | awk '{print $1}'`
    norb=`grep norb start.inpt | awk '{print $1}'`
    step=`grep nsteps start.inpt | awk '{print $1}'`
    
    ## attachment_density.cc --> AD
    ## collect_MOs.cc ---------> ColMO
    
#    ./../../../../../../Utils/AD $npi $nci $norb 0 < exstate > dtemp1
#    ./../../../../../../Utils/ColMO $npi $norb $step 0 < dtemp1 > attach.dat
#    rm dtemp1 exstate

    #prep spread files
    for((l=0;l<$limstep;l++))
    do
	awk -v l=$l 'BEGIN{hc=0;ec=0;}{if ($1==l && $5>0.01){hc+=1;} if($1==l && $6>0.01){ec+=1;}}END{print l, hc, ec;}' attach.dat >> inith-e_spread 
    done
    
    echo "done spread"

    awk '{print $5}' justoccup_* | head -n $limstep > temp
    paste inith-e_spread temp > h-e_spread
    sh_init=`head -1 h-e_spread | awk '{print $2}'`
    se_init=`head -1 h-e_spread | awk '{print $3}'`
    sh_fin=`tail -1 h-e_spread | awk '{print $2}'`
    se_fin=`tail -1 h-e_spread | awk '{print $3}'`
    python -c "print ($sh_fin.0-$sh_init.0)/$sh_init.0*100" >> ../../h_spread
    python -c "print ($se_fin.0-$se_init.0)/$se_init.0*100" >> ../../e_spread

    rm inith-e_spread temp

    cd ../..
done

#get final spread file
paste h_spread e_spread > h-e_spread_tot 
#awk 'BEGIN{hav=0;eav=0} {hav+=$1; eav+=$2; c++} END{print hav/c, eav/c}' h-e_spread_tot >> h-e_spread_tot

#cleanup
rm h_spread e_spread 


