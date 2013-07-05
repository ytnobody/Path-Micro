use strict;
use warnings;
use Test::More;
use Path::Micro;

my $path = Path::Micro->new(qw/foo bar baz/);
is_deeply [$path->path], [qw/foo bar baz/], 'path = ("foo", "bar", "baz")';

done_testing;
