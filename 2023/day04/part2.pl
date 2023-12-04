#!/usr/bin/env perl

use warnings;
use strict;

my %card_to_winning_numbers;

while(<>) {
    chomp;
    die unless /Card\s+(\d+):\s*((?:\d+\s*)+)\|\s*((?:\d+\s*)+)/;
    my($card_number, $winning_numbers, $our_numbers) = ($1, $2, $3);

    my @winning_numbers = split /\s+/, $winning_numbers;
    my $winning_number_count = 0;
    foreach my $winning_number (@winning_numbers) {
        $winning_number_count++ if $our_numbers =~ /\b$winning_number\b/;
    }

    $card_to_winning_numbers{$card_number} = $winning_number_count;
}

my %total_cards;
walk_and_add_cards();
print 'Total number of cards: ', count_all_cards(), "\n";

sub walk_and_add_cards {
    foreach my $index (sort {$a <=> $b} keys %card_to_winning_numbers) {
        $total_cards{$index}++; # to compensate for the start card
        my $cards_won = $card_to_winning_numbers{$index};
        print "Processing index $index of \%card_to_winning_numbers ($card_to_winning_numbers{$index})\n";
        foreach my $i ($index+1..$index+$cards_won) {
            print "total_cards{$i} += $total_cards{$index}\n";
            $total_cards{$i} += $total_cards{$index};
        }
    }
}

sub count_all_cards {
    my $count = 0;

    foreach my $index (sort {$a <=> $b} keys %total_cards) {
        print "Card $index: $total_cards{$index}\n";
        $count += $total_cards{$index};
    }

    return $count;
}
