(require 'adc-core-transparency)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(menu-bar-mode -1)

(setq use-dialog-box nil)

(setq inhibit-startup-screen t)

(if window-system (set-scroll-bar-mode 'nil))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-follow-mode t)
(setq scroll-margin 4)
(setq scroll-stop 1)
(setq scroll-conservatively 10000)

(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(defun yes-or-no-p-advice (_orig_function &rest args)
  "Advice to use `y-or-n-p` instead of `yes-or-no-p`, passing along ARGS."
  (apply 'y-or-n-p args))

(advice-add 'yes-or-no-p :around 'yes-or-no-p-advice)

(setq frame-title-format
      '("Emacs - " (:eval (if (buffer-file-name)
			      (abbreviate-file-name (buffer-file-name))
			    "%b"))))

(when (not window-system)
  (defun adc-change-window-divider ()
    "Change vertical border character."
    (let ((display-table (or buffer-display-table standard-display-table)))
      (set-display-table-slot display-table
			      'vertical-border (make-glyph-code ?\u2503))
      (set-window-display-table (selected-window) display-table)))

  (add-hook 'window-configuration-change-hook 'adc-change-window-divider))

(provide 'adc-core-ui)
