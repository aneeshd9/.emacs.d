;;; adc-doom-themes.el --- Aneesh's emacs config: Themes

;;; Commentary:

;; Setup doom themes

;;; Code:

(require 'adc-all-the-icons)
(require 'adc-doom-modeline)

(use-package doom-themes
  :custom
  ;; Global doom-themes options
  (doom-themes-enable-bold t)    ; if nil, bold is universally disabled
  (doom-themes-enable-italic t)  ; if nil, italics is universally disabled
  (doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-enable-variable-pitch nil)

  (doom-nord-light-brighter-comments nil)
  (doom-nord-light-brighter-modeline nil)
  (doom-nord-light-comment-bg nil)
  (doom-nord-light-padded-modeline nil)

  (doom-vibrant-brighter-comments nil)
  (doom-vibrant-brighter-modeline nil)
  (doom-vibrant-padded-modeline nil)

  (nlinum-highlight-current-line t)

  :config
  (if (not (adc-ns-system-appearance))
      (adc-doom-themes-set-appearance 'dark)
    (adc-doom-themes-set-appearance ns-system-appearance)
    (add-hook 'ns-system-appearance-change-functions
              'adc-doom-themes-set-appearance))

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Configure treemacs styling
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)

  :preface
  (defun adc-ns-system-appearance()
    "Return the system appearance, either `dark', `light', or `nil'.
A return value of `nil' means that the system appearance is could
not be determined. This happens on non-macOS systems, or on macOS
if running Emacs in a terminal."
    (if (boundp 'ns-system-appearance)
        ns-system-appearance
      nil))

  (defgroup adc-doom-themes nil
    "adc-doom-themes customizations."
    :group 'doom-themes)

  (defcustom adc-doom-themes-light-theme 'doom-solarized-light
    "The theme to apply when system appearance is light."
        :type '(symbol)
        :group 'adc-doom-themes)

  (defcustom adc-doom-themes-dark-theme 'doom-vibrant
    "The theme to apply when system appearance is dark."
        :type '(symbol)
        :group 'adc-doom-themes)

  (defun adc-doom-themes-set-appearance (appearance)
    "Load theme, taking current system APPEARANCE into consideration."
    (pcase appearance
      ('light (adc-doom-themes-load adc-doom-themes-light-theme t))
      ('dark (adc-doom-themes-load adc-doom-themes-dark-theme t))))

  (defun adc-doom-themes-load (theme &optional no-reapply)
    "Load doom-theme THEME, and apply adc overrides.
If NO-REAPPLY is non-nil, do nothing if the specified theme is
already loaded, otherwise re-apply the theme and adc-overrides."
    (interactive (list (completing-read "Choose theme: "
                                        (adc-doom-themes-list))))

    (if (string= (type-of theme) "string")
        (setq theme (intern theme)))
    (if (not (string-prefix-p "doom-" (symbol-name theme)))
        (error "'%s is not a doom-themes theme" theme))

    (when (or (not no-reapply)
              (not (member theme custom-enabled-themes)))
      ;; disable all themes
      (dolist (theme custom-enabled-themes)
        (when (not (string= theme "use-package"))
          (disable-theme theme)))

      ;; load doom theme
      (load-theme theme t)

      ;; load overrides theme: ../../themes/adc-doom-themes-overrides-theme.el
      ;; (load-theme 'adc-doom-themes-overrides t)

      ;; execute custom function after loading/switching theme
      (with-eval-after-load 'highlight-indent-guides
        (highlight-indent-guides-auto-set-faces))))

  (defun adc-doom-themes-vibrant-theme ()
    (interactive)
    (adc-doom-themes-load 'doom-vibrant))
  (defalias 'doom-vibrant 'adc-doom-themes-vibrant-theme)

  (defun adc-doom-themes-nord-light-theme ()
    (interactive)
    (adc-doom-themes-load 'doom-nord-light))
  (defalias 'nord-light 'adc-doom-themes-nord-light-theme)

  (defun adc-doom-themes-solarized-light-theme ()
    (interactive)
    (adc-doom-themes-load 'doom-solarized-light))
  (defalias 'solarized-light 'adc-doom-themes-solarized-light-theme)

  (defun adc-doom-themes-list ()
    (seq-filter
     (lambda (n) (string-prefix-p "doom-" (symbol-name n)))
     (custom-available-themes))))

(provide 'adc-doom-themes)
;;; adc-doom-themes.el ends here
