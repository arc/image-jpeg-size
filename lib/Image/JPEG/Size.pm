package Image::JPEG::Size;

use strict;
use warnings;

our $VERSION = '0.01';

use Carp qw(croak);
use XSLoader;

XSLoader::load(__PACKAGE__, $VERSION);

sub new {
    my $class = shift;
    my %args = @_ == 1 && ref($_[0]) eq 'HASH' ? %{ $_[0] }
             : @_ % 2 == 0 ? @_
             :    croak("$class\->new takes a hash list or hash ref");
    return $class->_new(\%args);
}

sub DESTROY { $_[0]->_destroy }

sub file_dimensions_hash {
    my ($w, $h) = shift->file_dimensions(@_);
    return width => $w, height => $h;
}

1;
__END__

=pod

=encoding utf-8

=head1 NAME

Image::JPEG::Size - find the size of JPEG images

=head1 SYNOPSIS

    use Image::JPEG::Size;

    my $jpeg_sizer = Image::JPEG::Size->new;
    my ($width, $height) = $jpeg_sizer->file_dimensions($filename);

=head1 AUTHOR

Aaron Crane, E<lt>arc@cpan.orgE<gt>

The initial development of this module was sponsored by Science Photo Library
L<https://www.sciencephoto.com/>.

=head1 COPYRIGHT

Copyright 2017 Aaron Crane.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself. See L<http://dev.perl.org/licenses/>.

=cut
