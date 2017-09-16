#!/usr/bin/perl -w


$course = $ARGV[0];
@array = ();
$uni = "KENS";
$url = "http://www.timetable.unsw.edu.au/2017/$course$uni.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
   $line =~ /($course[0-9]{4})/;   
   if (defined $1 && ! grep /$1/, @array) {
      push @array, $1;     
   }
}
foreach (@array){
	print("$_ \n");
}

