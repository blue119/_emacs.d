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

(setq org-agenda-files '("~/Dropbox/org/newgtd.org" 
                         "~/Dropbox/org/refile.org"
                         "~/Dropbox/org/gCalendar.org"
                         "~/Dropbox/org/ruks.org"
                         "~/Dropbox/org/ruks-scg2.org"
                         "~/Dropbox/org/ruks-scg3.org"
                         "~/Dropbox/org/alices-three-shift.org"
                         "~/Dropbox/org/Diary.org"
                         )
      org-agenda-diary-file "~/Dropbox/org/Diary.org" 
      org-agenda-include-diary t
      org-agenda-skip-scheduled-if-done t


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
      org-agenda-dim-blocked-tasks nil

      ;; Compact the block agenda view
      org-agenda-compact-blocks t
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-deadline-prewarning-if-scheduled t

      ;; Custom agenda command definitions
      org-agenda-custom-commands
      '(;("p" . "Projects")
        ;("pp" "All Projects"
        ; ((tags "PROJECT")))
        ;("ph" "Home Projects"
        ; ((tags "PROJECT+HOME")))
        ;("po" "Office Projects"
        ; ((tags "PROJECT+OFFICE")))

        ("o" "Office Lists"
         ((agenda)
          (tags-todo "SCGE")
          (tags-todo "SCG30")
          (tags-todo "SIDE_JOB+COV")
          (tags-todo "SIDE_JOB-COV")
          (tags-todo "SCG25")
          (tags-todo "SCG21")
          (tags-todo "RKUS+MISC")
          (tags-todo "RUKS-MISC")))

        ("h" "Home Lists"
         ((agenda)
          (tags-todo "HOME")
          (tags-todo "GTD")
          (tags-todo "LEARN")
          ))

        ("w" "Whole Lists"
         ((agenda)
          (tags-todo "SCGE")
          (tags-todo "SCG30")
          (tags-todo "COV")
          (tags-todo "SCG25")
          (tags-todo "SCG21")
          (tags-todo "HOME")
          (tags-todo "GTD")
          (tags-todo "READING")
          (tags-todo "ELEARNING")))
        
        ("r" "Tasks to Refile" tags "REFILE"
         ((org-agenda-overriding-header "Tasks to Refile")
          (org-tags-match-list-sublevels nil)))
        
        ; ("H" "Habits" tags-todo "STYLE=\"habit\""
        ;  ((org-agenda-overriding-header "Habits")
        ;   (org-agenda-sorting-strategy
        ;    '(todo-state-down effort-up category-keep))))

        ("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))

        (" " "Agenda"
         ((agenda "" nil)
          (tags "REFILE"
                ((org-agenda-overriding-header "Tasks to Refile")
                 (org-tags-match-list-sublevels nil)))
          
          (tags "-REFILE-HOME/!NEXT"
                ((org-agenda-overriding-header "Office Next Tasks")
                 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                 (org-tags-match-list-sublevels nil)))

          (tags "-REFILE-RKS/!NEXT"
                ((org-agenda-overriding-header "Home Next Tasks")
                 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                 (org-tags-match-list-sublevels nil)))

          (tags-todo "-REFILE-HOME/-NEXT"
                ((org-agenda-overriding-header "Office Tasks")
                 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                 (org-tags-match-list-sublevels nil)))

          (tags-todo "-REFILE-RKS/-NEXT"
                ((org-agenda-overriding-header "HOME Tasks")
                 (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                 (org-tags-match-list-sublevels nil)))
                    
          ; (tags "/!NEXT"
          ;            ((org-agenda-overriding-header (concat "Project Next Tasks"
          ;                                                   (if bh/hide-scheduled-and-waiting-next-tasks
          ;                                                       ""
          ;                                                     " (including WAITING and SCHEDULED tasks)")))
          ;             (org-agenda-skip-function 'bh/skip-projects-and-habits-and-single-tasks)
          ;             (org-tags-match-list-sublevels t)
          ;             (org-agenda-todo-ignore-scheduled bh/hide-scheduled-and-waiting-next-tasks)
          ;             (org-agenda-todo-ignore-deadlines bh/hide-scheduled-and-waiting-next-tasks)
          ;             (org-agenda-todo-ignore-with-date bh/hide-scheduled-and-waiting-next-tasks)
          ;             (org-agenda-sorting-strategy
          ;              '(todo-state-down effort-up category-keep))))
          ; 
          ; (tags "-REFILE/"
          ;       ((org-agenda-overriding-header "Tasks to Archive")
          ;        (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
          ;        (org-tags-match-list-sublevels nil)))
         ))))

(setq org-use-fast-todo-selection t
      org-treat-S-cursor-todo-selection-as-state-change nil

      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))

      org-todo-keyword-faces '(("TODO" :foreground "red" :weight bold)
                               ("NEXT" :foreground "blue" :weight bold)
                               ("DONE" :foreground "forest green" :weight bold)
                               ("WAITING" :foreground "orange" :weight bold)
                               ("HOLD" :foreground "magenta" :weight bold)
                               ("CANCELLED" :foreground "forest green" :weight bold)
                               ("MEETING" :foreground "forest green" :weight bold)
                               ("PHONE" :foreground "forest green" :weight bold))
      
      ;; Moving a task to CANCELLED adds a CANCELLED tag
      ;; Moving a task to WAITING adds a WAITING tag
      ;; Moving a task to HOLD adds WAITING and HOLD tags
      ;; Moving a task to a done state removes WAITING and HOLD tags
      ;; Moving a task to TODO removes WAITING, CANCELLED, and HOLD tags
      ;; Moving a task to NEXT removes WAITING, CANCELLED, and HOLD tags
      ;; Moving a task to DONE removes WAITING, CANCELLED, and HOLD tags
      org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                     ("WAITING" ("WAITING" . t))
                                     ("HOLD" ("WAITING" . t) ("HOLD" . t))
                                     (done ("WAITING") ("HOLD"))
                                     ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                                     ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                                     ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))
 )

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Ch 6 Adding New Tasks Quickly with Org Capture from norang
      ;;
      ;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates 
      '(("t" "New task" entry (file "refile.org")
         "* TODO %^{Brief Description} %^g\n%?\n%U\n")

        ("i" "Interrupt" entry (file "refile.org")
         "* TODO %^{Brief Description} %?\n%U\n" :clock-in t :clock-resume t)

        ("d" "Date" entry (file "refile.org")
         "* %^{Brief} \n%?\n%U\n")

        ; ("r" "respond" entry (file "~/Dropbox/org/refile.org")l
        ;  "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        
        ; ("n" "note" entry (file "~/Dropbox/org/refile.org")
        ;  "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
        
        ("j" "Journal" entry (file+datetree journal-file)
         "* %?\n%U\n")
        
        ("E" "Night Shift" entry (file "alices-three-shift.org") 
         "* E Shift\n%t\n")

        ; ("h" "Habit" entry (file "~/Dropbox/org/refile.org")
        ;  "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n")
        ; )
        )
      )

(setq org-directory "~/Dropbox/org"
      org-default-notes-file (concat org-directory "/refile.org")
      journal-file "~/Dropbox/org/journal.org"
      org-log-done 'time
      org-log-into-drawer "LOGBOOK"
      org-clock-into-drawer "CLOCK"
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 7 Refiling Tasks from norang
      ;;
      ;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
      org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)
                           (journal-file :maxlevel . 9))

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
      org-stuck-projects (quote ("" nil nil ""))
            
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
      org-tag-alist '((:startgroup)
                      ("@OFFICE" . ?o)
                      ("@HOME" . ?h)
                      ("@CAFE" . ?c)
                      (:endgroup)
                      ("WAITING" . ?W)
                      ("HOLD" . ?H)
                      ("READING" . ?R)
                      ("PERSONAL" . ?P)
                      ("WORK" . ?W)
                      ("CANCELLED" . ?C)
                      )

      ; Allow setting single tags without the menu
      org-fast-tag-selection-single-key (quote expert)
      ; For tag searches ignore tasks with scheduled and deadline dates
      org-agenda-tags-todo-honor-ignore-options t
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      ;; org-stuck-projects '(
      ;;                      "+PROJECT/-MAYBE-DONE" ("NEXT" "TODO") 
      ;;                      ("@SHOP") "\\<IGNORE\\>")
)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; 9 Time Clocking from norang
      ;;
      ;;

      ;; Resume clocking task when emacs is restarted
      (org-clock-persistence-insinuate)
      ;; Show lot of clocking history so it's easy to pick items off the C-F11 list
      (setq org-clock-history-length 23)
      ;; Resume clocking task on clock-in if the clock is open
      (setq org-clock-in-resume t)
      ;; Change tasks to NEXT when clocking in
      (setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
      ;; Separate drawers for clocking and logs
      (setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
      ;; Save clock data and state changes and notes in the LOGBOOK drawer
      (setq org-clock-into-drawer t)
      ;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
      (setq org-clock-out-remove-zero-time-clocks t)
      ;; Clock out when moving task to a done state
      (setq org-clock-out-when-done t)
      ;; Save the running clock and all clock history when exiting Emacs, load it on startup
      (setq org-clock-persist t)
      ;; Do not prompt to resume an active clock
      (setq org-clock-persist-query-resume nil)
      ;; Enable auto clock resolution for finding open clocks
      (setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
      ;; Include current clocking task in clock reports
      (setq org-clock-report-include-clocking-task t)
      
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

      (defun bh/clock-in-default-task ()
        (save-excursion
          (org-with-point-at org-clock-default-task
            (org-clock-in))))
     
;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<S-f5>") 'bh/widen)
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)
(global-set-key (kbd "<f9> w") 'widen)

(global-set-key (kbd "<f9> I") 'bh/punch-in)
(global-set-key (kbd "<f9> O") 'bh/punch-out)

(global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "C-c c") 'org-capture)

; Hide other tasks
(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)


;; For Org Mode
(add-hook 'org-mode-hook (lambda () (org-indent-mode)))

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

(defvar bh/hide-scheduled-and-waiting-next-tasks t)

(defun bh/toggle-next-task-display ()
  (interactive)
  (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
  (when  (equal major-mode 'org-agenda-mode)
    (org-agenda-redo))
  (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))

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
