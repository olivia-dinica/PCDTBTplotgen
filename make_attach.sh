##############################################################################################################################
#
#   Get attachment density
#
##############################################################################################################################
rm e-h_dens
grep occupied run.out | awk '{print $4}' > exstate

maxstate=`grep ntully start.inpt | awk '{print $1}'`
nnuc=`grep nnuc start.inpt | awk '{print $1}'`
nci=`grep nci start.inpt | awk '{print $1}'`
npi=`grep "(npi)" start.inpt | awk '{print $1}'`
norb=`grep norb start.inpt | awk '{print $1}'`
step=`grep nsteps start.inpt | awk '{print $1}'`

## attachment_density.cc --> AD
## collect_MOs.cc ---------> ColMO
for ((i=1;i<=$maxstate;i++))
do
    echo $i
    ./../../../../../../Utils/AD $npi $nci $norb $i < exstate > dtemp1
    ./../../../../../../Utils/ColMO $npi $norb $step 0 < dtemp1 > attach.dat
    #head -$(($npi*($step-1))) attach.dat > attach_trunc
    
    for((l=0;l<$step;l++))
    do
	tail -$(($npi*($step-$l+1))) attach.dat | head -$npi > attach_$l
	awk -v l=$l -v i=$i 'BEGIN{hd=0;ed=0;ha=0;ea=0;}{if ($2<=64) {hd+=$5; ed+=$6;}if($2>64){ ha+=$5; ea+=$6}}END{print l, i, hd, ed, ha, ea}' attach_$l >> e-h_dens 
    done
    rm attach_*
done
