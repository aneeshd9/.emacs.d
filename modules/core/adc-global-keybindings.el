(general-define-key
 ;; Enable alternative to M-x.
 "C-x C-m" 'execute-extended-command

 ;; Enable dabbrev-expand via custom keybinding.
 "C-x M-/" 'dabbrev-expand

 ;; Easier version of "C-x k" to kill buffer
 "C-x C-k" 'kill-buffer

 ;; Evaluate buffer
 "C-c C-e" 'eval-buffer

 ;; Window switching
 "C-x i"   'adc-other-window-reverse
 "C-x C-o" 'other-window
 "C-x C-i" 'adc-other-window-reverse

 ;; Window management
 "C-x C-SPC" 'balance-windows
 "C-x SPC" 'balance-windows

 ;; Kill-Ring related
 "M-Y" 'adc-yank-pop-forwards

 ;; Align to equal signs
 "C-x a =" 'adc-align-region-to-equals
 "C-x a {" 'adc-align-region-to-opening-brace

 ;; align-regexp
 "C-c a" 'align-regexp

 ;; Toggle auto-fill-mode.
 "C-c q" 'auto-fill-mode

 ;; iBuffer
 "C-x C-b" 'ibuffer

 ;; Rename current file and buffer
 "C-c r"  'adc-rename-file-and-buffer)

(provide 'adc-global-keybindings)
