(defmacro adc-prepend (list-var element)
  "Add ELEMENT to the beginning of LIST-VAR, removing duplicates."
  `(setq ,list-var (cons ,element (remove ,element ,list-var))))

(defmacro adc-append (list-var element)
  "Add ELEMENT to the end of LIST-VAR, removing duplicates."
  `(setq ,list-var (append (remove ,element ,list-var) (list ,element))))

(provide 'adc-core-utils)
