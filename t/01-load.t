use v6;
use Test;
plan *;
BEGIN { @*INC.push: <lib> };
use Math::Quaternion;

isa_ok Math::Quaternion.new(), Math::Quaternion;

done;
# vim: ft=perl6
