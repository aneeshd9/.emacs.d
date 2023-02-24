(use-package writeroom-mode
  :defer t
  :general
  (:keymaps 'writeroom-mode-map
            "C-M-<" 'writeroom-decrease-width
            "C-M->" 'writeroom-increase-width
            "C-M-=" 'writeroom-adjust-width)

  :custom
  (writeroom-global-effects nil)
  (writeroom-restore-window-config t)
  (writeroom-width 88))

(provide 'adc-writeroom)
