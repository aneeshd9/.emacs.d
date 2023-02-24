(use-package exec-path-from-shell
  :custom
  (exec-path-from-shell-variables '("PATH"
				    "MANPATH"
				    "TMPDIR"
				    "KUBECONFIG"
				    "GOPATH"
				    "GOBIN"
				    "GOROOT"
				    "GOPRIVATE"
				    "GOENV_GOPATH_PREFIX"
				    "GOENV_VERSION"
				    "RUST_BACKTRACE"
				    "MallocNanoZone"))
  (exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-debug nil)

  :config
  (when (memq window-system '(mac ns x pgtk))
    (exec-path-from-shell-initialize)))

(let ((tmpdir (getenv "TMPDIR")))
  (when (and tmpdir (not (string-blank-p tmpdir)))
    (setq temporary-file-directory tmpdir)))

(add-to-list 'exec-path (expand-file-name "bin" adc-dir))

(provide 'adc-core-env)
