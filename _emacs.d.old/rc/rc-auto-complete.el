
(require 'auto-complete)

(when (fboundp 'global-auto-complete-mode)
  (global-auto-complete-mode 1)
  (setq-default ac-sources '(
                             ac-source-words-in-same-mode-buffers 
                             ac-source-filename))
  )

(provide 'rc-auto-complete)
