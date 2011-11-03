use Test::More tests => 2;

use lib qw( ../lib lib );

use Algorithm::Evolutionary::Simple qw( random_chromosome );

my $length = 10;

my $this_chromosome = random_chromosome( $length);

is( length($this_chromosome), 10, "Ok length");
my $that_chromosome = random_chromosome( $length);
isnt( $this_chromosome, $that_chromosome, "Ok random");
