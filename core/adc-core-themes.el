(defvar adc-themes-dir (adc-dir "themes")
  "Root directory for my Emacs custom themes.")
(add-to-list 'custom-theme-load-path adc-themes-dir)

(if (get 'mode-line-active 'face-defface-spec)
    (set-face-attribute 'mode-line-active nil :inherit 'mode-line))
(if (get 'mode-line-inactive 'face-defface-spec)
    (set-face-attribute 'mode-line-inactive nil :inherit 'mode-line))

(defvar adc-set-face-ignore-attributes '(:weight))
(defadvice set-face-attribute
    (before ignore-attributes (face frame &rest args) activate)
  (setq args
        (apply 'nconc
               (mapcar (lambda (i)
                         (let ((attribute (nth i args))
                               (value (nth (1+ i) args)))
                           (if (not (memq attribute
                                          adc-set-face-ignore-attributes))
                               (list attribute value))))
                       (number-sequence 0 (1- (length args)) 2)))))

(provide 'adc-core-themes)
