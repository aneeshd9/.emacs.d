(setq-default indent-tabs-mode nil)

(setq-default tab-width 8)

(setq require-final-newline t)

(visual-line-mode t)

(show-paren-mode t)

(delete-selection-mode t)

(setq sentence-end-double-space nil)

(setq save-place-file (adc-cache-dir "saveplace"))
(save-place-mode 1)

(if window-system
    (progn
      (blink-cursor-mode t)
      (setq initial-frame-alist
            (cons '(cursor-type . bar) (copy-alist initial-frame-alist)))
      (setq default-frame-alist
            (cons '(cursor-type . bar) (copy-alist default-frame-alist))))
  (blink-cursor-mode -1))

(if window-system
    (progn
      (setq default-frame-alist
            (cons '(fullscreen . maximized) (copy-alist initial-frame-alist)))))

(setq backup-by-copying t
      delete-old-versions t
      kept-new-versions 10
      kept-old-versions 0
      vc-make-backup-files t
      version-control t
      backup-directory-alist `((".*" . ,(adc-cache-dir "backup"))))

(let ((auto-save-dir (adc-cache-dir "autosave/")))
  (unless (file-exists-p auto-save-dir)
    (make-directory auto-save-dir))
  (setq auto-save-interval 20
        auto-save-file-name-transforms
        `((".*" ,auto-save-dir t))))

(setq tab-always-indent 'complete)

(global-auto-revert-mode t)
(when (eq system-type 'darwin)
  (setq auto-revert-use-notify nil))

(use-package diminish)

(diminish 'visual-line-mode)

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  )

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) adc-yank-indent-threshold)
      (indent-region beg end nil)))

(defmacro advise-commands (advice-name commands class &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.
The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (,class ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

(advise-commands "indent" (yank yank-pop) after
                 "If current mode is one of `siren-yank-indent-modes',
indent yanked text (with prefix arg don't indent)."
                 (if (and (not (ad-get-arg 0))
                          (not (member major-mode adc-indent-sensitive-modes))
                          (or (derived-mode-p 'prog-mode)
                              (member major-mode adc-yank-indent-modes)))
                     (let ((transient-mark-mode nil))
                       (yank-advised-indent-function (region-beginning) (region-end)))))

(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(require 're-builder)
(setq reb-re-syntax 'string)

(provide 'adc-core-editor)
