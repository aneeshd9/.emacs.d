;;; init.el --- Aneesh's Emacs Config: init file.

;;; Commentary:

;; Init file.

;;; Code:

(setq load-prefer-newer t)
(load (expand-file-name "core/adc-core-init.el"
			(file-name-directory load-file-name)))

;;; init.el ends here.
