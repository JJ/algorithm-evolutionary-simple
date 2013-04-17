#!perl

use v5.14;

my $dir = shift || ".";

my $start = 'START';
my $end = 'END';

my @dirs = glob("$dir/*.dat");
my @stat_start = stat( "$dir/$start");
my @stat_end = stat( "$dir/$end");

my @times ;
for my $d ( @dirs ) {
  my @stats = stat($d);
  push @times, [$d, $stats[9]];
}

my @times_fitness;

say "Tiempo, Fitness";
for my $t ( sort { $a->[1] <=> $b->[1] } @times ) {
  my  ($fitness ) = ($t->[0] =~ /$dir.(.+?)_/);
  say $t->[1] - $stat_start[9], ", $fitness";
}



