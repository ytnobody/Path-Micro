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

sub cwd {
    File::Spec->curdir;
}

sub rel {
    my ($self, @relpath) = @_;
    return __PACKAGE__->new($self->path(@relpath));
}

sub abs {
    my $self = shift;
    return __PACKAGE__->new(_splat(File::Spec->rel2abs($self->path)));
}

sub as_string {
    my $self = shift;
    if ( -d (my $path = File::Spec->catdir($self->path)) ) {
        return $path;
    }
    else {
        return File::Spec->catfile($self->path);
    }
}

sub basename {
    my $self = shift;
    File::Basename::basename($self->path);
}

sub dir {
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

Path::Micro - It's new $module

=head1 SYNOPSIS

    use Path::Micro;

=head1 DESCRIPTION

Path::Micro is ...

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

