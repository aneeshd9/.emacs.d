(defun adc-transparency-fix ()
  "Set initial value of alpha parameter for the current frame."
  (interactive)
  (if (equal (frame-parameter nil 'alpha) nil)
      (set-frame-parameter nil 'alpha 100)))

(defun adc-transparency-increase ()
  "Increase level of transparency for current frame."
  (interactive)
  (adc-transparency-fix)
  (if (> (frame-parameter nil 'alpha) 0)
      (let ((new-level (+ (frame-parameter nil 'alpha) -1)))
	(set-frame-parameter nil 'alpha new-level)
	(message "Frame transparency level is set to %s" new-level))
    (message "This is the minimum value of transparency!")))

(defun adc-transparency-decrease ()
  "Decrease level of transparency for current frame."
  (interactive)
  (adc-transparency-fix)
  (if (< (frame-parameter nil 'alpha) 100)
      (let ((new-level (+ (frame-parameter nil 'alpha) +1)))
	(set-frame-parameter nil 'alpha new-level)
	(message "Frame transparency level is set to %s" new-level))
    (message "This is the maximum value of transparency!")))

(defun adc-transparency (numb)
  "Set level of transparency for current frame by specifying NUMB."
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value of transparency is 100!")
    (if (< numb 0)
	(message "Error! The minumum value of transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

(adc-transparency adc-transparency-level)
(add-hook 'after-make-frame-functions
	  (lambda (selected-frame)
	    (set-frame-parameter selected-frame 'alpha adc-tranparency-level)))

(global-set-key (kbd "C-M-|") 'adc-transparency)
(global-set-key (kbd "C-M-<") 'adc-transparency-increase)
(global-set-key (kbd "C-M->") 'adc-transparency-decrease)

(provide 'adc-core-transparency)
