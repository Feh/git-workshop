#!/usr/bin/perl
# generate mnemonic passwords

use strict;
use warnings;

my @vow = qw(a e i o u);
my @con = qw(b c d f g h j k l m n p r s t v w z);

my $c = 5;

while($c > 0) {
    print $con[int(rand(18))];
    print $vow[int(rand(5))];
    $c--;
}
