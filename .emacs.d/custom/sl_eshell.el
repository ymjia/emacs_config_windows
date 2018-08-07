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
      (cond
       ((eq major-mode 'eshell-mode)
	(write-region (concat (buffer-name bi) "\n") nil filename 'append)
	(write-region (concat (file-name-directory list-buffers-directory) "\n") nil filename 'append)
	);eq
       );if
      );with current
    );dolist
  ) ;function

;; @brief open eshell saved in file
;; @param filename filename
(defun load_eshell (filePath)
  "load and create eshell buffer according to filePath."
  ;read from file
  (with-temp-buffer
    (insert-file-contents filePath)
    (setq es_list (split-string (buffer-string) "\n" t))
    )
  (setq es_num (length es_list))
  (setq es_i 0)
  ;create eshell buffer from file
  (while (< es_i es_num)
    (setq buf_name (nth es_i es_list))
    (setq buf_path (nth (1+ es_i) es_list))
    (cond ((and buf_name buf_path)
	 (create_es buf_name buf_path)))
    (setq es_i (+ 2 es_i))
    );while
  )
