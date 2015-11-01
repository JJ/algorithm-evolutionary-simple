use Test::More; # -*- cperl -*-

use strict;
use warnings;

use lib qw( ../lib lib );

use Algorithm::Evolutionary::Simple qw( random_chromosome max_ones max_ones_fast );

my $length = 32;
my $number_of_strings = 32;

my @population;
my %fitness_of;
for (my $i = 0; $i < $number_of_strings; $i++) {
  my $this_chromosome = random_chromosome( $length);
  my $count_ones = grep( $_ eq 1, split(//, $this_chromosome));
  is( max_ones($this_chromosome), $count_ones, "Counting ones -- slow" );
  is( max_ones_fast($this_chromosome), $count_ones, "Counting ones -- fast" );
}

done_testing();
