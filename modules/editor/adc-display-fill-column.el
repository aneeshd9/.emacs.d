;;; adc-display-fill-column.el --- Aneesh's Emacs Config: display-fill-column-indicator configuration.

;;; Commentary:

;; Basic configuration for display-fill-column-indicator

;;; Code:
(use-package display-fill-column-indicator
  :straight (:type built-in)

  :hook
  (prog-mode . display-fill-column-indicator-mode)

  :custom
  (display-fill-column-indicator-character ?\u2502))

(defun adc-display-fill-column (&optional arg)
  "Activate or deactivate visual fill column.
Optional ARG is passed directly to mode toggle function."
  (interactive)
  (display-fill-column-indicator-mode arg))

(provide 'adc-display-fill-column)
;;; adc-display-fill-column.el ends here
