use v6;

class Math::Quaternion does Numeric;

has Numeric $.r; # Real portion
has Numeric $.i; # First  complex part
has Numeric $.j; # Second complex part
has Numeric $.k; # Third  complex part

# Constructors: .new, .unit

multi method new ( ) {
    self.bless(*, :r(0), :i(0), :j(0), :k(0));
}
multi method new ( Real $r ) {
    self.bless(*, :$r, :i(0), :j(0), :k(0));
}
multi method new ( Real $r, Real $i, Real $j, Real $k ) {
    self.bless(*, :$r, :$i, :$j, :$k);
}

method unit ( ) {
    self.bless: *, :r(1), :i(0), :j(0), :k(0);
}

# Utility methods:

method Str (::?CLASS:D:) {
    "$.r + {$.i}i + {$.j}j + {$.k}k";
}

method reals ( ) { ( $.r, $.i, $.j, $.k ) } # All 4 components, each as a Real
method v     ( ) { (      $.i, $.j, $.k ) } # Like .reals, but omitting .r

# Property methods:

method is_real ( ) { 
    [and] self.v »==» 0;
}


# Math methods:

method norm ( ) { sqrt [+] self.reals »**» 2 }

# Conjugate
method conj ( ) {
    self.new: $.r, -$.i, -$.j, -$.k;
}

# Dot product
method dot ( $a : ::?CLASS $b ) {
    return [+] $a.reals »*« $b.reals;
}

# Cross product
method cross ( $a : ::?CLASS $b ) {
    my @a_rijk            = $a.reals;
    my ( $r, $i, $j, $k ) = $b.reals;
    return $a.new: ( [+] @a_rijk »*« ( $r, -$i, -$j, -$k ) ), # real
                   ( [+] @a_rijk »*« ( $i,  $r,  $k, -$j ) ), # i
                   ( [+] @a_rijk »*« ( $j, -$k,  $r,  $i ) ), # j
                   ( [+] @a_rijk »*« ( $k,  $j, -$i,  $r ) ); # k
}

# Math operators:

multi sub  infix:<eqv> ( ::?CLASS $a, ::?CLASS $b ) is export { [and] $a.reals »==« $b.reals }
multi sub  infix:<+>   ( ::?CLASS $a,     Real $b ) is export { $a.new: $b+$a.r, $a.i, $a.j, $a.k }
multi sub  infix:<+>   (     Real $b, ::?CLASS $a ) is export { $a.new: $b+$a.r, $a.i, $a.j, $a.k }
multi sub  infix:<+>   ( ::?CLASS $a, ::?CLASS $b ) is export { $a.new: |( $a.reals »+« $b.reals ) }
multi sub  infix:<->   ( ::?CLASS $a,     Real $b ) is export { $a.new: $a.r-$b, $a.i, $a.j, $a.k }
multi sub  infix:<->   (     Real $b, ::?CLASS $a ) is export { $a.new: $b-$a.r,-$a.i,-$a.j,-$a.k }
multi sub  infix:<->   ( ::?CLASS $a, ::?CLASS $b ) is export { $a.new: |( $a.reals »-« $b.reals ) }
multi sub prefix:<->   ( ::?CLASS $a              ) is export { $a.new: |( $a.reals »*» -1 ) }
multi sub  infix:<*>   ( ::?CLASS $a,     Real $b ) is export { $a.new: |( $a.reals »*» $b ) }
multi sub  infix:<*>   (     Real $b, ::?CLASS $a ) is export { $a.new: |( $a.reals »*» $b ) }
multi sub  infix:<*>   ( ::?CLASS $a, ::?CLASS $b ) is export { $a.cross($b) }
multi sub  infix:<⋅>   ( ::?CLASS $a, ::?CLASS $b ) is export { $a.dot($b) }

# vim: ft=perl6
