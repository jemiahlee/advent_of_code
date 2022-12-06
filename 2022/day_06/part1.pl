#!/usr/bin/env perl

use warnings;
use strict;

while(<>) {
    chomp;

    m/(\w)(?!\1)(\w)(?!\1|\2)(\w)(?!\1|\2|\3)\w/;
    print "$&: $+[0]\n";
}
