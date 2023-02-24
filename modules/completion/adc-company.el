(use-package company
  :general
  ("TAB" 'company-indent-or-complete-common)
  (:keymaps 'company-active-map
            "C-n" 'company-select-next
            "C-p" 'company-select-previous
            "<tab>" 'company-complete-selection)

  :custom
  (company-begin-commands '(self-insert-command))
  (company-dabbrev-downcase nil)
  (company-echo-delay 0.01)
  (company-idle-delay 0.2)
  (company-minumum-prefix-length 2)
  (company-tooltip-limit 20)
  (company-tooltip-flip-when-above t)

  :hook
  (lsp-completion-mode . adc-company-lsp-mode-setup)

  :preface
  (defun adc-company-lsp-mode-setup ()
    (setq-local company-backends '(company-capf)))

  :config
  (global-company-mode 1))

(use-package company-box
  :if window-system
  :hook (company-mode . company-box-mode))

(use-package company-yasnippet
  :straight company

  :preface
  (defgroup adc-company-yasnippet nil
    "Adc specific tweaks to company-yasnippet."
    :group 'company)

  (defcustom adc-company-yasnippet-exact-match-only nil
    "Only match completion when it is a exact match for a snippet key."
    :type 'boolean
    :group 'adc-company-yasnippet)

  :custom
  (adc-company-yasnippet-exact-match-only t))

(provide 'adc-company)
