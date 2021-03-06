use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Spec;

my $curdir = Path::Micro->curdir;
my $file = File::Spec->catfile($curdir, qw/t 01_new.t/);

my $path1 = Path::Micro->new($curdir, qw/t 01_new.t/);

subtest 'relative path as string' => sub {
    is $path1->as_string, $file, '01_new.t as string';
};

subtest 'absplute path as string' => sub {
    my $path2 = $path1->abs;
    is $path2->as_string, File::Spec->rel2abs($file), '01_new.t absolute path as string';
};

done_testing;
