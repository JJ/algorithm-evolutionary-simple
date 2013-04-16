#!perl

use strict;use warnings;

my $dir = shift || ".";

my $start = 'START';
my $end = 'END';

my @stat_start = stat( "$dir/$start");
my @stat_end = stat( "$dir/$end");

print "Diff = ", $stat_end[9] - $stat_start[9], "\n";
