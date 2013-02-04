;;; init.el --- Where all the magic begins
;;

;; Set init file for custom settings
(setq custom-file (locate-user-emacs-file "custom.el"))

;; Load path etc.
(add-to-list 'load-path (locate-user-emacs-file "lisp"))
(add-to-list 'load-path (locate-user-emacs-file "rc"))

;; Load features that needs to be loaded early in startup
(require 'rc-startup)

;; MISC
;; (require 'rc-ibus)
(require 'rc-time)
(require 'rc-misc)
(require 'rc-theme)
(require 'rc-cua)
(require 'rc-decor)
(require 'rc-gtags)
(require 'rc-kbd)
(require 'rc-ibuffer)
(require 'rc-auto-complete)
(require 'rc-wind-mgmt)
(require 'rc-slime)
(require 'rc-helm)
;; (require 'rc-yasnippet)
(require 'rc-python)
(require 'rc-fci)
;; (require 'rc-p4)
(require 'rc-org)
(require 'yp-tools)

