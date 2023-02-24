;;; adc-vterm.el --- Aneesh's Emacs Config: vterm configuration.

;;; Commentary:

;; Basic configuration for vterm.

;;; Code:
(require 'adc-windmove)

(use-package vterm
:defer t
:hook
(vterm-mode . adc-vterm-mode-setup)

:general
(:keymaps 'vterm-mode-map
          "C-c [" 'vterm-copy-mode
          "M-i" 'windmove-up
          "M-k" 'windmove-down
          "M-j" 'windmove-left
          "M-l" 'windmove-right
          "M-K" 'windmove-swap-states-down
          "M-I" 'windmove-swap-states-up
          "M-J" 'windmove-swap-states-left
          "M-L" 'windmove-swap-states-right)
(:keymaps 'vterm-copy-mode-map
          "C-g" 'adc-vterm-copy-mode-cancel
          "C-c [" 'vterm-copy-mode)

:custom
(vterm-always-compile-module t)
(vterm-kill-buffer-on-exit t)
(vterm-max-scrollback 50000)

:preface
(defun adc-vterm-mode-setup ()
  (hl-line-mode -1))

(defun adc-vterm-copy-mode-cancel ()
  "Clear mark if mark is active, otherwise exit vterm-copy-mode."
  (interactive)
  (if mark-active (deactivate-mark) (vterm-copy-mode -1))))

(provide 'adc-vterm)
;;; adc-vterm.el ends here
