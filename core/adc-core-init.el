(defun display-startup-echo-area-message ()
  "Display startup echo area message."
  (message "Emacs initialized in %s" (emacs-init-time)))

(message "Emacs is starting, please be patient...")

;; Validate emacs-version
(when (version< emacs-version "27.1")
  (error "Config requires at least GNU Emacs 27.1, but you're running %s"
	 emacs-version))

;; Setup some required directories
(defvar adc-core-dir (file-name-directory load-file-name)
  "Core directory within the emacs configuration.")

(defvar adc-dir (expand-file-name ".." adc-core-dir)
  "Root directory of the emacs configuration.")

(defvar adc-cache-dir (expand-file-name "cache" user-emacs-directory)
  "Main cache directory which packages should be configured to use.")

(unless (file-exists-p adc-cache-dir)
  (make-directory adc-cache-dir))

(defun adc-dir (name)
  "Return absolute path to sub-directory NAME under root-dir."
  (expand-file-name name adc-dir))

(defun adc-cache-dir (name)
  "Return absolute path to sub-directory NAME under cache-dir."
  (expand-file-name name adc-cache-dir))

;; Setup the load path
(add-to-list 'load-path adc-core-dir)

;; Load the core
(require 'adc-core-custom)
(require 'adc-core-utils)

;; Config changes made through the customize UI will be stored here
(setq custom-file (adc-dir "custom.el"))
(load-file custom-file)

(provide 'adc-core-init)
