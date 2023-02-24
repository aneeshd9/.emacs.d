(defvar adc-vendor-dir (adc-dir "vendor")
  "Root directory for Emacs vendor.")
(adc-recursive-add-to-load-path adc-vendor-dir)

(provide 'adc-core-vendor)
