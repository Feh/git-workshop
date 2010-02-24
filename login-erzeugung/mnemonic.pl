#!/usr/bin/perl
# generate mnemonic passwords

use strict;
use warnings;

my @vow = qw(a e i o u);
my @con = qw(b c d f g h j k l m n p r s t v w z);

my $c = 5;
print $con[int(rand(18))] . $vow[int(rand(5))] while($c--);
