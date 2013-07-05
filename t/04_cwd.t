use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Spec;

is(Path::Micro->cwd, File::Spec->curdir, 'Path::Micro->cwd eq File::Spec->curdir');
is(Path::Micro->new(qw/./)->cwd, File::Spec->curdir, '$obj->cwd eq File::Spec->curdir');

done_testing;
