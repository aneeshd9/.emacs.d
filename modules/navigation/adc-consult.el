;;; adc-consult.el --- Aneesh's Emacs Config: consult configuration.

;;; Commentary:

;; Basic configuration for consult package.

;;; Code:

(eval-when-compile
  (require 'cl-lib))

(use-package consult
  :defer t
  :general
  ("C-t" 'adc-consult-imenu)
  ("C-x b" 'consult-buffer)
  ("C-c b" 'consult-project-buffer)
  ("M-g M-g" 'consult-goto-line)

  :custom
  (consult-preview-max-count 10)

  :preface
  (defun adc-consult-imenu ()
    "Intelligently trigger consult-lsp-file-symbols or consult-imenu."
    (interactive)
    (if (and (fboundp 'consult-lsp-file-symbols)
             (boundp 'lsp-mode)
             lsp-mode)
        ;; consult-lsp-file-symbols errors on some language servers, in such
        ;; a case, fall back to consult-imenu.
        (condition-case nil
            (consult-lsp-file-symbols)
          ('error (consult-imenu)))
      (consult-imenu)))

  :config
  (defvar adc-consult--source-recent-file-hidden
    (let ((source (copy-tree consult--source-recent-file)))
      (plist-put source :hidden t)
      source)
    "Recent file candidate source for `consult-buffer'.")

  (defvar adc-consult--source-project-buffer-hidden
    (let ((source (copy-tree consult--source-project-buffer)))
      (plist-put source :category 'project-buffer)
      (plist-put source :hidden t)
      source)
    "Project buffer candidate source for `consult-buffer'.")

  (defvar adc-consult--source-project-buffer
    (let ((source (copy-tree consult--source-project-buffer)))
      (plist-put source :category 'project-buffer)
      (cl-remf source :hidden)
      (cl-remf source :narrow)
      source)
    "Project buffer candidate source for `consult-buffer'.")

  (defvar adc-consult--source-project-recent-file-hidden
    (let ((source (copy-tree consult--source-project-recent-file)))
      (plist-put source :category 'project-file)
      (plist-put source :hidden t)
      source)
    "Project buffer candidate source for `consult-buffer'.")

  (defvar adc-consult--source-project-recent-file
    (let ((source (copy-tree consult--source-project-recent-file)))
      (plist-put source :category 'project-file)
      (cl-remf source :hidden)
      (cl-remf source :narrow)
      source)
    "Project buffer candidate source for `consult-buffer'.")

  (setq consult-buffer-sources '(consult--source-hidden-buffer
                                 consult--source-modified-buffer
                                 consult--source-buffer
                                 adc-consult--source-recent-file-hidden
                                 consult--source-bookmark
                                 adc-consult--source-project-buffer-hidden
                                 adc-consult--source-project-recent-file-hidden)
        consult-project-buffer-sources '(adc-consult--source-project-buffer
                                         adc-consult--source-project-recent-file))

  )

(use-package consult-dir
  :general
  (:keymaps '(minibuffer-local-completion-map vertico-map
                                              selectrum-minibuffer-map)
            "C-x C-d" 'consult-dir
            "C-x C-j" 'consult-dir-jump-file))

(provide 'adc-consult)
;;; adc-consult.el ends here.
