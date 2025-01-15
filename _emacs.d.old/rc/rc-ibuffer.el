;;; rc-ibuffer.el -- IBuffer Mode Settings

(setq ibuffer-saved-filter-groups
      '(("default"
         ("sim-3" (filename . "172.17.19.173"))
         ("dired" (mode . dired-mode))
         ("lisp" (or (mode . lisp-mode)
                     (mode . emacs-lisp-mode)
                     (name . "^\\*slime-")))
        ("org" (mode . org-mode)))))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

(provide 'rc-ibuffer)
;; rc-ibuffer.el ends here
