;;; adc-tree-sitter.el --- Aneesh's Emacs Config: treesitter setup.

;;; Commentary:

;; Basic setup for treesitter.

;;; Code:
(use-package tree-sitter)

(use-package tree-sitter-langs)

(require 'tree-sitter-langs)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(provide 'adc-tree-sitter)
;;; adc-tree-sitter.el ends here
