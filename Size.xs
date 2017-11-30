#define PERL_NO_GET_CONTEXT

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stddef.h>
#include <stdio.h>

#include "jpeglib.h"

typedef struct sizer *Image__JPEG__Size;
struct sizer {
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
};

MODULE = Image::JPEG::Size              PACKAGE = Image::JPEG::Size

PROTOTYPES: DISABLE

Image::JPEG::Size
_new(package, options)
    char *package
    SV *options
    INIT:
        HV *opthv;
        SV *optsv;
        struct sizer *self;
    CODE:
        if (!options || !SvROK(options)
            || SvTYPE( (optsv = SvRV(options)) ) != SVt_PVHV) {
            croak("Options must be a hash ref");
        }

        opthv = (HV *) optsv;

        Newxc(self, 1, struct sizer, struct sizer);

        /* XXX: Nope, need to die (and abort cinfo) on error */
        self->cinfo.err = jpeg_std_error(&self->jerr);
        jpeg_create_decompress(&self->cinfo);

        RETVAL = self;
    OUTPUT:
        RETVAL

void
_destroy(self)
    Image::JPEG::Size self
    CODE:
        jpeg_destroy_decompress(&self->cinfo);
        Safefree(self);

void
file_dimensions(self, filename)
    Image::JPEG::Size self
    char *filename
    INIT:
        FILE *f;
        JDIMENSION width, height;
    PPCODE:
        f = fopen(filename, "rb");
        if (!f) {
            croak("Can't open %s: %s", filename, strerror(errno));
        }

        jpeg_stdio_src(&self->cinfo, f);

        jpeg_read_header(&self->cinfo, 1);
        width = self->cinfo.image_width;
        height = self->cinfo.image_height;

        fclose(f);
        jpeg_abort_decompress(&self->cinfo);

        EXTEND(SP, 2);
        mPUSHu(width);
        mPUSHu(height);
