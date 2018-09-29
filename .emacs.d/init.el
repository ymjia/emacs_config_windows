;==================hotkeys========================

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(global-set-key (kbd "C-j") 'goto-line)


;; 用ibuffer代替默认的buffer switch
;; 参考 http://www.emacswiki.org/emacs/IbufferMode
;; 按 g 刷新文件目录      
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)



;==============3rd======================
(add-to-list 'load-path' "~/.emacs.d/3rd")
(put 'dired-find-alternate-file 'disabled nil)
;;dired+
(require 'dired+)
;;dired buffer reuse on for default
(diredp-make-find-file-keys-reuse-dirs)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(put 'downcase-region 'disabled nil)

;;cmake mode
(require 'cmake-mode)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))

;;anzu query/replacement
(require 'anzu)
(global-anzu-mode +1)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow" :weight 'bold)
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)

;;elpy
(package-initialize)
(elpy-enable)

;;edit indirect
(require 'edit-indirect)

;;markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;;================ themes============================
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path' "~/.emacs.d/themes/")


;;=============global variables=====================
(setq-default
 auto-window-vscroll nil       ; Lighten vertical scroll
 confirm-kill-emacs 'yes-or-no-p        ; Confirm before exiting Emacs
 cursor-in-non-selected-windows t       ; show cursor in inactive windows
 delete-by-moving-to-trash t   ; Delete files to trash
 display-time-default-load-average nil  ; Don't display load average
 display-time-format "%H:%M"   ; Format the time string
 fill-column 80                ; Set width for automatic line breaks
 help-window-select t          ; Focus new help windows when opened
 indent-tabs-mode t            ; Stop using tabs to indent
 inhibit-startup-screen t      ; Disable start-up screen
 initial-scratch-message ""    ; Empty the initial *scratch* buffer
 left-margin-width 1 right-margin-width 1        ; Add left and right margins
 mouse-yank-at-point t         ; Yank at point rather than pointer
 ns-use-srgb-colorspace nil    ; Don't use sRGB colors
 scroll-margin 3               ; Add a margin when scrolling vertically
 recenter-positions '(middle top bottom)     ; Set re-centering positions
 scroll-conservatively most-positive-fixnum      ; Always scroll by one line
 show-trailing-whitespace nil  ; Display trailing whitespaces
;========================CUSTOMIZ SETTINGS==================================
 tab-width 4                   ; Set width for tabs
 display-time-day t
 display-time-24hr-format t
 dired-dwim-target t ;;useful copy to dir specified by another buffer
 vc-handled-backends nil ;; Disable all version control(for speed)

; select-enable-clipboard t     ; Merge system's and Emacs' clipboard
; sentence-end-double-space nil ; End a sentence after a dot and a space
 x-stretch-cursor t           ; Stretch cursor to the glyph width
)

(display-time-mode 1)          ; Enable time in the mode-line
(fringe-mode 0)                ; Disable fringes
(fset 'yes-or-no-p 'y-or-n-p)  ; Replace yes/no prompts with y/n
(menu-bar-mode 0)              ; Disable the menu bar
(tool-bar-mode 0)              ; Disable the menu bar
(scroll-bar-mode 0)
(horizontal-scroll-bar-mode 0)
(mouse-avoidance-mode 'exile) ; Avoid collision of mouse with point
(which-function-mode 1)        ; display function name on mode-line
(setq column-number-mode t)
(global-linum-mode t)
; ad-redefinition-action 'accept; Silence warnings for redefinition
;(put 'downcase-region 'disabled nil)    ; Enable downcase-region
;(put 'upcase-region 'disabled nil)      ; Enable upcase-region

;;============emacs auto-set custom-variables==============
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-replace-threshold 50)
 '(anzu-replace-to-string-separator " => ")
 '(anzu-search-threshold 1000)
 '(column-number-mode t)
 '(display-time-mode t)
 '(ls-lisp-verbosity nil)
 '(markdown-command "pandoc.exe")
 '(markdown-link-space-sub-char "-")
 '(markdown-wiki-link-search-subdirectories t)
 '(package-selected-packages (quote (edit-indirect elpy)))
 '(spacemacs-theme-comment-bg (quote nil))
 '(tool-bar-mode nil))


(load-theme 'spacemacs-dark t)
;==================customizations=====================
;;frame title
(setq frame-title-format  
      '("%S" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;refresh buffer
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )
(global-set-key [f5] 'refresh-file)


;; start server for other program open in existing window
;; *for this purpose,
;;    add ENV : EMACS_SERVER_FILE=~/.emacs.d/server/server
;; *if enconter .emacs.d/server is unsafe(windows)
;;    set directory .emacs.d property->security->advinced->owner to current user
(server-start)

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

(defun copy-buffer-path ()
  "copy path of the current buffer."
  (interactive)
  (if buffer-file-name
      (kill-new (file-name-directory buffer-file-name))
    (kill-new (file-name-directory list-buffers-directory))
    )
  )
(global-set-key (kbd "C-x c") 'copy-buffer-path)
(global-set-key (kbd "C-x p") (lambda () (interactive) (kill-new  buffer-file-name)))

;copy all marked file list to a string
;sperated with ';' for "ParaView Open"
(defun copy_file_list ()
  "copy all marked file list"
  (interactive)
  (diredp-copy-abs-filenames-as-kill)
  (setq list_str (replace-regexp-in-string " \\([a-zA-Z]:/\\)" ";\\1" diredp-last-copied-filenames));windows abs path
  (setq list_str (replace-regexp-in-string " /" ";/" list_str))  ;linux abs path
  (kill-new list_str)
  )
(define-key dired-mode-map (kbd "C-x p") 'copy_file_list)

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
(add-hook 'kill-emacs-hook (lambda () (write_es_info "~/.emacs.d/save_es.el")))
(load_eshell "~/.emacs.d/save_es.el")

;;save eshell commands history
;;original history has overwrite problems
(setq eshell-save-history-on-exit nil)
(require 'custom_history)
;save all command history when kill emacs
(add-hook 'kill-emacs-hook 'save_es_command_history)
;record history to global list when kill emacs buffer
(add-hook 'eshell-exit-hook 'save_history_on_exit)
;;* use update_global_history in eshell to update history

;;move windows by id(1,2,3,4)
(require 'win_move)
(global-set-key (kbd "C-<") 'move_wind1)
(global-set-key (kbd "C->") 'move_wind2)
(global-set-key (kbd "C-,") 'move_wind3)
(global-set-key (kbd "C-.") 'move_wind4)

;; fix windows low efficiency after emacs 25
(when (eq system-type 'windows-nt)
  (setq gc-cons-threshold (* 100 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 20 t #'garbage-collect)
  ;; show garbage-collection-message
  ;(setq garbage-collection-messages t)
  )

;;dired sort extension
(add-hook 'dired-mode-hook
(lambda ()
  (interactive)
  (make-local-variable  'dired-sort-map)
  (setq dired-sort-map (make-sparse-keymap))
  (define-key dired-mode-map "s" dired-sort-map)
  (define-key dired-sort-map "s"
    '(lambda () "sort by Size"
       (interactive) (dired-sort-other (concat dired-listing-switches "S"))))
  (define-key dired-sort-map "x"
    '(lambda () "sort by eXtension"
       (interactive) (dired-sort-other (concat dired-listing-switches "X"))))
  (define-key dired-sort-map "t"
    '(lambda () "sort by Time"
       (interactive) (dired-sort-other (concat dired-listing-switches "t"))))
  (define-key dired-sort-map "n"
    '(lambda () "sort by Name"
       (interactive) (dired-sort-other (concat dired-listing-switches ""))))))

;;dired omit mode setting
(setq dired-omit-extensions '("~"))
(define-key dired-mode-map ")" 'dired-omit-mode)
(add-hook 'dired-mode-hook '(lambda () (setq dired-omit-mode t)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 132 :width normal)))))
