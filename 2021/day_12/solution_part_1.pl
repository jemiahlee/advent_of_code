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

    $path .= $node eq 'start' ? $node : ",$node";
    $paths{$path}++ if $path ne 'start';

    if($node eq 'end'){
        return;
    }

    for my $next_cave (@{$graph{$node}}){
        next if($next_cave =~ /^[a-z]+$/ and $path =~ /\b$next_cave\b/);

        search($next_cave, $path);
    }
}
