
;; manage your window size with interactively mode.
;; (when (fboundp 'windresize)
;;  (require 'windresize))
(require 'windresize)

;; use C-c <Left> and C-c <Right> to Undo/Redo window layout.
(when (fboundp 'winner-mode) 
  (winner-mode 1))
;; (winner-mode 1)

(provide 'rc-wind-mgmt)
