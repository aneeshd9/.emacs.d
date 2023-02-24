(require 'adc-company)

(use-package cape
  :after company
  :hook
  (lsp-completion-mode . adc-cape-capf-lsp-mode-setup)

  :preface
  (defalias 'adc-yasnippet-capf
    (cape-company-to-capf 'company-yasnippet))

  (defun adc-cape-capf-lsp-mode-setup ()
    (adc-cape-capf-add-hooks t))

  (defun adc-cape-capf-add-hooks (&optional local)
    (if local (make-local-variable 'completion-at-point-functions))
    (adc-prepend completion-at-point-functions 'cape-file)
    (adc-prepend completion-at-point-functions 'adc-yasnippet-capf))

  (defun adc-cape-capf-remove-hooks (&optional local)
    (remove-hook 'completion-at-point-functions 'adc-yasnippet-capf local)
    (remove-hook 'completion-at-point-functions 'capf-file local))

  :init
  (adc-cape-capf-add-hooks))

(provide 'adc-cape)
