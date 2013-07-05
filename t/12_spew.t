use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Basename ();
use File::Spec;

my $dir = Path::Micro->tmpdir;
my $file = File::Spec->catfile($dir, qw/foo.txt/);
my $data = do { local $/; <DATA> };

my $path1 = Path::Micro->new($dir, qw/foo.txt/);

subtest 'relative path spew' => sub {
    $path1->spew($data);
    is($path1->slurp, $data, 'relative path spew');
};

subtest 'absolute path spew' => sub {
    my $path2 = $path1->abs;
    $path2->spew($data);
    is($path2->slurp, $data, 'absolute path spew');
};

done_testing;
__DATA__
foo
bar
baz
