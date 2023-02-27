;;; adc-helm-lsp.el --- Aneesh's Emacs Config: helm-lsp configuration.

;;; Commentary:

;; Basic configuration for helm-lsp.

;;; Code:

(require 'adc-helm)
(require 'adc-lsp)

(use-package helm-lsp
  :after (helm-global-bindings)
  :general
  ("C-c '" 'helm-lsp-workspace-symbol)
  ("C-c C-'" 'helm-lsp-workspace-symbol)
  ("C-c \\" 'helm-lsp-diagnostics))

(provide 'adc-helm-lsp)
;;; adc-helm-lsp.el ends here.
