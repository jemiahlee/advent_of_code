#!/usr/bin/env perl

use warnings;
use strict;

my %graph;
my %paths;

while(<>){
    chomp;
    my($start, $finish) = split /-/;

    unless(defined($graph{$start})){
        $graph{$start} = [];
    }

    unless(defined($graph{$finish})){
        $graph{$finish} = [];
    }

    push(@{$graph{$start}}, $finish);
    push(@{$graph{$finish}}, $start);
}

# foreach my $start_cave (sort keys %graph){
#     print "$start_cave -> [", join(',', @{$graph{$start_cave}}), "]\n";
# }

find_path_count();
my(@valid_paths) = sort {length($a) <=> length($b)} grep {/end/} keys %paths;
print join("\n", @valid_paths), "\n";

sub find_path_count {
    search('start', '');
}

sub search {
    my($node, $path) = @_;

    $path .= $path ? ",$node" : $node;
    $paths{$path}++ if $node ne 'start';
    # print "looking at $path\n";

    if($node eq 'end'){
        return;
    }

    for my $next_cave (@{$graph{$node}}){
        next unless valid_next_move($path, $next_cave);

        search($next_cave, $path);
    }
}

sub valid_next_move {
    my($path, $next_cave) = @_;

    return 0 if $next_cave eq 'start';  # start can only be visited once
    return 1 if $next_cave =~ /^[A-Z]+$/;

    if($path =~ /\b$next_cave\b/ and $path =~ /\b([a-z]+)\b.*\b\1\b/){
        return 0;
    }

    return 1;
}
