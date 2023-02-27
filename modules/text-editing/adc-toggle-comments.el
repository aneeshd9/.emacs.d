;;; adc-toggle-comments.el --- Aneesh's Emacs Config: toggle-comments.

;;; Commentary:

;; Allows for toggling comments.

;;; Code:

(unless (fboundp 'comment-or-uncomment-region-or-line)
  (adc-allow-line-as-region-for-function comment-or-uncomment-region))

(global-set-key (kbd "C-c /") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c C-/") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-c C-_") 'comment-or-uncomment-region-or-line)

(provide 'adc-toggle-comments)
;;; adc-toggle-comments.el ends here.
