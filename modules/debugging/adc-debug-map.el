;;; adc-debug-map.el --- Aneesh's Emacs Config: debug-map setup.

;;; Commentary:

;; Setup of debug-map which other debugging modules can add
;; keybindings to.

;;; Code:
(define-prefix-command 'adc-debug-map)
(general-define-key "C-c -" 'adc-debug-map)

(provide 'adc-debug-map)
;;; adc-debug-map.el ends here
