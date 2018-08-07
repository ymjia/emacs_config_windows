;; @file sl_eshell.el
;; @brief save/load eshell buffer
;; @author jiayanming

(defun create_es(name path)
  "create a eshell with buffer name, change directory to path"
  (setq es (eshell))
  (with-current-buffer (buffer-name es)
    (rename-buffer name)
    (insert (concat "cd " path))
    (eshell-send-input))
  )

(create_es "es" "d:/tmp")

(defun es_info(buffer)
  "get eshell name and path "
  (with-current-buffer (buffer-name buffer)
    (setq str (format "%s" major-mode))

    (if (file-name-directory list-buffers-directory)
	(setq fn (format "%s" (file-name-directory list-buffers-directory)))
      )
    )
  (message fn)
  )

					;(message (mapconcat (function buffer-name) (buffer-list) " "))
(message (mapconcat (function es_info) (buffer-list) " "))





