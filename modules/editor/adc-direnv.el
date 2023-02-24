;;; adc-direnv.el --- Aneesh's Emacs Config: direnv configuration

;;; Commentary:

;; Basic configuration for direnv

;;; Code:

(use-package direnv
  :config
  (when (executable-find "direnv")
    (direnv-mode)))

(provide 'adc-direnv)
;;; adc-direnv.el ends here.
