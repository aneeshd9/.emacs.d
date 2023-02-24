(require 'adc-flycheck)

(use-package package-lint
  :defer t)

(use-package package-build
  :defer t)

(use-package flycheck-package
  :defer t
  :config
  (flycheck-package-setup))

(provide 'adc-packages)
