;; @file custom_history.el
;; @brief save special command history
;; @author jiayanming

(defvar ignore_pfx_list
      (list "cd " "ls" "ls " "git st" ))
(defvar cmd_list nil)

(defun save_history_on_exit()
  "commit to history items to cmd_list"
  (get_es_command (current-buffer))
  )

(defun update_global_history()
  "update current eshell history from global history list"
  ;merge to global list
  (get_es_command (current-buffer))
  ;checkout from global list
  (dolist (cmd cmd_list)
    (setq save_item t)
    (let* ((ring eshell-history-ring)
	   (index (ring-length ring)))
      (while (> index 0)
	(setq index (1- index))
	(cond ((string= cmd (ring-ref ring index))
	       (setq save_item nil)
	       (setq index 0)))
	)
      )
    (cond (save_item
	  (eshell-put-history cmd)))
    )
  )


(defun get_es_command(bi)
  "save command history in current es list "
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
  (setq file eshell-history-file-name)
  (dolist (bi (buffer-list))
    (get_es_command bi)
    )
  (setq index (length cmd_list))
  (with-temp-buffer
    (while (> index 0)
      (setq index (1- index))
      (let ((start (point)))
	(insert (nth index cmd_list) ?\n)
	(subst-char-in-region start (1- (point)) ?\n ?\177)))
    (eshell-with-private-file-modes
     (write-region "" nil file)
     (write-region (point-min) (point-max) file 'append
		   'no-message)))
  )

(provide 'custom_history)

