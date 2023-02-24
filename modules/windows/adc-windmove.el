;;; adc-windmove.el --- Aneesh's Emacs Config: windmove configuration.

;;; Commentary:

;; Basic configuration for windmove.

;;; Code:
(use-package windmove
  :straight (:type built-in)

  :general
  ("M-i" 'windmove-up)
  ("M-k" 'windmove-down)
  ("M-j" 'windmove-left)
  ("M-l" 'windmove-right)
  ("M-K" 'windmove-swap-states-down)
  ("M-I" 'windmove-swap-states-up)
  ("M-J" 'windmove-swap-states-left)
  ("M-L" 'windmove-swap-states-right)
  ("C-x M-i" 'windmove-delete-up)
  ("C-x M-k" 'windmove-delete-down)
  ("C-x M-j" 'windmove-delete-left)
  ("C-x M-l" 'windmove-delete-right))

(provide 'adc-windmove)
;;; adc-windmove.el ends here
