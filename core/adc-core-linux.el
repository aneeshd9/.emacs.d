(if window-system
    (let* ((families '("Mononoki Nerd Font"
                       "Menlo Nerd Font Mono"
                       "Menlo for Powerline"
                       "Menlo"
                       "Monaco Nerd Font Mono"
                       "Monaco for Powerline"
                       "Monaco"))
           (family (catch 'found
                     (dolist (f families)
                       (if (member f (font-family-list))
                           (throw 'found f))))))
      (set-face-attribute 'default nil :family family :height 150)))

(global-set-key (kbd "s-<return>") 'toggle-frame-fullscreen)

(provide 'adc-core-linux)
