;this script used to change latexila/data/images files
;which is now do by a qt console program
(define (change-cmap-monocolor filename)
     (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
           (drawable (car (gimp-image-get-active-layer image))))
;     (plug-in-gauss-iir RUN-NONINTERACTIVE
;                       image drawable radius hvalue vvalue)
     (script-fu-set-cmap RUN-NONINTERACTIVE drawable "LoLo")
     (gimp-palette-get-info "LoLo")
     (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
     (gimp-image-delete image))
     )
