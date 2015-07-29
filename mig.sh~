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
    
    ./../../../../../../Utils/AD $npi $nci $norb 0 < exstate > dtemp1
    ./../../../../../../Utils/ColMO $npi $norb $step 0 < dtemp1 > attach.dat
    rm dtemp1 exstate

    #prep spread files
    for((l=0;l<$limstep;l++))
    do
	awk -v l=$l 'BEGIN{hc=0;ec=0;}{if ($1==l && $5>0.0001){hc+=1;} if($1==l && $6>0.0001){ec+=1;}}END{print l, hc, ec;}' attach.dat >> inith-e_spread 
    done
    
    echo "done spread"

    #prep density files
    awk '{if ($1==0) print $5, $6}' attach.dat | head -64 > dens_0 #get h and e for every atom
    awk -v step=$limstep '{if ($1==(step-1)) print $5, $6}' attach.dat | head -64 > dens_beforeCT #get h and e for every atom
    awk 'BEGIN{c=0}{c++; print c, $1}' dens_0 >> ../../hdens_0
    awk 'BEGIN{c=0}{c++; print c, $2}' dens_0 >> ../../edens_0
    awk 'BEGIN{c=0}{c++; print c, $1}' dens_beforeCT >> ../../hdens_beforeCT
    awk 'BEGIN{c=0}{c++; print c, $2}' dens_beforeCT >> ../../edens_beforeCT

    echo "done density"
    
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
awk 'BEGIN{hav=0;eav=0} {hav+=$1; eav+=$2; c++} END{print hav/c, eav/c}' h-e_spread_tot >> h-e_spread_tot

#get final density file
for ((n=1;n<=64;n++))
do
    awk -v n=$n -v files=$files 'BEGIN{sum=0;}{if ($1==n) {sum+=$2}} END{print sum/files}' hdens_0 >> hdens_0_av
    awk -v n=$n -v files=$files 'BEGIN{sum=0;}{if ($1==n) {sum+=$2}} END{print sum/files}' edens_0 >> edens_0_av
    awk -v n=$n -v files=$files 'BEGIN{sum=0;}{if ($1==n) {sum+=$2}} END{print sum/files}' hdens_beforeCT >> hdens_beforeCT_av
    awk -v n=$n -v files=$files 'BEGIN{sum=0;}{if ($1==n) {sum+=$2}} END{print sum/files}' edens_beforeCT >> edens_beforeCT_av
done

#cd ../
#octave --eval "boxav('$folder/hdens_0_av')" | tail -65 | head -64 > $folder/hdens_0_smooth
#octave --eval "boxav('$folder/edens_0_av')" | tail -65 | head -64 > $folder/edens_0_smooth
#octave --eval "boxav('$folder/hdens_beforeCT_av')" | tail -65 | head -64 > $folder/hdens_beforeCT_smooth
#octave --eval "boxav('$folder/edens_beforeCT_av')" | tail -65 | head -64 > $folder/edens_beforeCT_smooth

#octave --eval "boxav('$folder/hdens_0_smooth')" | tail -65 | head -64 > $folder/hdens_0_s
#octave --eval "boxav('$folder/edens_0_smooth')" | tail -65 | head -64 > $folder/edens_0_s
#octave --eval "boxav('$folder/hdens_beforeCT_smooth')" | tail -65 | head -64 > $folder/hdens_beforeCT_s
#octave --eval "boxav('$folder/edens_beforeCT_smooth')" | tail -65 | head -64 > $folder/edens_beforeCT_s
#cd $folder/

paste ../../2_PCDTBT/$dist hdens_0_av edens_0_av  | sort -k2nr > h-e_dens_0
head -63 h-e_dens_0 > fh-e_dens_0 
paste ../../2_PCDTBT/$dist hdens_beforeCT_av edens_beforeCT_av | sort -k2nr > h-e_dens_beforeCT
head -63 h-e_dens_beforeCT > fh-e_dens_beforeCT

paste h-e_dens_0 h-e_dens_beforeCT | awk '{print $1, $2, $7-$3, $8-$4}' > h-e_dens_comb
#cleanup
rm h_spread e_spread 
#rm hdens_0 edens_0 hdens_beforeCT edens_beforeCT 
#rm hdens_0_av edens_0_av hdens_beforeCT_av edens_beforeCT_av 


