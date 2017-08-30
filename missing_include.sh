array_filename=()
get_filedata=()
get_trimfiledata=()
get_allrequiredincludedata=()
chk=0
count=0

for f in *; do
    array_filename[${#array_filename[@]}]="$f"
    count=`expr $count + 1`
done


terminal=`tty`
for var in "$@"
do
exec < $var
while read line
do
get_filedata[${#get_filedata[@]}]="${line// }"
done
done
exec < $terminal

for f in "${f[@]}"; do
for g in "${get_filedata[@]}"; do
if ! echo "$g" | grep -q "include<"; then get_trimfiledata[${#get_trimfiledata[@]}]="$g"; 
fi
done
done

for t in "${get_trimfiledata[@]}"; do
if echo "$t" | grep -q "include"; then get_allrequiredincludedata[${#get_allrequiredincludedata[@]}]="${t:9:3}";
fi
done

for p in "${get_allrequiredincludedata[@]}";do
	for array_filename in "${array_filename[@]}"; do
        	if [ "$p" != "$array_filename" ]; then 
        	chk=`expr $chk + 1`
        	fi
	done
   	if [ $chk == 5 ]; then
   	echo "$p included into $1 does not exist"
   	fi
   	chk=0
done


