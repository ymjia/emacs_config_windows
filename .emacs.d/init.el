0;136;0c; guess dired operation target


;;========================================#
;; ;;gdb
;; (global-set-key [f9] 'compile)
;; (add-hook
;;  'gdb-mode-hook '
;;  (lambda ()
;;    (define-key c-mode-base-map [(f5)] 'gud-go)
;;    (define-key c-mode-base-map [(f7)] 'gud-step)
;;    (define-key c-mode-base-map [(f8)] 'gud-next)))
;==================hotkeys========================
(global-set-key (kbd "C-j") 'goto-line)
(global-set-key [f11] 'my-fullscreen) ;启动全屏的快捷键


;; 用ibuffer代替默认的buffer switch
;; 参考 http://www.emacswiki.org/emacs/IbufferMode
;; 按 g 刷新文件目录      
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;函数名显示在mode-line上
(which-function-mode 1)

;; line number
(setq column-number-mode t)
(global-linum-mode t)

;; data and time
(setq display-time-day t
      display-time-24hr-format t)
(display-time)

;; toolbar
(setq tool-bar-map (make-sparse-keymap))

;;==================================#
;; ;;C/C++语言启动时自动加载semantic对/usr/include的索引数据库
;; (setq semanticdb-search-system-databases t)
;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;; 	    (setq semanticdb-project-system-databases
;; 		  (list (semanticdb-create-database
;; 			 semanticdb-new-database-class
;; 			 "/usr/include")))))

;(set-foreground-color "grey")
;(set-background-color "black")
(set-cursor-color "gold1")
(set-mouse-color "gold1")

(customize-set-variable 'scroll-bar-mode 'right)
(setq frame-title-format  
      '("%S" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;refresh buffer
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )
(global-set-key [f5] 'refresh-file)
;;==================================

;==============3rd======================
(add-to-list 'load-path' "~/.emacs.d/3rd")
(put 'dired-find-alternate-file 'disabled nil)
;;dired+
(require 'dired+)
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(put 'downcase-region 'disabled nil)

;==============settings added by emacs custom=============
(custom-set-variables
 '(case-fold-search nil)
 '(column-number-mode t)
 '(display-time-mode t)
 '(ls-lisp-verbosity nil))
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :foundry "outline" :family "Consolas")))))


;==================customizations=====================
;; Disable all version control(for speed)
(setq vc-handled-backends nil)

;; start server for other program open in existing window
;; *for this purpose,
;;    add ENV : EMACS_SERVER_FILE=~/.emacs.d/server/server
;; *if enconter .emacs.d/server is unsafe(windows)
;;    set directory .emacs.d property->security->advinced->owner to current user
(server-start)

;;useful copy to dir specified by another buffer
;;open 2 dir in split window, C to copy files to the other
(setq dired-dwim-target t)


;;time stamp
(defun insert-time-stamp()
  (interactive)
  (let ((hour (nth 2 (decode-time)))
	(sec (nth 0 (decode-time)))
	(min (nth 1 (decode-time)))
	(day (nth 3 (decode-time)))
	(mon (nth 4 (decode-time)))
	(year (nth 5 (decode-time))))
    (insert (format "%d/%d/%d %d:%d:%d" year mon day hour min sec))
    )
  )
(global-set-key (kbd "C-x t") 'insert-time-stamp)

;;open windows explorer in place
(defun open-buffer-path ()
  "Run explorer on the directory of the current buffer."
  (interactive)
  (if buffer-file-name
      (browse-url(concat "file://" (file-name-directory buffer-file-name) ))
    (browse-url(concat "file://" (file-name-directory list-buffers-directory)))
    )
  )
(global-set-key (kbd "C-x e") 'open-buffer-path)

;;set dired column required
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)

;;save load buffer
(desktop-save-mode 1)
(setq desktop-restore-frames t)
(setq desktop-restore-in-current-display t)
(setq desktop-restore-forces-onscreen nil)

;;save load eshell buffers
(add-to-list 'load-path' "~/.emacs.d/custom")
(require 'sl_eshell)
;save eshell before exit
(add-hook 'kill-emacs-hook (lambda () (write_es_info "~/.emacs.d/save_es.el")))
;load after startup
(load_eshell "~/.emacs.d/save_es.el")

;;maximize window
(toggle-frame-maximized)
