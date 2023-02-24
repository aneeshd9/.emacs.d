;;; adc-dap.el --- Aneesh's Emacs Config: dap setup.

;;; Commentary:

;; Basic configuration for dap.

;;; Code:
(require 'adc-debug-map)
(require 'adc-hydra)

(use-package dap-mode
  :defer t

  :general
  (:keymaps 'adc-debug-map
            "d" 'dap-debug
            "t" 'dap-breakpoint-toggle
            "c" 'dap-breakpoint-condition
            "h" 'dap-breakpoint-hit-condition
            "m" 'dap-breakpoint-log-message
            "l" 'dap-ui-breakpoints-list
            "b" 'dap-ui-breakpoints)

  :custom
  (dap-auto-configure-features '(sessions locals controls tooltip))

  :config
  (dap-auto-configure-mode t)
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra))))

(provide 'adc-dap)
;;; adc-dap.el ends here
