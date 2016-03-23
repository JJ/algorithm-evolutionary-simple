#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../lib lib ../../../../proyectos/CPAN/Algorithm-Evolutionary/lib);

use version; our $VERSION = qv('0.0.1');
use Algorithm::Evolutionary::Fitness::P_Peaks;
use Algorithm::Evolutionary::Simple qw( random_chromosome  
					single_generation);
use Sort::Key::Top qw(rnkeytop);

my $bits = shift || 512;
my $number_of_strings = shift || 256;
my $peaks = shift || 256;

my @population;
my %fitness_of;
my $p_peaks = new Algorithm::Evolutionary::Fitness::P_Peaks( $peaks, $bits );
for (my $i = 0; $i < $number_of_strings; $i++) {
  $population[$i] = random_chromosome( $bits);
  $fitness_of{$population[$i]} = $p_peaks->p_peaks( $population[$i] );
}
  
my $evaluations=$#population+1; #rule of thumb
do {
  @population = single_generation(  \@population, \%fitness_of  );
  for my $p ( @population ) {
    if ( !$fitness_of{$p} ) {
      $fitness_of{$p} = $p_peaks->p_peaks( $p );
    }
  }
  $evaluations += $#population -1; # Two are kept from previous generation
  print "Best so far $population[0] with fitness $fitness_of{$population[0]} and evaluated $evaluations\n";	 
} while  ($fitness_of{$population[0]} != $bits );



__END__

=head1 NAME

p-peaks - A simple evolutionary algorithm that optimizes P_Peaks


=head1 VERSION

This document describes simple-EA.pl version 0.0.3


=head1 SYNOPSIS

    % chmod +x simple-EA.pl
    % simple-EA.pl [Run with default values]
    % simple-EA.pl 64 128 200 [Run with 64 chromosomes, population 128 for 200 generations]

=head1 DESCRIPTION

Run a simple evolutionary algorithm using functions in the
module. Intended mainly for teaching and modification, not for
production. 


