#!/usr/bin/env perl

use strict;
use warnings;

use lib qw( ../lib lib );

use version; our $VERSION = qv('0.0.3');
use Algorithm::Evolutionary::Simple qw( random_chromosome crossover);
use Time::HiRes qw( gettimeofday tv_interval );
use v5.14;

my $length = 16;
my $iterations = 100000;
my $top_length = 2**15;
do {
    say "perlsimple-BitString, $length, ".time_crossover( $iterations );
    $length *= 2;
} while $length <= $top_length;

#--------------------------------------------------------------------
sub time_crossover {
    my $number = shift;
    my $inicioTiempo = [gettimeofday()];
    my $indi = random_chromosome($length);
    my $another_indi = random_chromosome($length);
    for (1..$number) {
      ($indi,$another_indi) = crossover( $indi,$another_indi );
    }
    return tv_interval( $inicioTiempo ) 
}

__END__

=head1 NAME

xover.pl - A simple benchmark for crossover in Perl


=head1 VERSION

This is xover.


=head1 SYNOPSIS

    % chmod +x xover.pl
    % xover.pl

=head1 DESCRIPTION

A simple benchmark for the crossover function of an evolutionary algorithm.


