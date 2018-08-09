;; @file custom_history.el
;; @brief save special command history
;; @author jiayanming

(setq ignore_pfx_list
      (list "cd " "ls" "ls " "git st" ))

(dolist (igi ignore_pfx_list)
  (message "%s" igi)
  )

(defun get_es_command(bi cmd_list)
  "save command history in current es list "
  (dolist (bi cmd_list)
    (message "%s" bi)
    )

  (with-current-buffer (buffer-name bi)
    (cond ((eq major-mode 'eshell-mode)
	   (let* ((ring eshell-history-ring)
		  (index (ring-length ring)))
	     (while (> index 0)
	       (setq index (1- index))
	       (setq cmd (ring-ref ring index))
	       ;ignore if start with ignore_pfx_list
	       (setq save_item t)
	       (dolist (igi ignore_pfx_list)
		 (setq prefix (substring cmd
			 0 (min(length cmd) (length igi))))
		 (cond ((string= prefix igi)
			(setq save_item nil)
			))
		 )
	       (cond (save_item
		      ;(message "%d:%s" index cmd)
		      (add-to-list 'cmd_list cmd)
		      ))
	       );while
	     );let
	   )
	  );cond
    ))


;; @brief save command of all eshell buffers
(defun save_es_command_history()
  "save eshell history with filters"
  ;(let file eshell-history-file-name)
  (setq cmd_list '())
  (dolist (bi (buffer-list))
    (get_es_command bi cmd_list)
    )
  
  (dolist (bi cmd_list)
    (message "%s" bi)
    )
  )

(save_es_command_history)
(provide 'custom_history)

