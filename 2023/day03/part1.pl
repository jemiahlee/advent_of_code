#!/usr/bin/env perl

use warnings;
use strict;

my @input;
while(<>) {
    chomp;
    push @input, '.' . $_ . '.';
}

my $line_length = length($input[0]);
my $input = join '', @input;
my %structure;

my $sum = 0;
$input =~ s/(?<=[^.\d])(\d+)/$sum += $1; '.' x length($1)/ge;
$input =~ s/(\d+)(?=[^.\d])/$sum += $1; '.' x length($1)/ge;

print "After initial scan of input, sum is $sum\n";
print "$input\n";

while($input =~ /(\d+)/g) {
    my $start = $-[0] > 0 ? $-[0]-1 : $-[0];
    my $end = $+[0] < $line_length ? $+[0]+1 : $+[0];
    for(my $i = $start; $i <= $end; $i++) {
        push @{$structure{$i}}, {number => $1, range => [$start..$end]};
    }
}

while($input =~ m/[^\d.]/g) {
    my $index = $-[0];

    if($structure{$index-$line_length}) {
        $sum += retrieve_and_remove_from_structure($index-$line_length);
    }

    if($structure{$index+$line_length}) {
        $sum += retrieve_and_remove_from_structure($index+$line_length);
    }
}

print "$sum\n";

sub retrieve_and_remove_from_structure {
    my $index = shift;

    my $value = 0;

    print "\$index of symbol is $index\n";
    my @indexes_to_delete;

    foreach my $hash (@{$structure{$index}}) {
        print 'Adding ', $hash->{number}, "\n";
        $value += $hash->{number};
        foreach my $i ($hash->{range}) {
            push @indexes_to_delete, $i;
        }
    }

    foreach my $i (@indexes_to_delete) {
        delete $structure{$i};
    }

    print "Returning $value\n";
    return $value;
}
