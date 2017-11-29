package Image::JPEG::Size;

our $VERSION = '0.01';

sub jpeg_file_dimensions_hash {
    my ($w, $h) = jpeg_file_dimensions(@_);
    return width => $w, height => $h;
}

__END__

=head1 NAME

Image::JPEG::Size - find the size of a JPEG image

=head1 SYNOPSIS

    use Image::JPEG::Size qw(jpeg_file_dimensions);

    my ($width, $height) = jpeg_file_dimensions($filename);
