#!/usr/bin/env perl

use warnings;
use strict;

my %tail_positions;

my %head = (x => 0, y => 0);
my %tail = (x => 0, y => 0);

mark_tail();

while(<>) {
    print;
    chomp;

    m{([RULD]) (\d+)};
    move_head($1, $2);
}

print "Total positions visited: ", scalar(keys(%tail_positions)), "\n";

my %sub_map = (
    R => \&move_head_right,
    L => \&move_head_left,
    U => \&move_head_up,
    D => \&move_head_down,
);

sub move_head {
    my($direction, $amount) = @_;

    for (1..$amount) {
        if($direction eq 'R'){
            move_head_right();
        }
        elsif($direction eq 'L'){
            move_head_left();
        }
        elsif($direction eq 'U'){
            move_head_up();
        }
        elsif($direction eq 'D'){
            move_head_down();
        }

        move_tail();
    }
}

sub move_head_right {
    $head{x}++;
}

sub move_head_left {
    $head{x}--;
}

sub move_head_up {
#return if $head{y} == 1;
    $head{y}--;
}

sub move_head_down {
    $head{y}++;
}

sub move_tail {

    return if $tail{x} == $head{x} and $tail{y} == $head{y};
    return if abs($tail{x} - $head{x}) == 1 and abs($tail{y} - $head{y}) == 1;
    return if abs($tail{x} - $head{x}) == 1 and $tail{y} == $head{y};
    return if $tail{x} == $head{x} and abs($tail{y} - $head{y}) == 1;

    if($tail{x} == $head{x}) {
        $tail{y}++ if $tail{y} < $head{y};
        $tail{y}-- if $tail{y} > $head{y};
    }
    elsif($tail{y} == $head{y}) {
        $tail{x}++ if $tail{x} < $head{x};
        $tail{x}-- if $tail{x} > $head{x};
    }
    elsif($tail{y} < $head{y}) {
        $tail{y}++;

        $tail{x}++ if $tail{x} < $head{x};
        $tail{x}-- if $tail{x} > $head{x};
    }
    elsif($tail{y} > $head{y}) {
        $tail{y}--;

        $tail{x}++ if $tail{x} < $head{x};
        $tail{x}-- if $tail{x} > $head{x};
    }

    mark_tail();
}

sub mark_tail {
    my($x, $y) = ($tail{x}, $tail{y});
    $tail_positions{"$x $y"} = 1;
}
