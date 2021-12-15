#!/usr/bin/env perl

use warnings;
use strict;

my $NUMBER_OF_ITERATIONS = 1;
my $start_str = <>;
chomp $start_str;

my $polymer;
for(my $i = 0; $i < length($start_str)-1; $i++){
    $polymer->{substr($start_str, $i, 2)}++;
}


my %rules;

while(<>){
    chomp;

    next unless /([A-Z]{2})\s*->\s*([A-Z])/;

    my($from, $to) = ($1, $2);

    $rules{$from} = $to;
}

for(my $i = 1; $i <= $NUMBER_OF_ITERATIONS; $i++){
    my %new_polymer;

    for my $pair (keys %$polymer){
        my $first = substr($pair, 0, 1);
        my $second = substr($pair, 1, 1);

        my $insertion = $rules{"$first$second"};

        $new_polymer{"$first$insertion"}++;
        $new_polymer{"$insertion$second"}++;
    }

    $polymer = \%new_polymer;
    print_data();
    print "\n\n";
}

print "Answer: ", compute_answer(), "\n";

sub print_data {
    foreach my $pair (keys %$polymer){
        print "$pair: $polymer->{$pair}\n";
    }
}

sub compute_answer {
    my %counter;

    $counter{substr($start_str, 0, 1)}++;
    # $counter{substr($start_str, length($start_str)-1, 1)}++;

    foreach my $pair (keys %$polymer){
        my($first, $second) = split //, $pair;
        $counter{$first} += $polymer->{$pair};
        $counter{$second} += $polymer->{$pair};
    }

    my $most_frequent_key = (sort {$counter{$b} <=> $counter{$a}} keys %counter)[0];
    print "Most frequent: $most_frequent_key ($counter{$most_frequent_key})\n";

    my $least_frequent_key = (sort {$counter{$a} <=> $counter{$b}} keys %counter)[0];
    print "Least frequent: $least_frequent_key ($counter{$least_frequent_key})\n";

    return $counter{$most_frequent_key} - $counter{$least_frequent_key};
}
