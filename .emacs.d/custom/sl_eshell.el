;; @file sl_eshell.el
;; @brief save/load eshell buffer
;; @author jiayanming

;; @brief create an eshell
;; @param name buffer name
;; @param path change dir to path
(defun create_es(name path)
  "create a eshell with buffer name, change directory to path"
  (setq es (eshell))
  (with-current-buffer (buffer-name es)
    (rename-buffer name)
    (insert (concat "cd " path))
    (eshell-send-input))
  )

;; @brief write eshell info to file
;; @param filename
(defun write_es_info(filename)
  "get eshell name and path to filename"
  (write-region "" nil filename)
  (dolist (bi (buffer-list))
    (with-current-buffer (buffer-name bi)
      (setq str (format "%s" major-mode))
      (if (string= str "eshell-mode")
	  (write-region (concat (buffer-name bi) " "  (file-name-directory list-buffers-directory) "\n") nil filename 'append)
	)
      )
    )
  )

;; @brief open eshell saved in file
;; @param filename filename




