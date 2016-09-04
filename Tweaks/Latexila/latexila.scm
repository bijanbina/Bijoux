(define (change-symbol-color filename)
     (let* ((image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))
           (drawable (car (gimp-image-get-active-layer image))))
;     (plug-in-gauss-iir RUN-NONINTERACTIVE
;                       image drawable radius hvalue vvalue)
     (gimp-invert drawable)
     (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)
     (gimp-image-delete image))
     )
     
     
     
     
