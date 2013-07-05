use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Spec;

my $curdir = Path::Micro->cwd;
my $path1 = Path::Micro->new($curdir, qw/t 01_new.t/);
my $path2 = $path1->abs;
isa_ok $path1, 'Path::Micro';
is $path1->as_string, File::Spec->catfile($curdir, qw/t 01_new.t/), '01_new.t as string';
is $path2->as_string, File::Spec->rel2abs($curdir, qw/t 01_new.t/), '01_new.t absolute path as string';

done_testing;
