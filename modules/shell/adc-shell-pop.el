;;; adc-shell-pop.el --- Aneesh's Emacs Config: shell-pop configuration.

;;; Commentary:

;; Basic configuration for shell-pop.

;;; Code:
(require 'adc-vterm)

(use-package shell-pop
  :general
  ("C-`" 'shell-pop)

  :custom
  (shell-pop-full-span t)
  (shell-pop-shell-type '("vterm" "*vterm*"
                          (lambda nil (vterm shell-pop-term-shell))))
  (shell-pop-universal-key "C-`")
  (shell-pop-window-position "bottom")
  (shell-pop-window-size 40))

(provide 'adc-shell-pop)
;;; adc-shell-pop.el ends here
