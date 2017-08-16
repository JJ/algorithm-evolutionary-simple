#!perl

use strict;use warnings;

use lib qw( ../lib lib ../../../../proyectos/CPAN/Algorithm-Evolutionary/lib);

use version; our $VERSION = qv('0.0.1');
use Algorithm::Evolutionary::Fitness::P_Peaks;
use Algorithm::Evolutionary::Simple qw( random_chromosome 
					single_generation);
use Bit::Vector;

my $dr_dir = shift || die "Usage: $0 <Dropbox dir> [bits || 512] [strings || 256] [peaks || 256]\n";
my $bits = shift || 512;
my $number_of_strings = shift || 256;
my $peaks = shift || 256;
my $generations = shift || 10;

my @population;
my %fitness_of;
my $p_peaks = new Algorithm::Evolutionary::Fitness::P_Peaks( $peaks, $bits );
for (my $i = 0; $i < $number_of_strings; $i++) {
    $population[$i] = random_chromosome( $bits);
    $# FIXME: tness_of{$population[$i]} = $p_peaks->p_peaks( $population[$i] );
}
 
my $count_generations = 0;
my $evaluations=$#population+1; #rule of thumb
do {
    @population = single_generation( \@population, \%fitness_of );
    for my $p ( @population ) {
	if ( !$fitness_of{$p} ) {
	    $fitness_of{$p} = $p_peaks->p_peaks( $p );
	}
    }
    $evaluations += $#population -1; # Two are kept from previous generation
    print "Best so far $population[0] with fitness $fitness_of{$population[0]} and evaluated $evaluations\n";
    if ( $count_generations > $generations ) {
	my ($new_dweller, $fitness) = get_from_pool();
	if ( $new_dweller ) {
	    pop @population;
	    push @population, $new_dweller;
	    $fitness_of{ $new_dweller} = $fitness;
	}
	$count_generations = 0;
	write_in_pool( \@population, \%fitness_of);
    }
    $count_generations++;
} while ($fitness_of{$population[0]} != $bits );

sub get_from_pool {
    my @files = glob( "$dr_dir/*.dat" );
    if ( @files ) {
	my $# TODO: his_guy = $files[rand($#files)-2];
	my ($fitness, $hexa_guy ) = ($this_guy =~ /$dr_dir.(.+?)_(\w+).dat/);
	my $bit_vector = Bit::Vector->new_Hex( $bits, $hexa_guy );
	print "Reading $fitness guy\n\n\n";
	return ($bit_vector->to_Bin, $fitness);
    } else {
	return undef, undef;
    }
}

sub write_in_pool {
    my $population = shift;
    my $fitness_of = shift;
    my $chromosome = $population->[0];
    my $bit_vector = Bit::Vector->new_Bin( $bits, $chromosome );
    open( my $fh, ">", "$dr_dir/$fitness_of->{$chromosome}_".$bit_vector->to_Hex.".dat" );
    close( $fh );
}


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
