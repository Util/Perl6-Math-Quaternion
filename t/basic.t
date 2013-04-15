use v6;
use Test;
plan *;
use Math::Quaternion;

{
    my $q;
    lives_ok { $q = Math::Quaternion.new },          'Bare Quat: .new';
    is $q.Str,  '0 + 0i + 0j + 0k',                  'Bare Quat: .Str';
    is $q.perl, 'Math::Quaternion.new(r => 0, i => 0, j => 0, k => 0)', 'Bare Quat: .perl';
}
{
    my $q;
    lives_ok { $q = Math::Quaternion.unit },         'Unit Quat: .new';
    is $q.Str,  '1 + 0i + 0j + 0k',                  'Unit Quat: .Str';
    is $q.perl, 'Math::Quaternion.new(r => 1, i => 0, j => 0, k => 0)', 'Unit Quat: .perl';
}
{
    my $q;
    lives_ok { $q = Math::Quaternion.new(3) },       'Real Quat: .new';
    is $q.Str, '3 + 0i + 0j + 0k',                   'Real Quat: .Str';
    is $q.perl, 'Math::Quaternion.new(r => 3, i => 0, j => 0, k => 0)', 'Real Quat: .perl';
}
{
    my $q;
    lives_ok { $q = Math::Quaternion.new(3,4,5,6) }, 'Full Quat: .new';
    is $q.Str, '3 + 4i + 5j + 6k',                   'Full Quat: .Str';
    is $q.perl, 'Math::Quaternion.new(r => 3, i => 4, j => 5, k => 6)', 'Full Quat: .perl';
}

done;
# vim: ft=perl6
