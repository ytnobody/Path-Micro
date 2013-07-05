use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Basename ();
use File::Spec;

my $curdir = Path::Micro->curdir;
my $file = File::Spec->catfile($curdir, qw/t 01_new.t/);
my $path1 = Path::Micro->new($curdir, qw/t 01_new.t/);

subtest 'relative path dirname' => sub {
    is($path1->dirname, File::Basename::dirname($file), '01_new.t dirname');
};

subtest 'absolute path dirname' => sub {
    my $path2 = $path1->abs;
    is($path2->dirname, File::Basename::dirname(File::Spec->rel2abs($file)), '01_new.t absolute dirname');
};

done_testing;
