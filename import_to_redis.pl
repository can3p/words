#!/usr/bin/env perl

use strict;
use warnings;

use Redis;

my $fname = shift;
my $redis = Redis->new;
my $counter = 0;

open(my $fh, "<", $fname) or die "cannot open < input.txt: $!";

while (my $line = <$fh>) {
    $counter++;
    for (split /,/, $line) {
        $redis->sadd("/wgroup_$counter", $_, sub {});
    }
}

$redis->wait_all_responses;
