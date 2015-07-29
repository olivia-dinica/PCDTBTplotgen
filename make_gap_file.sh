mkdir gapfiles

awk '{if ($4<210) print $1, $3, $4, $5}' gap.dat > trunc_gap.dat

for ((l=0;l<50125;l+=125)) do pl=`python -c "print $l/1000.0"`; echo $pl; awk -v pl=$pl '{if ($1==pl) print $1, $2, $3, $4}' trunc_gap.dat > gaplist$l; done

mv gaplist* gapfiles/.
