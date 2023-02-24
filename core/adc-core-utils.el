(defmacro adc-prepend (list-var element)
  "Add ELEMENT to the beginning of LIST-VAR, removing duplicates."
  `(setq ,list-var (cons ,element (remove ,element ,list-var))))

(defmacro adc-append (list-var element)
  "Add ELEMENT to the end of LIST-VAR, removing duplicates."
  `(setq ,list-var (append (remove ,element ,list-var) (list ,element))))

(defun adc-recursive-add-to-load-path (dir)
  "Add DIR and all of its sub-directories to `load-path`."
  (add-to-list 'load-path dir)
  (dolist (f (directory-files dir))
    (let ((name (expand-file-name f dir)))
      (when (and (file-directory-p name)
		 (not (string-prefix-p "." f)))
	(adc-recursive-add-to-load-path name)))))

(defun adc-smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at its beginnning according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun adc-align-region-to-equals (begin end)
  "Align region (specified by BEGIN and END) to equal signs."
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\)=" 1 1 ))

(defun adc-align-region-to-opening-brace (begin end)
  "Align region (specified by BEGIN and END) to equal opening brace."
  (interactive "r")
  (align-regexp begin end "\\(\\s-*\\){" 1 1 ))

(defun adc-yank-pop-forwards (arg)
  "Yank pop in reverse."
  (interactive "p")
  (yank-pop (- arg)))

(defun adc-other-window-reverse ()
  "Switch to previous window."
  (interactive)
  (other-window -1))

(defun adc-rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
	(message "Buffer is not visiting a file.")
      (let ((new-name (read-file-name "New name: " filename)))
	(cond
	 ((vc-backend filename) (vc-rename-file filename new-name))
	 (t
	  (rename-file filename new-name t)
	  (rename-buffer new-name)
	  (set-visited-file-name new-name)
	  (set-buffer-modified-p nil)))))))

(defun adc-ignore-error-wrapper (fn)
  "Returns a new function that ignores errors.
Wraps FN in `ignore-errors` macro."
  (lexical-let ((fn fn))
	       (lambda ()
		 (interactive)
		 (ignore-errors (funcall fn)))))

(defun adc-allow-line-as-region-for-function (orig-function)
  `(defun ,(intern (concat (symbol-name orig-function) "-or-line"))
       ()
     ,(format "Like `%s`, but acts on the current line if mark is not active."
	      orig-function)
     (interactive)
     (if mark-active
	 (call-interactively (function ,orig-function))
       (save-excursion
	 (beginning-of-line)
	 (set-mark (point))
	 (end-of-line)
	 (call-interactively (function ,orig-function))))))

(provide 'adc-core-utils)
