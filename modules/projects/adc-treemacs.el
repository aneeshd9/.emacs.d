;;; adc-treemacs.el --- Aneesh's Emacs Config: treemacs configuration.

;;; Commentary:

;; Basic configuration for treemacs.

;;; Code:
(use-package treemacs
  :general
  ("C-x C-p" 'treemacs)
  ("C-x p" 'treemacs-select-window)
  (general-unbind :keymaps 'treemacs-mode-map "M-l")

  :hook
  (treemacs-mode . adc-treemacs-change-hl-line-mode)

  :custom
  (treemacs-collapse-dirs 3)
  (treemacs-follow-after-init t)
  (treemacs-goto-tag-strategy 'refetch-index)
  (treemacs-indentation 2)
  (treemacs-is-never-other-window t)
  (treemacs-show-hidden-files t)
  (treemacs-silent-refresh nil)
  (treemacs-sorting 'alphabetic-asc)
  (treemacs-width 40)

  (treemacs-persist-file (adc-cache-dir "treemacs-persist"))
  (treemacs-last-error-persist-file
   (adc-cache-dir "treemacs-persist-at-last-error"))

  :preface
  (defgroup adc-treemacs nil
    "Adc specific settings for treemacs."
    :group 'treemacs)

  (defface adc-treemacs-line-highlight '((t (:extend t)))
    "Custom line-highlight face for treemacs."
    :group 'adc-treemacs)

  (defun adc-treemacs-change-hl-line-mode ()
    "Use a custom face to control style of highlighted line."
    (setq-local hl-line-face 'adc-treemacs-line-highlight)
    (overlay-put hl-line-overlay 'face hl-line-face)
    (treemacs--setup-icon-background-colors))

  :config
  (defvar treemacs-no-load-time-warnings t)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-git-mode 'deferred)

  (treemacs-define-doubleclick-action
   'file-node-open   #'treemacs-visit-node-in-most-recently-used-window)
  (treemacs-define-doubleclick-action
   'file-node-closed #'treemacs-visit-node-in-most-recently-used-window)
  (treemacs-define-RET-action
   'file-node-open   #'treemacs-visit-node-in-most-recently-used-window)
  (treemacs-define-RET-action
   'file-node-closed #'treemacs-visit-node-in-most-recently-used-window))

(use-package treemacs-all-the-icons
  :after (treemacs))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :custom
  (treemacs-header-function #'treemacs-projectile-create-header))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package lsp-treemacs
  :after (treemacs lsp-mode)

  :custom
  (lsp-metals-treeview-show-when-views-received t)

  :config
  (lsp-treemacs-sync-mode 1))

(provide 'adc-treemacs)
;;; adc-treemacs.el ends here
