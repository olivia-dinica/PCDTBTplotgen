    state_start=1
    awk '{if ($2=="(norb)") print $1}' start.inpt > norb   
    awk -v s=$state_start '{if($1==0 && $2==s) print $1, $2, $4, $5, $6}' CI_coefs.dat | tail -6 > CIstart
    
    head -5 MO_coefs.dat > MOstart

    python ../../../Utils/PCDTBTplotgen/wavefn.py CIstart MOstart norb

