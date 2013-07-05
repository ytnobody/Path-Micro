use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Spec;

my $curdir = Path::Micro->cwd;
my $path1 = Path::Micro->new($curdir);
my $path2 = $path1->abs;
isa_ok $path2, 'Path::Micro';
is_deeply [$path2->path], [Path::Micro::_splat(File::Spec->rel2abs($curdir))], 'cwd abs';

done_testing;
