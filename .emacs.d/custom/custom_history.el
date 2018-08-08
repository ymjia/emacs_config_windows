;; @file custom_history.el
;; @brief save special command history
;; @author jiayanming

;; @brief 
(defun save_history(f)
  (setq h_list minibuffer-history)
  (message "len: %d" (length h_list))
  (dolist (hi h_list)
    (setq cmd (nth 0 (split-string hi)))
    (message "%s " cmd)
    )
  )

(provide 'custom_history)
