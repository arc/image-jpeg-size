#! perl

use strict;
use warnings;

use Test::More;

use Image::JPEG::Size qw(jpeg_dimensions);

my $file = "t/data/cc0_320_213.jpg";

is_deeply([jpeg_dimensions(file => $file)], [320, 213],
          'correct dimensions for sample image');

done_testing();
