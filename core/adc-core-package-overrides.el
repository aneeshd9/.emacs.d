(setq straight-recipe-overrides
      '((nil . (
		(all-the-icons-completion :type git :flavor melpa :host github :repo "iyefrat/all-the-icons-completion"
					  :fork (:host github :repo "MintSoup/all-the-icons-completion"))
		(vertico :type git :host github :repo "minad/vertico"
			 :files (:defaults "extensions/*" (:exclude ".git")))))))

(provide 'adc-core-package-overrides)
