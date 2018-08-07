0;136;0c; guess dired operation target
(setq dired-dwim-target t)

;; Disable all version control
(setq vc-handled-backends nil)

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

;;########################################
;;cscope
;;LOAD_PATH       
;;(add-to-list 'load-path "/home/tfjiang/app/emacs/cscope")
					;(require 'xcscope)

;;########################################
;;org mode
					;(add-to-list 'load-path "/home/tfjiang/app/emacs/org-7.4")
					;(require 'org)
					;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
					;(define-key global-map "\C-cl" 'org-store-link)
					;(define-key global-map "\C-ca" 'org-agenda)
					;(setq org-hide-leading-stars t)
					;(setq org-log-done t)

;;########################################
					; auto complete  gccsense
					;(add-to-list 'load-path "/home/tfjiang/app/emacs/auto-complete-1.3.1")  
					;(require 'auto-complete-config)  
					;(add-to-list 'ac-dictionary-directories "/home/tfjiang/app/emacs/auto-complete-1.3.1/dict")  
					;(ac-config-default)  

					;(add-to-list 'load-path "/home/tfjiang/app/emacs/gccsense-0.1/etc")  
					;(require 'gccsense)  
					;(global-set-key (kbd "C-?") 'ac-complete-gccsense)
;;##########################################

;;#########################################

;;################################
					;cedet
					;(load-file "/home/tfjiang/app/emacs/cedet-1.0/common/cedet.el")
					;(require 'cedet)
					;(semantic-load-enable-minimum-features)
					;(semantic-load-enable-code-helpers)

;;代码折叠
					;(load-file "/home/tfjiang/app/emacs/cedet-1.0/contrib/semantic-tag-folding.el")
					;(require 'semantic-tag-folding nil 'noerror)
					;(global-semantic-tag-folding-mode 1)
					;(define-key semantic-tag-folding-mode-map (kbd "C-\-") 'semantic-tag-folding-fold-block)
					;(define-key semantic-tag-folding-mode-map (kbd "C-\=") 'semantic-tag-folding-show-block)

;;代码跳转
					;(global-set-key [f12] 'semantic-ia-fast-jump)
;;跳回来
					;(global-set-key [S-f12]
					;                (lambda ()
					;                  (interactive)
					;                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
					;                      (error "Semantic Bookmark ring is currently empty"))
					;                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
					;                         (alist (semantic-mrub-ring-to-assoc-list ring))
					;                         (first (cdr (car alist))))
					;                    (if (semantic-equivalent-tag-p (oref first tag)
					;                                                   (semantic-current-tag))
					;                        (setq first (cdr (car (cdr alist)))))
					;                    (semantic-mrub-switch-tags first))))

;;#################################
;;ecb

					;(global-ede-mode 1)
					;(add-to-list 'load-path' "/home/tfjiang/app/emacs/ecb-2.40")
					;(require 'ecb-autoloads)
					;(setq ecb-auto-activate t
					;      ecb-tip-of-the-day nil)
					;(setq ecb-tip-of-the-day nil)
;;##################################

;; ;; 自动补全代码  
;; (global-set-key [(meta ?/)] 'hippie-expand)  
;; (setq hippie-expand-try-functions-list  
;;       '(try-expand-dabbrev  
;;     try-expand-dabbrev-visible  
;;     try-expand-dabbrev-all-buffers  
;;     try-expand-dabbrev-from-kill  
;;     try-complete-file-name-partially  
;;     try-complete-file-name  
;;     try-expand-all-abbrevs  
;;     try-expand-list  
;;     try-expand-line  
;;     try-complete-lisp-symbol-partially  
;;     try-complete-lisp-symbol))  


;; ;;##############################################
;; ;; ;;auctex
;; ;; ;(add-to-list 'load-path "/home/tfjiang/app/emacs/auctex-11.86")
;; (load "~/auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)

;; (setq TeX-output-view-style (quote (("^pdf$" "." "evince %o %(outpage)"))))

;; (add-hook 'LaTeX-mode-hook
;; 	  (lambda()
;; 	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
;; 	    (setq TeX-command-default "XeLaTeX")))

;;##################################################
;; ;doxymacs
;; (require 'doxymacs)
;; (add-hook 'c-mode-common-hook 'doxymacs-mode)
