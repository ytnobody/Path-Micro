use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Basename ();
use File::Spec;

my $curdir = Path::Micro->curdir;
my $file = File::Spec->catfile($curdir, qw/t 01_new.t/);
open my $fh, '<', $file or die $!;
my $test = do{ local $/; (<$fh>) };
close $fh;

my $path1 = Path::Micro->new($curdir, qw/t 01_new.t/);

subtest 'relative path slurp' => sub {
    is($path1->slurp, $test, 'relative path slurp');
};

subtest 'absolute path slurp' => sub {
    my $path2 = $path1->abs;
    is($path2->slurp, $test, 'absolute path slurp');
};

done_testing;
