#!/usr/bin/perl -w 
use strict;

my $course = $ARGV[0];
my $url1 = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/$course.html";
my $url2 = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/$course.html";
my @urls = ();

push @urls, $url1;
push @urls, $url2;

for my $i (0..1) {
   open F, "wget -q -O- $urls[$i]|" or die;
   while (my $line = <F>) {
       if ($line =~ /Pre(?:-?requisites?)?:([^<]*)/i) {
           $line =~ s/Excluded.*$//;
           my @courses = ($line =~ /[a-z]{4}[0-9]{4}/gi);
	   tr/a-z/A-Z/ for @courses;
           print (join "\n", @courses);
           print ("\n");
       }
   }
}
