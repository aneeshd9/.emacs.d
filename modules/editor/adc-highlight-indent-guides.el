;;; adc-highlight-indent-guides.el --- Aneesh's Emacs Config: highlight-indent-guides configuration.

;;; Commentary:

;; Basic configuration for highlight-indent-guides

;;; Code:
(use-package highlight-indent-guides
  :defer t
  :commands highlight-indent-guides-mode
  :diminish highlight-indent-guides-mode

  :custom
  (highlight-indent-guides-auto-enabled nil)
  (highlight-indent-guides-character ?\u2502)
  (highlight-indent-guides-method 'column)
  (highlight-indent-guides-responsive nil))

(provide 'adc-highlight-indent-guides)
;;; adc-highlight-indent-guides.el ends here
