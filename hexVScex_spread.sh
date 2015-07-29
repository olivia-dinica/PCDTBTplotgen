##############################################################################################################################
# will measure spread of electron and hole of 1st occupied exciton for both mid-carb and mid-bt 
# 
#
##############################################################################################################################

files=84
for ((i=1;i<=$files;i++))
do
    cd $i
    echo $i

################################################################################################################
####if correct attach.dat is not available, gotta make it again
    grep occupied run.out | head -1 | awk '{print $4}' > exstate
    nnuc=`grep nnuc start.inpt | awk '{print $1}'`
    nci=`grep nci start.inpt | awk '{print $1}'`
    npi=`grep "(npi)" start.inpt | awk '{print $1}'`
    norb=`grep norb start.inpt | awk '{print $1}'`
    step=0

    ## attachment_density.cc --> AD
    ## collect_MOs.cc ---------> ColMO
    ./../../../../../Utils/AD $npi $nci $norb 0 < exstate > dtemp1
    ./../../../../../Utils/ColMO $npi $norb $step 0 < dtemp1 > attach.dat
    rm dtemp1 exstate
#################################################################################################################

    s=`head -1 justoccup_$i | awk '{print $2}'`
    head -124 attach.dat | awk -v i=$i -v s=$s 'BEGIN{hc=0;ec=0;}{if ($2<64 && $5>0.0005){hc+=1;} if($2<64 && $6>0.0005){ec+=1;}}END{if (s>20) print i, hc, ec >> "../ihex_spread"; else print i, hc, ec >> "../icex_spread"}'
    
    cd ../
done

awk '{if ($2>20) print}' ihex_spread | awk 'BEGIN{c=0;h=0;e=0}{c++;h+=$2;e+=$3; print}END{print c, h/c, e/c}' > hex_spread
awk 'BEGIN{c=0;h=0;e=0}{c++;h+=$2;e+=$3; print}END{print c, h/c, e/c}' icex_spread > cex_spread
rm ihex_spread
rm icex_spread
