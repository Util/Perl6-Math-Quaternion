use v6;

class Math::Quaternion does Numeric;

has Numeric $.r; # Real portion
has Numeric $.i; # First  complex part
has Numeric $.j; # Second complex part
has Numeric $.k; # Third  complex part

# Constructors: .new, .unit

multi method new ( ) {
    Math::Quaternion.bless(*, :r(0), :i(0), :j(0), :k(0));
}
multi method new ( Real $r ) {
    Math::Quaternion.bless(*, :$r, :i(0), :j(0), :k(0));
}
multi method new ( Real $r, Real $i, Real $j, Real $k ) {
    Math::Quaternion.bless(*, :$r, :$i, :$j, :$k);
}

method unit ( ) {
    self.bless: *, :r(1), :i(0), :j(0), :k(0);
}

# Utility methods:

method Str (Math::Quaternion:D:) {
    "$.r + {$.i}i + {$.j}j + {$.k}k";
}

method reals ( ) { ( $.r, $.i, $.j, $.k ) } # All 4 components, each as a Real

# Math methods:

method norm ( ) { sqrt [+] self.reals X** 2 }

# Conjugate
method conj ( ) {
    self.new: $.r, -$.i, -$.j, -$.k;
}

# Math operators:

multi sub  infix:<eqv> ( Math::Quaternion $a, Math::Quaternion $b ) is export { [and] $a.reals Z== $b.reals }
multi sub  infix:<+>   ( Math::Quaternion $a,             Real $b ) is export { $a.new: $b+$a.r, $a.i, $a.j, $a.k }
multi sub  infix:<+>   (             Real $b, Math::Quaternion $a ) is export { $a.new: $b+$a.r, $a.i, $a.j, $a.k }
multi sub  infix:<+>   ( Math::Quaternion $a, Math::Quaternion $b ) is export { $a.new: |( $a.reals Z+ $b.reals ) }
multi sub  infix:<->   ( Math::Quaternion $a,             Real $b ) is export { $a.new: $a.r-$b, $a.i, $a.j, $a.k }
multi sub  infix:<->   (             Real $b, Math::Quaternion $a ) is export { $a.new: $b-$a.r,-$a.i,-$a.j,-$a.k }
multi sub  infix:<->   ( Math::Quaternion $a, Math::Quaternion $b ) is export { $a.new: |( $a.reals Z- $b.reals ) }
multi sub prefix:<->   ( Math::Quaternion $a                      ) is export { $a.new: |( $a.reals X* -1 ) }
multi sub  infix:<*>   ( Math::Quaternion $a,             Real $b ) is export { $a.new: |( $a.reals X* $b ) }
multi sub  infix:<*>   (             Real $b, Math::Quaternion $a ) is export { $a.new: |( $a.reals X* $b ) }
multi sub  infix:<*>   ( Math::Quaternion $a, Math::Quaternion $b ) is export {
    my @a_rijk            = $a.reals;
    my ( $r, $i, $j, $k ) = $b.reals;
    return $a.new: ( [+] @a_rijk Z* $r, -$i, -$j, -$k ), # real
                   ( [+] @a_rijk Z* $i,  $r,  $k, -$j ), # i
                   ( [+] @a_rijk Z* $j, -$k,  $r,  $i ), # j
                   ( [+] @a_rijk Z* $k,  $j, -$i,  $r ); # k
}

# vim: ft=perl6
