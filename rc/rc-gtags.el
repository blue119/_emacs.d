
(add-hook 'c-mode-common-hook
          (lambda ()
            (require 'gtags)
            (gtags-mode t)))

;; get into gtags-mode whenever you get into c-mode
;; (setq c-mode-hook
;;       '(lambda ()
;;          (gtags-mode 1)))

;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (require 'gtags)
;;             (gtags-mode t)
;;             (when (not (string-match "/usr/src/linux/" (expand-file-name default-directory)))  
;;               (djcb-gtags-create-or-update))))

;; refering from http://emacs-fu.blogspot.tw/2009/01/navigating-through-source-code-using.html
(defun djcb-gtags-create-or-update ()
  "create or update the gnu global tag file"
  (interactive)
  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
      (let ((olddir default-directory)
            (topdir (read-directory-name  
                     "gtags: top of source tree:" default-directory)))
        (cd topdir)
        (shell-command "gtags && echo 'created tagfile'")
        (cd olddir)) ; restore   
    ;;  tagfile already exists; update it
    (shell-command "global -u && echo 'updated tagfile'")))

(add-hook 'gtags-mode-hook 
          (lambda()
            (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
            (local-set-key (kbd "M-,") 'gtags-find-rtag)))  ; reverse tag

(eval-after-load 'gtags
  '(put 'gtags-rootdir 'safe-local-variable 'stringp))

(provide 'rc-gtags)
