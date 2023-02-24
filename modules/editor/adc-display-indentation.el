;;; adc-display-indentation.el --- Aneesh's Emacs Config: indent guides setup.

;;; Commentary:

;; Setup for rendering indent guides

;;; Code:
(require 'adc-highlight-indent-guides)

(defun adc-display-indentation (&optional arg)
  "Activate or deactivate indentation guides.
Optional ARG is passed directly to mode toggle function."
  (interactive)
  ;; Only allow indentation markers if file size is below 100KB. Above that
  ;; performance is very bad.
  (if (< (buffer-size) (* 100 1024))
      (highlight-indent-guides-mode arg)))

(provide 'adc-display-indentation)
;;; adc-display-indentation.el ends here
