use strict;
use warnings;
use Test::More;
use Path::Micro;
use File::Basename ();
use File::Spec;

my $dir = Path::Micro->tmpdir;
my $file = File::Spec->catfile($dir, qw/foo.txt/);
unlink $file if -f $file;
my $data = do { local $/; <DATA> };

my $path1 = Path::Micro->new($dir, qw/foo.txt/);

subtest 'relative path append' => sub {
    $path1->append($data);
    is($path1->slurp, $data, 'relative path append');
};

subtest 'absolute path append' => sub {
    my $path2 = $path1->abs;
    $path2->append($data);
    is($path2->slurp, $data.$data, 'absolute path append');
};

done_testing;
__DATA__
foo
bar
baz
