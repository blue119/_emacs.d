;;; rc-org.el -- OrgMode Settings

(require 'org)
(require 'org-checklist nil t)
(require 'org-contacts nil t)

(setq org-directory "~/Dropbox/org/"
      org-agenda-files '("~/Dropbox/org/newgtd.org")
      org-todo-keywords '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)"))
      org-refile-targets '(
                           ("newgtd.org" :maxlevel . 1) 
                           ("someday.org" :level . 2))
      org-agenda-custom-commands
           '(("f" occur-tree "FIXME")
             ("p" . "Projects")
             ("pp" "All Projects"
              ((tags "PROJECT")))
             ("ph" "Home Projects"
              ((tags "PROJECT+HOME")))
             ("po" "Office Projects"
              ((tags "PROJECT+OFFICE")))
             ("h" "Office and Home Lists"
              ((agenda)
               (tags-todo "OFFICE")
               (tags-todo "HOME")
               (tags-todo "DEBIAN")
               (tags-todo "READING"))))
)

(add-hook 'org-mode-hook
            (lambda () 
              (org-indent-mode)
              ))

(provide 'rc-org)
;; rc-org.el ends
