package Image::JPEG::Size;

use strict;
use warnings;

our $VERSION = '0.01';

use Exporter qw(import);
our @EXPORT_OK = qw(jpeg_file_dimensions jpeg_file_dimensions_hash);

use Carp qw(croak);
use XSLoader;

XSLoader::load(__PACKAGE__, $VERSION);

sub jpeg_file_dimensions_hash {
    my ($w, $h) = jpeg_file_dimensions(@_);
    return width => $w, height => $h;
}

1;
__END__

=pod

=encoding utf-8

=head1 NAME

Image::JPEG::Size - find the size of JPEG images

=head1 SYNOPSIS

    use Image::JPEG::Size qw(jpeg_file_dimensions);

    my ($width, $height) = jpeg_file_dimensions($filename);

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
