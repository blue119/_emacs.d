;;; rc-ibuffer.el -- IBuffer Mode Settings

(setq ibuffer-saved-filter-groups
      '(("default"
         ("sim-3" (filename . "172.17.19.173"))
         ("tapa" (filename . "172.17.17.35"))
         ("ypwang-desktop" (filename . "172.17.16.116"))
         ("dired" (mode . dired-mode))
         ("lisp" (or (mode . lisp-mode)
                     (mode . emacs-lisp-mode)
                     (name . "^\\*slime-"))))
        ))

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")))

(provide 'rc-ibuffer)
;; rc-ibuffer.el ends here
