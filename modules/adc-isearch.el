;;; adc-isearch.el --- Aneesh's Emacs Config: isearch configuration.

;;; Commentary:

;; Basic configuration for isearch.

;;; Code:

(use-package isearch
  :straight (:type built-in)
  :custom
  (isearch-lazy-count t)
  (regexp-search-ring-max 200)
  (search-default-mode t)
  (search-ring-max 200))

(provide 'adc-isearch)
;;; adc-isearch.el ends here.
