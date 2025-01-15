
(add-hook 'python-mode-hook
            (lambda () 
              (define-abbrev-table 'python-mode-abbrev-table
                '(
                  ("iii" "import IPython; IPython.embed()")
                  ("ddd" "import pdb; pdb.set_trace()")
                  ))
              (abbrev-mode 1)
              ))

(provide 'rc-python)

