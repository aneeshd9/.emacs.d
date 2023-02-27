;;; adc-helm.el --- Aneesh's Emacs Config: helm configuration.

;;; Commentary:

;; Basic configuration for helm.

;;; Code:

(require 'tramp)

(use-package helm-global-bindings
  :straight helm
  :demand
  :general
  (:keymaps 'helm-command-map
            "M" 'helm-man-woman)

  :custom
  (helm-command-prefix-key "C-c h"))

(use-package helm-core
  :after helm-global-bindings
  :defer t)

(use-package helm
  :after (helm-global-bindings)
  :defer t
  :hook
  (helm-minibuffer-set-up . adc-helm--hide-minibuffer-maybe)
  (helm-after-initialize . adc-helm--toggle-source-header-line)
  (helm-minibuffer-set-up . adc-helm--popwin-help-mode-off)
  (helm-cleanup . adc-helm--popwin-help-mode-on)
  (helm-cleanup . adc-helm--show-neotree-maybe)
  (helm-cleanup . adc-helm--show-treemacs-maybe)

  :custom
  (helm-always-two-windows t)
  (helm-autoresize-max-height 48)
  (helm-autoresize-min-height 10)
  (helm-autoresize-mode nil)
  (helm-case-fold-search 'smart)
  (helm-display-buffer-height 64)
  (helm-display-buffer-reuse-frame nil)
  (helm-display-buffer-width 160)
  (helm-display-function 'helm-default-display-buffer)
  (helm-display-header-line t)
  (helm-echo-input-in-header-line t)
  (helm-file-name-case-fold-search 'smart)
  (helm-follow-mode-persistent t)
  (helm-full-frame t)
  (helm-show-completion-display-function 'helm-display-buffer-in-own-frame)
  (helm-source-names-using-follow '("AG" "Diagnostics" "Helm Xref"))
  (helm-split-window-default-side 'above)
  (helm-split-window-inside-p nil)
  (helm-use-undecorated-frame-option t)

  (adc-helm-auto-toggle-neotree t)
  (adc-helm-auto-toggle-treemacs t)

  :preface
  (defgroup adc-helm nil
    "Adc specific settings for helm."
    :group 'helm)

  (defcustom adc-helm-auto-toggle-neotree t
    "When t and automatically hide and show neotree when helm is activated."
    :type 'boolean
    :group 'adc-helm)

  (defcustom adc-helm-auto-toggle-treemacs t
    "When t and automatically hide and show treemacs when helm is activated."
    :type 'boolean
    :group 'adc-helm)

  (defvar adc-helm--did-hide-neotree nil)
  (defvar adc-helm--did-hide-treemacs nil)

  ;; From: https://www.reddit.com/r/emacs/comments/3asbyn/new_and_very_useful_helm_feature_enter_search/
  (defun adc-helm--hide-minibuffer-maybe ()
    (when (with-helm-buffer helm-echo-input-in-header-line)
      (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
        (overlay-put ov 'window (selected-window))
        (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                                `(:background ,bg-color :foreground ,bg-color)))
        (setq-local cursor-type nil))))

  ;; From: https://github.com/emacs-helm/helm/issues/918#issuecomment-81555133
  (defun adc-helm--toggle-source-header-line ()
    (if (= (length (ignore-errors (with-helm-buffer helm-sources))) 1)
        (set-face-attribute 'helm-source-header nil :height 0.1)
      (set-face-attribute 'helm-source-header nil :height 1.0)))

  ;; From: https://github.com/emacs-helm/helm/wiki/Popwin
  (defun adc-helm--popwin-help-mode-off ()
    "Turn `popwin-mode' off for *Help* buffers."
    (when (boundp 'popwin:special-display-config)
      (customize-set-variable 'popwin:special-display-config
                              (delq 'help-mode popwin:special-display-config))))

  ;; From: https://github.com/emacs-helm/helm/wiki/Popwin
  (defun adc-helm--popwin-help-mode-on ()
    "Turn `popwin-mode' on for *Help* buffers."
    (when (boundp 'popwin:special-display-config)
      (customize-set-variable 'popwin:special-display-config
                              (add-to-list 'popwin:special-display-config
                                           'help-mode nil #'eq))))

  (defun adc-helm--hide-neotree (&rest plist)
    (when (and adc-helm-auto-toggle-neotree
               (not (eq helm-display-function 'helm-posframe-display))
               (fboundp 'neotree-hide)
               (fboundp 'neo-global--window-exists-p)
               (neo-global--window-exists-p))
      (setq adc-helm--did-hide-neotree t)
      (neotree-hide)))

  (defun adc-helm--show-neotree-maybe ()
    (when (and (fboundp 'neotree-show)
               adc-helm--did-hide-neotree)
      (setq adc-helm--did-hide-neotree nil)
      (run-with-timer 0.01 nil #'neotree-show)))

  (defun adc-helm--hide-treemacs (&rest plist)
    (when (and adc-helm-auto-toggle-treemacs
               (not (eq helm-display-function 'helm-posframe-display))
               (fboundp 'treemacs-get-local-window))
      (let ((win (treemacs-get-local-window)))
        (when win
          (setq adc-helm--did-hide-treemacs t)
          (delete-window win)))))

  (defun adc-helm--show-treemacs-maybe ()
    (when adc-helm--did-hide-treemacs
      (setq adc-helm--did-hide-treemacs nil)
      (run-with-timer 0.01 nil #'adc-helm--show-treemacs)))

  (defun adc-helm--show-treemacs ()
    (when (fboundp 'treemacs-select-window)
      (let ((win (selected-window)))
        (treemacs-select-window)
        (select-window win))))

  :config
  (require 'helm-mode)
  (advice-add 'helm :before 'adc-helm--hide-neotree)
  (advice-add 'helm :before 'adc-helm--hide-treemacs))

(use-package helm-elisp
  :straight helm
  :after (helm-global-bindings)
  :general
  (:keymaps 'helm-command-map
            "d" 'helm-apropos))

(use-package helm-files
  :straight helm
  :after (helm-global-bindings)
  :general
  ("C-x f" 'helm-find-files)

  :custom
  (helm-buffer-max-length 64)
  (helm-ff-file-name-history-use-recentf t)
  (helm-ff-search-library-in-sexp t))

(use-package helm-for-files
  :straight helm
  :after (helm-global-bindings)
  :general
  ("C-c f f" 'helm-for-files)
  ("C-c f r" 'helm-recentf))

(use-package helm-ring
  :straight helm
  :after (helm-global-bindings)
  :init
  ;; This advice is borrowed from the browse-kill-ring package.
  (defadvice yank-pop (around kill-ring-browse-maybe (arg))
    "If last action was not a yank, run `helm-show-kill-ring' instead."
    (interactive "p")
    (if (not (eq last-command 'yank))
        (helm-show-kill-ring)
      (barf-if-buffer-read-only)
      ad-do-it))

  (ad-activate 'yank-pop))

(use-package helm-descbinds
  :defer t
  :after (helm-global-bindings))

(use-package helm-describe-modes
  :defer t
  :after (helm-global-bindings))

(use-package helm-xref
  :defer t
  :after (helm-global-bindings))

(use-package helm-posframe
  :if window-system

  :custom
  (helm-posframe-border-width 3)
  (helm-posframe-height nil)
  (helm-posframe-min-height 70)
  (helm-posframe-min-width nil)
  (helm-posframe-parameters '((left-fringe . 10) (right-fringe . 10)))
  (helm-posframe-width 500)

  :preface
  ;; helm-posframe does not come with a minor mode to toggle it on/off, so let's
  ;; make one to make life easier.
  (define-minor-mode helm-posframe-mode
    "Toggle helm-posframe."
    :lighter " fmt"
    (if helm-posframe-mode (helm-posframe-enable) (helm-posframe-disable)))

  (defun adc-helm-posframe-clear-on-fullscreen (frame)
    (let ((fullscreen  (frame-parameter frame 'fullscreen)))
      (when (and helm-posframe-mode
                 (memq fullscreen '(fullscreen fullboth)))
        (posframe-hide-all))))

  :config
  (add-hook 'window-size-change-functions
            'adc-helm-posframe-clear-on-fullscreen)

  ;; (helm-posframe-mode +1)
)

(provide 'adc-helm)
;;; adc-helm.el ends here.
