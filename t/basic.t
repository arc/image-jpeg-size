#! perl

use strict;
use warnings;

use Test::More;

use Image::JPEG::Size;

my $jpeg_sizer = Image::JPEG::Size->new;
my $file = "t/data/cc0_320_213.jpg";

is_deeply([$jpeg_sizer->file_dimensions($file)], [320, 213],
          'correct dimensions for sample image');

done_testing();
