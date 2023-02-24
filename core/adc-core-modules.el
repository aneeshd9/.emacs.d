;;; adc-core-modules.el --- Aneesh's Emacs Config: Modules loading.

;;; Commentary:

;; Loads all the required modules

;;; Code:
(defvar adc-modules-dir (adc-dir "modules")
  "Root directory for my Emacs config's modules.")
(adc-recursive-add-to-load-path adc-modules-dir)

;; Theme
(require 'adc-doom-themes)

;; Core modules
(require 'adc-aliases)
(require 'adc-global-keybindings)
(require 'adc-packages)

;; Completion
(require 'adc-company)
(require 'adc-cape)

;; Editor
(require 'adc-direnv)
(require 'adc-display-fill-column)
(require 'adc-display-indentation)
(require 'adc-display-line-numbers)
(require 'adc-whichkey)
;; (require 'adc-tree-sitter)

;; Linting
(require 'adc-flycheck)

;; Misc
(require 'adc-restart-emacs)

;; Project management
(require 'adc-editorconfig)
(require 'adc-projectile)
(require 'adc-treemacs)

;; Language servers
(require 'adc-lsp)

;; Debugging
(require 'adc-dap)

;; Shell
(require 'adc-vterm)
(require 'adc-shell-pop)

;; Widgets
(require 'adc-xwwp)

(provide 'adc-core-modules)
;;; adc-core-modules.el ends here
