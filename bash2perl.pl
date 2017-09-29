#!/usr/bin/perl -w

$num_args = $#ARGV + 1;
if ($num_args > 1) {
    print "\nToo many arguments.";
    exit;
}
elsif($num_args < 1){
	print "\nToo few arguments.";
}
$bash_script = $ARGV[0];
open(my $fh, '<:encoding(UTF-8)', $bash_script)
  or die "Could not open file '$bash_script' $!";
 
while (my $row = <$fh>) {
	chomp $row;
	if(!(substr($row,0,1) eq '#')){
		$row =~ s/done/}/;
		$row =~ s/do/{/;
		$row =~ s/then/{/;
		$row =~ s/else/{/;
		$row =~ s/fi!/{/;
		$row =~ s/([a-z]+)=([a-z]*[0-9]*)/\$$1 = $2;/;
		$row =~ s/\$\(\(([0-9]*)[ ]*([!<>=+\-*\/]+)[ ]*([a-z]*)\)\)/$1 $2 \$$3\;/;
		$row =~ s/\$\(\(([a-z]*)[ ]*([!<>=+\-*\/]+)[ ]*([0-9]*)\)\)/\$$1 $2 $3\;/;
		$row =~ s/\$\(\(([a-z]*)[ ]*([!<>=+\-*\/]+)[ ]*([a-z]*)\)\)/\$$1 $2 \$$3\;/;
		$row =~ s/\(\(([a-z]*)[ ]+([!<>=+\-*\/]+)[ ]+([0-9]*)\)\)/\(\$$1 $2 $3\)/;
		$row =~ s/\(\(([0-9]*)[ ]+([!<>=+\-*\/]+)[ ]+([a-z]*)\)\)/\($1 $2 \$$3\)/;
		$row =~ s/\(\(([a-z]*)[ ]+([!<>=+\-*\/]+)[ ]+([a-z]*)\)\)/\(\$$1 $2 \$$3\)/;
		$row =~ s/echo ([\w\W]*)/print \"$1\\n\";/;
		$row =~ s/(.);(.)/$1$2/;
  		print $row,"\n";
	}
}


