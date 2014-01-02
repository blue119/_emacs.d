;;; rc-org.el -- OrgMode Settings

(require 'org)
(require 'org-checklist nil t)
(require 'org-contacts nil t)

(setq org-modules '(org-bbdb
                    org-bibtex
                    org-crypt
                    org-gnus
                    org-id
                    org-info
                    org-jsinfo
                    org-habit
                    org-inlinetask
                    org-rmail
            ))

(setq org-directory "~/Dropbox/org"
      org-agenda-files '("~/Dropbox/org/newgtd.org" 
                         "~/Dropbox/org/refile.org"
                         "~/Dropbox/org/gCalendar.org"
                         "~/Dropbox/org/rkus.org"
                         "~/Dropbox/org/alices-three-shift.org")
      org-default-notes-file (concat org-directory "/refile.org")
      journal-file "~/Dropbox/org/journal.org"
      org-agenda-include-diary t
      org-log-done 'time
      org-log-into-drawer "LOGBOOK"
      org-clock-into-drawer "CLOCK"

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Ch5 Tasks and States from norang
      ;; org-todo-keywords '((sequence "TODO(t!)" "NEXT(n)" "WAITTING(w)" "SOMEDAY(s)" "|" "DONE(d@/!)" "ABORT(a@/!)"))
      org-use-fast-todo-selection t
      ;; org-treat-S-cursor-todo-selection-as-state-change nil

      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))

      org-todo-keyword-faces '(("TODO" :foreground "red" :weight bold)
                               ("NEXT" :foreground "blue" :weight bold)
                               ("DONE" :foreground "forest green" :weight bold)
                               ("WAITING" :foreground "orange" :weight bold)
                               ("HOLD" :foreground "magenta" :weight bold)
                               ("CANCELLED" :foreground "forest green" :weight bold))

      ;; Moving a task to CANCELLED adds a CANCELLED tag
      ;; Moving a task to WAITING adds a WAITING tag
      ;; Moving a task to HOLD adds a WAITING tag
      ;; Moving a task to a done state removes a WAITING tag
      ;; Moving a task to TODO removes WAITING and CANCELLED tags
      ;; Moving a task to NEXT removes a WAITING tag
      ;; Moving a task to DONE removes WAITING and CANCELLED tags
      org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                     ("WAITING" ("WAITING" . t))
                                     ("HOLD" ("WAITING" . t) ("HOLD" . t))
                                     (done ("WAITING") ("HOLD"))
                                     ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                                     ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                                     ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Ch 6 Adding New Tasks Quickly with Org Capture from norang
      ;;
      ;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
      org-capture-templates 
      '(
        ("t" "New task" entry (file "refile.org")
         "* TODO %^{Brief Description} %^g\n%?\n%U")
        ;; ("r" "respond" entry (file "~/Dropbox/org/refile.org")
        ;;  "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        ("n" "note" entry (file "~/Dropbox/org/refile.org")
         "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        ("j" "Journal" entry (file+datetree journal-file)
         "* %?\n%U\n")
        ("E" "Night Shift" entry (file "alices-three-shift.org") 
         "* E Shift\n%t\n")
        ;; ("h" "Habit" entry (file "~/Dropbox/org/refile.org")
        ;;  "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
        )

      ;;     org-capture-templates
      ;;     '(("u" "TODO: Read this URL" entry (file+datetree "reading.org")
      ;;        "* UNREAD %(format-time-string \"%H:%M\") [[%^{URL}][%^{Description}]]"
      ;;        :immediate-finish t)
      ;;       ("r" "GTD: Reply this mail" entry (file+headline "newgtd.org" "Tasks")
      ;;        "* TODO Reply mail from %:fromname %^g\n  %a")
      ;;       ("t" "GTD: New task" entry (file+headline "newgtd.org" "Tasks")
      ;;        "* TODO %^{Brief Description} %^g\n  %?")
      ;;       ("p" "GTD: New project" entry (file+headline "newgtd.org" "Projects")
      ;;        "* %^{Brief Description}")
      ;;       ("i" "GTD: In-Basket" entry (file+headline "newgtd.org" "In-Basket")
      ;;        "* %^{Brief Description}")
      ;;       ("c" "Contacts" entry (file "contacts.org")
      ;;        "* %(org-contacts-template-name)
      ;; :PROPERTIES:
      ;; :EMAIL:    %(org-contacts-template-email)
      ;; :END:"))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 7 Refiling Tasks from norang
      ;;
      ;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
      org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)
                           (journal-file :maxlevel . 9))

      ;; org-refile-targets '(("newgtd.org" :maxlevel . 1)
      ;;                      ("someday.org" :level . 2))

      ;; Use full outline paths for refile targets - we file directly with IDO
      ;; org-refile-use-outline-path t

      ;; Targets complete directly with IDO
      org-outline-path-complete-in-steps nil

      ;; Allow refile to create parent tasks with confirmation
      org-refile-allow-creating-parent-nodes (quote confirm)

      ;; Use IDO for both buffer and file completion and ido-everywhere to t
      org-completion-use-ido t
      ido-everywhere t
      ido-max-directory-size 100000

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 8 Custom agenda views from norang
      ;; Custom agenda views are used for:

      ;;    Single block agenda shows the following
      ;;        overview of today
      ;;        Finding tasks to be refiled
      ;;        Finding stuck projects
      ;;        Finding NEXT tasks to work on
      ;;        Show all related tasks
      ;;        Reviewing projects
      ;;        Finding tasks waiting on something
      ;;        Findings tasks to be archived
      ;;    Finding notes
      ;;    Viewing habits

      ;; Do not dim blocked tasks
      ;; org-agenda-dim-blocked-tasks nil

      ;; Compact the block agenda view
      ;; org-agenda-compact-blocks t


      ;; Custom agenda command definitions
      org-agenda-custom-commands
      '(("p" . "Projects")
        ("pp" "All Projects"
         ((tags "PROJECT")))
        ("ph" "Home Projects"
         ((tags "PROJECT+HOME")))
        ("po" "Office Projects"
         ((tags "PROJECT+OFFICE")))
        ("h" "Office and Home Lists"
         ((agenda)
          (tags-todo "SCG30")
          (tags-todo "SCG25")
          (tags-todo "SCG21")
          (tags-todo "SCGE")
          (tags-todo "HOME")
          (tags-todo "GTD")
          (tags-todo "READING")
          (tags-todo "ELEARNING")))
        ("d" "Daily Action List"
         ((agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       '((agenda time-up priority-down tag-up)))
                      (org-deadline-warning-days 0)))))

        ("N" "Notes" tags "NOTE"
         ((org-agenda-overriding-header "Notes")
          (org-tags-match-list-sublevels t)))
        ("H" "Habits" tags-todo "STYLE=\"habit\""
         ((org-agenda-overriding-header "Habits")
          (org-agenda-sorting-strategy
           '(todo-state-down effort-up category-keep))))
        (" " "Agenda"
         ((agenda "" nil)
          (tags "REFILE"
                ((org-agenda-overriding-header "Tasks to Refile")
                 (org-tags-match-list-sublevels nil)))
          (tags-todo "-CANCELLED/!"
                     ((org-agenda-overriding-header "Stuck Projects")
                      (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
          (tags-todo "-WAITING-CANCELLED/!NEXT"
                     ((org-agenda-overriding-header "Next Tasks")
                      (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
                      (org-agenda-todo-ignore-scheduled t)
                      (org-agenda-todo-ignore-deadlines t)
                      (org-agenda-todo-ignore-with-date t)
                      (org-tags-match-list-sublevels t)
                      (org-agenda-sorting-strategy
                       '(todo-state-down effort-up category-keep))))
          (tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
                     ((org-agenda-overriding-header "Tasks")
                      (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
                      (org-agenda-todo-ignore-scheduled t)
                      (org-agenda-todo-ignore-deadlines t)
                      (org-agenda-todo-ignore-with-date t)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "-HOLD-CANCELLED/!"
                     ((org-agenda-overriding-header "Projects")
                      (org-agenda-skip-function 'bh/skip-non-projects)
                      (org-agenda-sorting-strategy
                       '(category-keep))))
          (tags-todo "-CANCELLED+WAITING/!"
                     ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                      (org-agenda-skip-function 'bh/skip-stuck-projects)
                      (org-tags-match-list-sublevels nil)
                      (org-agenda-todo-ignore-scheduled 'future)
                      (org-agenda-todo-ignore-deadlines 'future)))
          (tags "-REFILE/"
                ((org-agenda-overriding-header "Tasks to Archive")
                 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                 (org-tags-match-list-sublevels nil))))
         nil)
        ("R" "Tasks to Refile" tags "REFILE"
         ((org-agenda-overriding-header "Tasks to Refile")
          (org-tags-match-list-sublevels nil)))
        ("#" "Stuck Projects" tags-todo "-CANCELLED/!"
         ((org-agenda-overriding-header "Stuck Projects")
          (org-agenda-skip-function 'bh/skip-non-stuck-projects)))
        ("T" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
         ((org-agenda-overriding-header "Next Tasks")
          (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
          (org-agenda-todo-ignore-scheduled t)
          (org-agenda-todo-ignore-deadlines t)
          (org-agenda-todo-ignore-with-date t)
          (org-tags-match-list-sublevels t)
          (org-agenda-sorting-strategy
           '(todo-state-down effort-up category-keep))))
        ("S" "Tasks" tags-todo "-REFILE-CANCELLED/!-HOLD-WAITING"
         ((org-agenda-overriding-header "Tasks")
          (org-agenda-skip-function 'bh/skip-project-tasks-maybe)
          (org-agenda-sorting-strategy
           '(category-keep))))
        ("P" "Projects" tags-todo "-HOLD-CANCELLED/!"
         ((org-agenda-overriding-header "Projects")
          (org-agenda-skip-function 'bh/skip-non-projects)
          (org-agenda-sorting-strategy
           '(category-keep))))
        ("W" "Waiting Tasks" tags-todo "-CANCELLED+WAITING/!"
         ((org-agenda-overriding-header "Waiting and Postponed tasks"))
         (org-tags-match-list-sublevels nil))
        ("A" "Tasks to Archive" tags "-REFILE/"
         ((org-agenda-overriding-header "Tasks to Archive")
          (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
           (org-tags-match-list-sublevels nil)))
        )

      org-stuck-projects (quote ("" nil nil ""))
      ;; org-agenda-custom-commands
      ;; '(("p" . "Projects")
      ;;   ("pp" "All Projects"
      ;;    ((tags "PROJECT")))
      ;;   ("ph" "Home Projects"
      ;;    ((tags "PROJECT+HOME")))
      ;;   ("po" "Office Projects"
      ;;    ((tags "PROJECT+OFFICE")))
      ;;   ("h" "Office and Home Lists"
      ;;    ((agenda)
      ;;     (tags-todo "OFFICE")
      ;;     (tags-todo "HOME")
      ;;     (tags-todo "READING")))
      ;;   ("d" "Daily Action List"
      ;;    ((agenda "" ((org-agenda-ndays 1)
      ;;                 (org-agenda-sorting-strategy
      ;;                  '((agenda time-up priority-down tag-up)))
      ;;                 (org-deadline-warning-days 0))))))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 9 Time Clocking from norang
      ;;
      ;;
      ;; Show lot sof clocking history so it's easy to pick items off the C-F11 list
      ;;org-clock-history-length 36
      
      ;; Resume clocking task on clock-in if the clock is open
      ;;org-clock-in-resume t
      
      ;; Change tasks to NEXT when clocking in
      ;;org-clock-in-switch-to-state 'bh/clock-in-to-next

      ;; Separate drawers for clocking and logs
      ;;org-drawers (quote ("PROPERTIES" "LOGBOOK"))

      ;; Save clock data and state changes and notes in the LOGBOOK drawer
      ;;org-clock-into-drawer t

      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      ;;org-clock-out-remove-zero-time-clocks t

      ;; Clock out when moving task to a done state
      ;;org-clock-out-when-done t

      ;; Save the running clock and all clock history when exiting Emacs, load it on startup
      ;;org-clock-persist t

      ;; Do not prompt to resume an active clock
      ;;org-clock-persist-query-resume nil

      ;; Enable auto clock resolution for finding open clocks
      ;;org-clock-auto-clock-resolution (quote when-no-clock-is-running)

      ;; Include current clocking task in clock reports
      ;;org-clock-report-include-clocking-task t

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 10 Time reporting and tracking from norang
      ;;
      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      org-clock-out-remove-zero-time-clocks t
      ;; Agenda clock report parameters
      org-agenda-clockreport-parameter-plist '(:link t :maxlevel 5 :fileskip0 t :compact t :narrow 80)
      ;; Set default column view headings: Task Effort Clock_Summary
      org-columns-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM"
      ;; global Effort estimate values
      ;; global STYLE property values for completion
      org-global-properties '(("Effort_ALL" . "0:15 0:30 0:45 1:00 2:00 3:00 4:00 5:00 6:00 0:00")
                              ("STYLE_ALL" . "habit"))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 11 Tags from norang
      ;;      
      ;; filtering todo lists and agenda views
      ;; providing context for tasks
      ;; tagging notes
      ;; tagging phone calls
      ;; tagging tasks to be refiled
      ;; tagging tasks in a WAITING state because a parent task is WAITING
      ;; tagging cancelled tasks because a parent task is CANCELLED
      ;; preventing export of some subtrees when publishing

      ;; Tags with fast selection keys
      ;; org-tag-alist '((:startgroup)
      ;;                 ("@OFFICE" . ?o)
      ;;                 ("@HOME" . ?h)
      ;;                 ("@CAFE" . ?c)
      ;;                 (:endgroup)
      ;;                 ;; ("WAITING" . ?W)
      ;;                 ;; ("HOLD" . ?H)
      ;;                 ;; ("READING" . ?R)
      ;;                 ;; ("PERSONAL" . ?P)
      ;;                 ;; ("WORK" . ?W)
      ;;                 ;; ("CANCELLED" . ?C)
      ;;                 )
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      ;; org-stuck-projects '(
      ;;                      "+PROJECT/-MAYBE-DONE" ("NEXT" "TODO") 
      ;;                      ("@SHOP") "\\<IGNORE\\>")
)

;; (ido-mode (quote both))
     
;; Custom Key Bindings
(global-set-key (kbd "<f12> a") 'org-agenda)
;; (global-set-key (kbd "<f12> I") 'bh/punch-in)
;; (global-set-key (kbd "<f12> O") 'bh/punch-out)
(global-set-key (kbd "C-M-r") 'org-capture)

;; For Org Mode
(add-hook 'org-mode-hook (lambda () (org-indent-mode)))

(setq bh/keep-clock-running nil)

(defun bh/clock-in-to-next (kw)
  "Switch a task from TODO to NEXT when clocking in.
Skips capture tasks, projects, and subprojects.
Switch projects and subprojects from NEXT back to TODO"
  (when (not (and (boundp 'org-capture-mode) org-capture-mode))
    (cond
     ((and (member (org-get-todo-state) (list "TODO"))
           (bh/is-task-p))
      "NEXT")
     ((and (member (org-get-todo-state) (list "NEXT"))
           (bh/is-project-p))
      "TODO"))))

(defun bh/find-project-task ()
  "Move point to the parent (project) task if any"
  (save-restriction
    (widen)
    (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
      (while (org-up-heading-safe)
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq parent-task (point))))
      (goto-char parent-task)
      parent-task)))

(defun bh/punch-in (arg)
  "Start continuous clocking and set the default task to the
selected task.  If no task is selected set the Organization task
as the default task."
  (interactive "p")
  (setq bh/keep-clock-running t)
  (if (equal major-mode 'org-agenda-mode)
      ;;
      ;; We're in the agenda
      ;;
      (let* ((marker (org-get-at-bol 'org-hd-marker))
             (tags (org-with-point-at marker (org-get-tags-at))))
        (if (and (eq arg 4) tags)
            (org-agenda-clock-in '(16))
          (bh/clock-in-organization-task-as-default)))
    ;;
    ;; We are not in the agenda
    ;;
    (save-restriction
      (widen)
      ; Find the tags on the current task
      (if (and (equal major-mode 'org-mode) (not (org-before-first-heading-p)) (eq arg 4))
          (org-clock-in '(16))
        (bh/clock-in-organization-task-as-default)))))

(defun bh/punch-out ()
  (interactive)
  (setq bh/keep-clock-running nil)
  (when (org-clock-is-active)
    (org-clock-out))
  (org-agenda-remove-restriction-lock))

(defun bh/clock-in-default-task ()
  (save-excursion
    (org-with-point-at org-clock-default-task
      (org-clock-in))))

(defun bh/clock-in-parent-task ()
  "Move point to the parent (project) task if any and clock in"
  (let ((parent-task))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (not parent-task) (org-up-heading-safe))
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (if parent-task
            (org-with-point-at parent-task
              (org-clock-in))
          (when bh/keep-clock-running
            (bh/clock-in-default-task)))))))

(defvar bh/organization-task-id "eb155a82-92b2-4f25-a3c6-0304591af2f9")

(defun bh/clock-in-organization-task-as-default ()
  (interactive)
  (org-with-point-at (org-id-find bh/organization-task-id 'marker)
    (org-clock-in '(16))))

(defun bh/clock-out-maybe ()
  (when (and bh/keep-clock-running
             (not org-clock-clocking-in)
             (marker-buffer org-clock-default-task)
             (not org-clock-resolving-clocks-due-to-idleness))
    (bh/clock-in-parent-task)))

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)

;; these function coming from norang
(defun bh/is-project-p ()
  "Any task with a todo keyword subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task has-subtask))))

(defun bh/is-project-subtree-p ()
  "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
  (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                              (point))))
    (save-excursion
      (bh/find-project-task)
      (if (equal (point) task)
          nil
        t))))

(defun bh/is-task-p ()
  "Any task with a todo keyword and no subtask"
  (save-restriction
    (widen)
    (let ((has-subtask)
          (subtree-end (save-excursion (org-end-of-subtree t)))
          (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
      (save-excursion
        (forward-line 1)
        (while (and (not has-subtask)
                    (< (point) subtree-end)
                    (re-search-forward "^\*+ " subtree-end t))
          (when (member (org-get-todo-state) org-todo-keywords-1)
            (setq has-subtask t))))
      (and is-a-task (not has-subtask)))))

(defun bh/is-subproject-p ()
  "Any task which is a subtask of another project"
  (let ((is-subproject)
        (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
    (save-excursion
      (while (and (not is-subproject) (org-up-heading-safe))
        (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
          (setq is-subproject t))))
    (and is-a-task is-subproject)))

(defun bh/list-sublevels-for-projects-indented ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels 'indented)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/list-sublevels-for-projects ()
  "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
  This is normally used by skipping functions where this variable is already local to the agenda."
  (if (marker-buffer org-agenda-restrict-begin)
      (setq org-tags-match-list-sublevels t)
    (setq org-tags-match-list-sublevels nil))
  nil)

(defun bh/skip-stuck-projects ()
  "Skip trees that are not stuck projects"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                nil
              next-headline)) ; a stuck project, has subtasks but no next task
        nil))))

(defun bh/skip-non-stuck-projects ()
  "Skip trees that are not stuck projects"
  (bh/list-sublevels-for-projects-indented)
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (if (bh/is-project-p)
          (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                 (has-next ))
            (save-excursion
              (forward-line 1)
              (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                (unless (member "WAITING" (org-get-tags-at))
                  (setq has-next t))))
            (if has-next
                next-headline
              nil)) ; a stuck project, has subtasks but no next task
        next-headline))))

(defun bh/skip-non-projects ()
  "Skip trees that are not projects"
  (bh/list-sublevels-for-projects-indented)
  (if (save-excursion (bh/skip-non-stuck-projects))
      (save-restriction
        (widen)
        (let ((subtree-end (save-excursion (org-end-of-subtree t))))
          (cond
           ((and (bh/is-project-p)
                 (marker-buffer org-agenda-restrict-begin))
            nil)
           ((and (bh/is-project-p)
                 (not (marker-buffer org-agenda-restrict-begin))
                 (not (bh/is-project-subtree-p)))
            nil)
           (t
            subtree-end))))
    (save-excursion (org-end-of-subtree t))))

(defun bh/skip-project-trees-and-habits ()
  "Skip trees that are projects"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits-and-single-tasks ()
  "Skip trees that are projects, tasks that are habits, single non-project tasks"
  (save-restriction
    (widen)
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
      (cond
       ((org-is-habit-p)
        next-headline)
       ((bh/is-project-p)
        next-headline)
       ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
        next-headline)
       (t
        nil)))))

(defun bh/skip-project-tasks-maybe ()
  "Show tasks related to the current restriction.
When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
When not restricted, skip project and sub-project tasks, habits, and project related tasks."
  (save-restriction
    (widen)
    (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
           (next-headline (save-excursion (or (outline-next-heading) (point-max))))
           (limit-to-project (marker-buffer org-agenda-restrict-begin)))
      (cond
       ((bh/is-project-p)
        next-headline)
       ((org-is-habit-p)
        subtree-end)
       ((and (not limit-to-project)
             (bh/is-project-subtree-p))
        subtree-end)
       ((and limit-to-project
             (bh/is-project-subtree-p)
             (member (org-get-todo-state) (list "NEXT")))
        subtree-end)
       (t
        nil)))))

(defun bh/skip-projects-and-habits ()
  "Skip trees that are projects and tasks that are habits"
  (save-restriction
    (widen)
    (let ((subtree-end (save-excursion (org-end-of-subtree t))))
      (cond
       ((bh/is-project-p)
        subtree-end)
       ((org-is-habit-p)
        subtree-end)
       (t
        nil)))))

(defun bh/skip-non-subprojects ()
  "Skip trees that are not projects"
  (let ((next-headline (save-excursion (outline-next-heading))))
    (if (bh/is-subproject-p)
        nil
      next-headline)))

(provide 'rc-org)
;; rc-org.el ends
