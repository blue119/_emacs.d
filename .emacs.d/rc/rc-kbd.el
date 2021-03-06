;; rc-kbd.el --- Set up some handy key bindings
;;

;; See the Misc[ellaneous System] Events node of the Emacs Lisp manual:
(define-key special-event-map [sigusr1]
                (lambda ()
                  (interactive)
                  (save-buffers-kill-emacs t)))

;; highlight-symbol for source-insign style
(when (fboundp 'highlight-symbol-mode)
  (global-set-key (kbd "<f6>") 'highlight-symbol-at-point)
  (global-set-key (kbd "C-S-<f6>") 'highlight-symbol-remove-all))

;; hi-lock-mode, it support highlight words with regexp
(global-set-key (kbd "C-<f6>") 'highlight-regexp)
(global-set-key (kbd "S-<f6>") 'unhighlight-regexp)

;; Bind C-2 to C-@ so emacs-gtk2 behaves like in xterm
(global-set-key (kbd "C-2") 'set-mark-command)

;; You know, like Readline.
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

;; Completion that uses many different methods to find options.
(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.
;; (global-set-key (kbd "C-c n") 'cleanup-buffer)

;; Use regex searches by default. 
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (This is awesome.)
;; (global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding
(global-set-key (kbd "C-x M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Window switching. (C-x o goes to the next window)
(windmove-default-keybindings) ;; Shift+direction
(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one
(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.
(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.
(global-set-key (kbd "C-x M-m") 'shell)

;; Fetch the contents at a URL, display it raw.
;; (global-set-key (kbd "C-x C-h") 'view-url)

;; Help should search more than just commands
(global-set-key (kbd "C-h a") 'apropos)

;; Should be able to eval-and-replace anywhere.
(global-set-key (kbd "C-c e") 'eval-and-replace)

;; For debugging Emacs modes
;; (global-set-key (kbd "C-c p") 'message-point)

;; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;; Org Custom Key Bindings
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; folding
(add-hook 'c-mode-common-hook
  (lambda()
    (local-set-key (kbd "C-c <C-right>") 'hs-show-block)
    (local-set-key (kbd "C-c <C-left>")  'hs-hide-block)
    (hs-minor-mode t)))

;; Gnus
(global-set-key (kbd "C-c g") 'gnus)

;; run program
(global-set-key (kbd "<f2>") 'run-current-file)

;; Nav
(global-set-key (kbd "<f5>") 'nav)

(global-set-key (kbd "<f6>") (lambda ()
  (interactive)
  (if (string= (buffer-name) ecb-directories-buffer-name)
    (refresh-ecb)
    (if (buffer-modified-p)
      (revert-buffer) ; ask for confirmation
      (revert-buffer t t))))) ; don't ask for confirmation - it's unnecessary, since the buffer hasn't been 

;; Whitespcae-mode
; (global-set-key (kbd "<f9>") 'whitespace-mode)

(provide 'rc-kbd)
;;; rc-kbd.el ends here
