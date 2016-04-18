#!/usr/bin/perl
#
# rename script examples from lwall:
#       rename 's/\.orig$//' *.orig
#       rename 'y/A-Z/a-z/ unless /^Make/' *
#       rename '$_ .= ".bad"' *.f
#       rename 'print "$_: "; s/foo/bar/ if <stdin> =~ /^y/i' *
#       rename($was,$_) unless $was eq $_;

$op = shift;
for (@ARGV) {
    $was = $_;
    eval $op;
    die $@ if $@;
    rename($was,$_) unless $was eq $_;                                                             }
