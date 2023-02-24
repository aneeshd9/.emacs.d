(use-package memoize)

(use-package all-the-icons
  :after memoize
  :if window-system)

(use-package all-the-icons-ibuffer
  :after all-the-icons
  :if window-system
  :init
  (all-the-icons-ibuffer-mode 1))

(use-package all-the-icons-completion
  :after all-the-icons
  :if window-system
  :init
  (all-the-icons-completion-mode)

  :config
  (when (fboundp 'all-the-icons-completion-get-file-icon)
      ;; Override default category lookup function to add support for
      ;; project-buffer and project-file.
      (defun all-the-icons-completion-get-icon (cand cat)
        "Return the icon for the candidate CAND of completion category CAT."
        (cl-case cat
          (file (all-the-icons-completion-get-file-icon cand))
          (project-file (all-the-icons-completion-get-file-icon cand))
          (buffer (all-the-icons-completion-get-buffer-icon cand))
          (project-buffer (all-the-icons-completion-get-buffer-icon cand))
          (t ""))))

  ;; Using MintSoup's fork of all-the-icons-completion.
  (when (not (fboundp 'all-the-icons-completion-get-file-icon))
    (require 'cl-generic)

    ;; Add support for 'project-buffer category by treating it same as 'buffer.
    (cl-defmethod all-the-icons-completion-get-icon ((cand string) (cat (eql 'project-buffer)))
      (all-the-icons-completion-get-icon cand 'buffer))))

(provide 'adc-all-the-icons)
