;; for Fill Column Indicator

(require 'fill-column-indicator)

(add-hook 'prog-mode-hook
          (lambda ()
            (when (boundp 'fci-mode)
              (setq fci-rule-width 7)
              (setq fci-rule-color "red")
              (setq fci-rule-column 80)
              (fci-mode 1)
)))

(provide 'rc-fci)

