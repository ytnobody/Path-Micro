use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Basename ();
use File::Spec;

my $curdir = Path::Micro->curdir;
my $file = File::Spec->catfile($curdir, qw/t 01_new.t/);
my $path1 = Path::Micro->new($curdir, qw/t 01_new.t/);

subtest 'relative path basename' => sub {
    is($path1->basename, File::Basename::basename($file), '01_new.t basename');
};

subtest 'absolute path basename' => sub {
    my $path2 = $path1->abs;
    is($path2->basename, File::Basename::basename(File::Spec->rel2abs($file)), '01_new.t absolute path basename');
};

done_testing;
