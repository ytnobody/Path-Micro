use strict;
use warnings;
use Test::More;
use Path::Micro;

my $path = Path::Micro->new('.');
isa_ok $path, 'Path::Micro';

done_testing;
