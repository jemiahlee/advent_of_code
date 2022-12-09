#!/usr/bin/env perl

use warnings;
use strict;

my %tail_positions;

my %head = (x => 0, y => 0);
my @tails = (
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
    {x => 0, y => 0},
);

mark_tail();

my %sub_map = (
    'R' => sub { $head{x}++ },
    'L' => sub { $head{x}-- },
    'U' => sub { $head{y}-- },
    'D' => sub { $head{y}++ },
);

while(<>) {
    print;
    chomp;

    m{([RULD]) (\d+)};
    move_head($1, $2);
}


print "Total positions visited: ", scalar(keys(%tail_positions)), "\n";

sub move_head {
    my($direction, $amount) = @_;

    for (1..$amount) {
        $sub_map{$direction}();

        for my $tail_number (0..8){
            move_tails($tail_number);
        }
    }
}

sub move_tails {
    my $tail_number = shift;

    my $current_tail = $tails[$tail_number];

    my $previous_tail;
    if($tail_number == 0){
        $previous_tail = {x => $head{x}, y => $head{y}};
    }
    else {
        $previous_tail = {x => $tails[$tail_number-1]{x}, y => $tails[$tail_number-1]{y}};
    }

    return if $current_tail->{x} == $previous_tail->{x} and $current_tail->{y} == $previous_tail->{y};
    return if abs($current_tail->{x} - $previous_tail->{x}) == 1 and abs($current_tail->{y} - $previous_tail->{y}) == 1;
    return if abs($current_tail->{x} - $previous_tail->{x}) == 1 and $current_tail->{y} == $previous_tail->{y};
    return if $current_tail->{x} == $previous_tail->{x} and abs($current_tail->{y} - $previous_tail->{y}) == 1;

    if($current_tail->{x} == $previous_tail->{x}) {
        $current_tail->{y}++ if $current_tail->{y} < $previous_tail->{y};
        $current_tail->{y}-- if $current_tail->{y} > $previous_tail->{y};
    }
    elsif($current_tail->{y} == $previous_tail->{y}) {
        $current_tail->{x}++ if $current_tail->{x} < $previous_tail->{x};
        $current_tail->{x}-- if $current_tail->{x} > $previous_tail->{x};
    }
    elsif($current_tail->{y} < $previous_tail->{y}) {
        $current_tail->{y}++;

        $current_tail->{x}++ if $current_tail->{x} < $previous_tail->{x};
        $current_tail->{x}-- if $current_tail->{x} > $previous_tail->{x};
    }
    elsif($current_tail->{y} > $previous_tail->{y}) {
        $current_tail->{y}--;

        $current_tail->{x}++ if $current_tail->{x} < $previous_tail->{x};
        $current_tail->{x}-- if $current_tail->{x} > $previous_tail->{x};
    }

    mark_tail();
}

sub mark_tail {
    my($x, $y) = ($tails[8]{x}, $tails[8]{y});
    $tail_positions{"$x $y"} = 1;
}
