;;; adc-consult-lsp.el --- Aneesh's Emacs Config: consult-lsp configuration.

;;; Commentary:

;; Basic configuration for consult-lsp.

;;; Code:

(require 'adc-consult)
(require 'adc-lsp)

(use-package consult-lsp
  :general
  ("C-c C-\\" 'consult-lsp-diagnostics))

(provide 'adc-consult-lsp)
;;; adc-consult-lsp.el ends here.
