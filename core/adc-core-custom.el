(defgroup adc nil
  "Basic settings for emacs config."
  :group 'tools)

(defcustom adc-yank-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur."
  :type 'number
  :group 'adc)

(defcustom adc-indent-sensitive-modes
  '(coffee-mode conf-mode haml-mode makefile-automake-mode makefile-bsdmake-mode
		makefile-gmake-mode makefile-imake-mode makefile-makepp-mode
		makefile-mode python-mode slim-mode yaml-mode)
  "Major mode for which autoindenting is suppressed."
  :type '(repeat symbol)
  :group 'adc)

(defcustom adc-yank-indent-modes '(LaTeX-mode TeX-mode)
  "Major modes in which to indent regions that are yanked (or yank-popped).
Only modes that do not derive from `prog-mode` should be listed here."
  :type '(repeat symbol)
  :group 'adc)

(defcustom adc-transparency-level 90
  "The default frame transparency level."
  :type 'number
  :group 'adc)

(provide 'adc-core-custom)
