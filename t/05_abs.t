use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Spec;

my $curdir = Path::Micro->curdir;
my $file = File::Spec->catfile($curdir, qw/t 01_new.t/);
my $path1 = Path::Micro->new($curdir, qw/t 01_new.t/);

subtest 'absolute path' => sub {
    my $path2 = $path1->abs;
    isa_ok $path2, 'Path::Micro';
    is_deeply [$path2->path], [Path::Micro::_splat(File::Spec->rel2abs($file))], 'cwd abs';
};

done_testing;
