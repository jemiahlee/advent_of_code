#!/usr/bin/env perl

use warnings;
use strict;

my @cards = qw/A K Q J T 9 8 7 6 5 4 3 2/;
my %card_rank = (
    2  => 0,
    3  => 1,
    4  => 2,
    5  => 3,
    6  => 4,
    7  => 5,
    8  => 6,
    9  => 7,
    T  => 8,
    J  => 9,
    Q  => 10,
    K  => 11,
    A  => 12,
);

my %hand_rank = (
    'high_card'  => 0,
    'one_pair'   => 1,
    'two_pair'   => 2,
    'three_kind' => 3,
    'full_house' => 4,
    'four_kind'  => 5,
    'five_kind'  => 6,
);

my %hands;
while (<>) {
    die unless m{(\w+)\s*(\d+)};
    my($hand, $bid) = ($1, $2);

    $hands{$hand} = {bid => $bid};
}

foreach my $hand (keys %hands) {
    $hands{$hand}{rank} = rank_hand($hand);
}

my $sum = 0;
my @sorted_hands = sort hand_sort keys(%hands);

for(my $i = 0; $i < scalar(@sorted_hands); $i++) {
    my $score = $hands{$sorted_hands[$i]}{bid} * ($i+1);
    $sum += $score;
}

print "Total score: $sum\n";


### END OF MAIN ###

sub sort_tie {
    my @a = split //, $a;
    my @b = split //, $b;

    foreach my $i (0..$#a) {
        my $order = $card_rank{$a[$i]} <=> $card_rank{$b[$i]};

        if($order != 0) {
            return $order;
        }
    }

    die "This shouldn't be possible";
}

sub rank_hand {
    my($hand) = @_;

    my %letter_count;
    foreach my $letter (split //, $hand) {
        $letter_count{$letter}++;
    }

    if(scalar(keys(%letter_count)) == 1) {
        return 'five_kind';
    }
    if(scalar(keys(%letter_count)) == 2) {
        my $key = (keys(%letter_count))[0];
        if($letter_count{$key} == 4 or $letter_count{$key} == 1) {
            return 'four_kind';
        }
        return 'full_house';
    }
    if(keys %letter_count == 3) {
        my($key1, $key2, $key3) = keys(%letter_count);
        if($letter_count{$key1} == 3 or $letter_count{$key2} == 3 or $letter_count{$key3} == 3) {
            return 'three_kind';
        }
        return 'two_pair';
    }
    if(keys %letter_count == 4) {
        return 'one_pair';
    }

    return 'high_card';
}

sub hand_sort {
    my $order = $hand_rank{$hands{$a}{rank}} <=> $hand_rank{$hands{$b}{rank}};

    if($order != 0) {
        return $order;
    }

    return sort_tie $a, $b;
}
