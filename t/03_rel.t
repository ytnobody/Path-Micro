use strict;
use warnings;
use Test::More;
use Path::Micro;

my $path1 = Path::Micro->new(qw/foo bar baz/);
my $path2 = $path1->rel(qw/.. hoge/);
isa_ok $path2, 'Path::Micro';
is_deeply [$path2->path], [qw/foo bar baz .. hoge/], 'path = ("foo", "bar", "baz", "..", "hoge")';

done_testing;
