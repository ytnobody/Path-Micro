# NAME

Path::Micro - Micro sized path manipulator (File::Spec plus alpha)

# SYNOPSIS

    use Path::Micro;
    my $path = Path::Micro->new(qw/path to file.txt/);
    

    # or 
    # my $path = path_to(qw/path to file.txt/);
    

    my $path_str = $path->as_string;                   # path/to/file.txt
    my $dirname  = $path->dirname;                     # path/to
    my $basename = $path->basename;                    # file.txt
    my $updir    = $path->dir(qw/.. foo/)->as_string;  # path/to/../foo
    $path->spew('foo');
    my $data     = $path->slurp;                       # foo
    $path->append('bar');
    $data        = $path->slurp;                       # foobar

    # Some features from File::Spec
    my $tmp      = Path::Micro->tmpdir;                # /tmp
    

# DESCRIPTION

Path::Micro is a Micro sized path manipulator.

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
