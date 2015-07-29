rm table_path_raw

for ((l=1;l<=84;l++)) do 
echo $l
echo $l >> table_path_raw
python ../../../../../Utils/PCDTBTplotgen/table_path.py $l/justoccup_$l >> table_path_raw
done
