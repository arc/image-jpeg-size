#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stddef.h>
#include <stdio.h>

#include "jpeglib.h"

MODULE = Image::JPEG::Size              PACKAGE = Image::JPEG::Size

PROTOTYPES: DISABLE

void
_jpeg_file_dimensions(filename)
    char *filename
    INIT:
        struct jpeg_decompress_struct cinfo;
        struct jpeg_error_mgr jerr;
        FILE *f;
        JDIMENSION width, height;
    PPCODE:
        f = fopen(filename, "rb");
        if (!f) {
            croak("Can't open %s: %s", filename, strerror(errno));
        }

        /* XXX: Nope, need to die (and deallocate cinfo) on error */
        cinfo.err = jpeg_std_error(&jerr);
        jpeg_create_decompress(&cinfo);

        jpeg_stdio_src(&cinfo, f);

        jpeg_read_header(&cinfo, 1);
        width = cinfo.image_width;
        height = cinfo.image_height;

        fclose(f);
        jpeg_destroy_decompress(&cinfo);

        EXTEND(SP, 2);
        mPUSHu(width);
        mPUSHu(height);
