package Path::Micro;
use 5.008005;
use strict;
use warnings;
use File::Spec;
use File::Basename ();
use Carp;
use Guard;

our $VERSION = "0.01";
our $SPLITTER = $^O eq 'MSWin32' ? qr/\\/ : qr/\//;
our $AUTOLOAD;

sub AUTOLOAD {
    my $class = __PACKAGE__;
    local ($AUTOLOAD) = $AUTOLOAD =~ /^$class\:\:(.*)$/;
    return if $AUTOLOAD =~ /^(import|[A-Z]+)$/;
    croak "undefined method $AUTOLOAD" unless File::Spec->can($AUTOLOAD);
    File::Spec->$AUTOLOAD(@_);
}

sub new {
    my ($class, @path) = @_;
    bless +{path => \@path}, $class;
}

sub _splat {
    my $path = shift;
    split($SPLITTER, $path);
}

sub path {
    my ($self, @relpath) = @_;
    return (@{$self->{path}}, @relpath);
}

sub rel {
    my ($self, @relpath) = @_;
    return __PACKAGE__->new($self->path(@relpath));
}

sub abs {
    my $self = shift;
    return __PACKAGE__->new(_splat(File::Spec->rel2abs($self->as_string)));
}

sub as_string {
    my $self = shift;
    if ( -f (my $path = File::Spec->catfile($self->path)) ) {
        return $path;
    }
    else {
        return File::Spec->catdir($self->path);
    }
}

sub basename {
    my $self = shift;
    File::Basename::basename($self->as_string);
}

sub dirname {
    my ($self, @relpath) = @_;
    File::Spec->catdir(File::Basename::dirname($self->as_string), @relpath);
}

sub slurp {
    my $self = shift;
    open my $fh, '<', $self->as_string or croak $!;
    my $guard = guard { close $fh if defined $fh };
    do { local $/; (<$fh>) };
}

sub _spew {
    my ($self, $mode, $data) = @_;
    open my $fh, $mode, $self->as_string or croak $!;
    my $guard = guard { close $fh if defined $fh };
    print $fh $data;
}

sub spew {
    my ($self, $data) = @_;
    $self->_spew('>', $data);
}

sub append {
    my ($self, $data) = @_;
    $self->_spew('>>', $data);
}


1;
__END__

=encoding utf-8

=head1 NAME

Path::Micro - Micro sized path manipulator (File::Spec plus alpha)

=head1 SYNOPSIS

    use Path::Micro;
    my $path = Path::Micro->new(qw/path to file.txt/);
    
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
    
=head1 DESCRIPTION

Path::Micro is a Micro sized path manipulator.

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

