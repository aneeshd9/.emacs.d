;; Always load the newest byte code
(setq load-prefer-newer t)
(load (expand-file-name "core/adc-core-init.el"
			(file-name-directory load-file-name)))
