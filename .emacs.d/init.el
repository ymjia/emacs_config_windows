0;136;0c; guess dired operation target
(setq dired-dwim-target t)

;; Disable all version control(for speed)
(setq vc-handled-backends nil)

;; start server for other program open in existing window
;; for this purpose,
;;    add ENV : EMACS_SERVER_FILE=~/.emacs.d/server/server
;; if enconter .emacs.d/server is unsafe(windows)
;;    set directory .emacs.d property->security->advinced->owner to current user
(server-start)

(global-linum-mode t)

;;#########################################
;;gdb
(global-set-key [f9] 'compile)
(add-hook 'gdb-mode-hook '(lambda ()
                            (define-key c-mode-base-map [(f5)] 'gud-go)
                            (define-key c-mode-base-map [(f7)] 'gud-step)
                            (define-key c-mode-base-map [(f8)] 'gud-next)))

					;##########################################
;;hotkeys
(global-set-key (kbd "s-/") 'comment-region)
(global-set-key (kbd "s-\\") 'uncomment-region)

(global-set-key (kbd "C-j") 'goto-line)

(global-set-key [f11] 'my-fullscreen) ;启动全屏的快捷键




;; 用ibuffer代替默认的buffer switch
;; 参考 http://www.emacswiki.org/emacs/IbufferMode
;; ibuffer是emacs自带的，可用 M-x ibuffer 调出来
;; 下面只是将快捷键 C-x C-b 映射为调出ibuffer的命令
;; 在ibuffer中的操作方式和dired mode一样
;; n和p是上下，m是选中该文件，可选多个，D是kill buffer
;; 回车或者按e(就是edit)来编辑文件
;; 在ibuffer页面，用英文斜线来通过关键字过滤缩小显示文件范围
;; 比如 “ /日记 ” ，就会只显示buffer名称中有日记这两个字的
;; / 后面支持正则表达式 如 /200?
;; 撤销过滤按两下/，就是按 “ // ”
;; 在ibuffer中，按英文等号 “ = ” 对为保存文件和它上一个保存版本做diff 
;; 按 g 刷新文件目录      
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;; ;; line number
(setq column-number-mode t)

;; data and time
(setq display-time-day t
      display-time-24hr-format t)
(display-time)

;; toolbar
(setq tool-bar-map (make-sparse-keymap))

;; deadline
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
;;******************************************

;;###################################
;;C/C++语言启动时自动加载semantic对/usr/include的索引数据库
(setq semanticdb-search-system-databases t)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq semanticdb-project-system-databases
		  (list (semanticdb-create-database
			 semanticdb-new-database-class
			 "/usr/include")))))

(set-foreground-color "grey")
(set-background-color "black")
(set-cursor-color "gold1")
(set-mouse-color "gold1")

(customize-set-variable 'scroll-bar-mode 'right)
(setq frame-title-format  
      '("%S" (buffer-file-name "%f"  
			       (dired-directory dired-directory "%b"))))  
;;refresh buffer
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )
(global-set-key [f5] 'refresh-file)
;;函数名显示在mode-line上
(which-function-mode 1)
;;##################################


(put 'dired-find-alternate-file 'disabled nil)
(add-to-list 'load-path' "~/.emacs.d/3rd")
;;dired+
(require 'dired+)

;;(setq default-tab-width 2)


(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(put 'downcase-region 'disabled nil)

;;(require 'ibus)
;;(add-hook 'after-init-hook 'ibus-mode-off)
;;(global-unset-key (kbd "C-SPC"))
;;(global-set-key (kbd "C-SPC") 'ibus-toggle)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search nil)
 '(column-number-mode t)
 '(display-time-mode t)
 '(ls-lisp-verbosity nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 143 :width normal :foundry "outline" :family "Consolas")))))

;;maixize window
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)
;; Global font-lock mode
(global-font-lock-mode 1)


;;open windows explorer in place
(defun open-buffer-path ()
  "Run explorer on the directory of the current buffer."
  (interactive)
  (if buffer-file-name
      (browse-url(concat "file://" (file-name-directory buffer-file-name) ))
    (browse-url(concat "file://" (file-name-directory list-buffers-directory)))
    )
  )
;;I bound this function to a key-binding:
(global-set-key (kbd "C-x e") 'open-buffer-path)

(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil)


;;test elisp
;(add-to-list 'load-path "d:/program/elisp/")
;(require 'test)

