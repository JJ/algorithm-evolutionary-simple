#!perl

use v5.14;

my $dir = shift || ".";

my $start = 'START';
my $end = 'END';

my @dirs = glob("$dir/[0-9]");

for my $d ( @dirs ) {
  my @stat_start = stat( "$d/$start");
  my @stat_end = stat( "$d/$end");
  if (  $stat_end[9] &&  $stat_start[9] ) {
    say $stat_end[9] - $stat_start[9];
  }
}
