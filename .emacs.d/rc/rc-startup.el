;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))
(el-get 'sync)
; (el-get-emacswiki-build-local-recipes)
; (el-get-elpa-build-local-recipes)

(el-get-install "highlight-symbol")
(el-get-install "color-theme")
(el-get-install "color-theme-desert")
(el-get-install "python-mode")
(el-get-install "smex")
(el-get-install "vline")
(el-get-install "yasnippet")
(el-get-install "magit")
(el-get-install "helm")
(el-get-install "js2-mode")
(el-get-install "auto-complete")
(el-get-install "find-file-in-project")
; (el-get-install "modeline-posn")
(el-get-install "fill-column-indicator")
(el-get-install "nav")
;(el-get-install "xgtags")

(provide 'rc-startup)
