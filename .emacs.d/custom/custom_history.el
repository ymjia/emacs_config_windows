;; @file custom_history.el
;; @brief save special command history
;; @author jiayanming

;; @brief 
(defun save_history(f)
  "save eshell history with filters"
  (dolist (bi (buffer-list))
    (with-current-buffer (buffer-name bi)
      (cond ((eq major-mode 'eshell-mode)
	     ;for eshell buffer
	     (let* ((ring eshell-history-ring)
		    (index (ring-length ring)))
	       (while (> index 0)
		 (setq index (1- index))
		 (message "%d:%s" index (ring-ref ring index))
	       )
	       );let
	     )

	    );cond

    ))
  )
(save_history "")
(provide 'custom_history)
