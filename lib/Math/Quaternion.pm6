use v6;

class Math::Quaternion;

has Num $.r; # Real portion
has Num $.i; # First  complex part
has Num $.j; # Second complex part
has Num $.k; # Third  complex part

# Constructors: .new, .unit

multi method new ( ) {
    self.bless( *, :r(0), :i(0), :j(0), :k(0), );
}
multi method new ( Real $r ) {
    self.bless( *, :r($r), :i(0), :j(0), :k(0), );
}
multi method new ( Real $r, Real $i, Real $j, Real $k ) {
    self.bless( *, :$r, :$i, :$j, :$k );
}

method unit ( ) {
    self.bless( *, :r(1), :i(0), :j(0), :k(0), );
}

method Str ( ) {
    "$.r + {$.i}i + {$.j}j + {$.k}k";
}

method perl ( ) {
    self.WHAT.perl ~ ".new($.r, $.i, $.j, $.k)";
}


# vim: ft=perl6
