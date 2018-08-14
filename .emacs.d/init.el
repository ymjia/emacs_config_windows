;==================hotkeys========================
(global-set-key (kbd "C-j") 'goto-line)


;; 用ibuffer代替默认的buffer switch
;; 参考 http://www.emacswiki.org/emacs/IbufferMode
;; 按 g 刷新文件目录      
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

;(set-foreground-color "grey")
;(set-background-color "black")
(set-cursor-color "gold1")
(set-mouse-color "gold1")

(customize-set-variable 'scroll-bar-mode 'right)
(setq frame-title-format  
      '("%S" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;=============global variables=====================

(setq-default
 auto-window-vscroll nil       ; Lighten vertical scroll
 confirm-kill-emacs 'yes-or-no-p        ; Confirm before exiting Emacs
 cursor-in-non-selected-windows t       ; Hide the cursor in inactive windows
 delete-by-moving-to-trash t   ; Delete files to trash
 display-time-default-load-average nil  ; Don't display load average
 display-time-format "%H:%M"   ; Format the time string
 fill-column 80                ; Set width for automatic line breaks
 help-window-select t          ; Focus new help windows when opened
 indent-tabs-mode nil          ; Stop using tabs to indent
 inhibit-startup-screen t      ; Disable start-up screen
 initial-scratch-message ""    ; Empty the initial *scratch* buffer
 left-margin-width 1 right-margin-width 1        ; Add left and right margins
 mouse-yank-at-point t         ; Yank at point rather than pointer
 ns-use-srgb-colorspace nil    ; Don't use sRGB colors
 scroll-margin 3               ; Add a margin when scrolling vertically
 recenter-positions '(10 top bottom)     ; Set re-centering positions
 scroll-conservatively most-positive-fixnum      ; Always scroll by one line
; select-enable-clipboard t     ; Merge system's and Emacs' clipboard
; sentence-end-double-space nil ; End a sentence after a dot and a space
 show-trailing-whitespace nil  ; Display trailing whitespaces
; split-height-threshold nil    ; Disable vertical window splitting
; split-width-threshold nil     ; Disable horizontal window splitting
; tab-width 4                   ; Set width for tabs
; window-combination-resize t   ; Resize windows proportionally
 x-stretch-cursor t)           ; Stretch cursor to the glyph width
(display-time-mode 1)          ; Enable time in the mode-line
(fringe-mode 0)                ; Disable fringes
(fset 'yes-or-no-p 'y-or-n-p)  ; Replace yes/no prompts with y/n
(menu-bar-mode 0)              ; Disable the menu bar
(mouse-avoidance-mode 'banish) ; Avoid collision of mouse with point
(which-function-mode 1)        ; display function name on mode-line
(setq column-number-mode t)
(global-linum-mode t)


;;================ themes============================
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

; ad-redefinition-action 'accept; Silence warnings for redefinition
;(delete-selection-mode 1)      ; Replace region when inserting text
;(put 'downcase-region 'disabled nil)    ; Enable downcase-region
;(put 'upcase-region 'disabled nil)      ; Enable upcase-region


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
(global-set-key [remap query-replace] 'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
;; (use-package anzu
;;   :defer 1
;;   :bind ([remap query-replace] . anzu-query-replace-regexp)
;;   :config
;;   (global-anzu-mode 1)
;;   (setq-default
;;    anzu-cons-mode-line-p nil
;;    anzu-replace-to-string-separator (mdi "arrow-right" t))
;;   (zenburn-with-color-variables
;;     (set-face-attribute 'anzu-replace-highlight nil
;;                         :background zenburn-red-4
;;                         :foreground zenburn-red+1)
;;     (set-face-attribute 'anzu-replace-to nil
;;                         :background zenburn-green-1
;;                         :foreground zenburn-green+4))
;;   (me/unboldify '(anzu-mode-line anzu-mode-line-no-match)))



;==================customizations=====================
;; data and time
(setq display-time-day t
      display-time-24hr-format t)
(display-time)

;; toolbar
;(setq tool-bar-map (make-sparse-keymap))

;;refresh buffer
(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )
(global-set-key [f5] 'refresh-file)

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

(defun copy-buffer-path ()
  "copy path of the current buffer."
  (interactive)
  (if buffer-file-name
      (kill-new (file-name-directory buffer-file-name))
    (kill-new (file-name-directory list-buffers-directory))
    )
  )
(global-set-key (kbd "C-x c") 'copy-buffer-path)

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
(global-set-key (kbd "C-x p") 'copy_file_list)

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

;;maximize window
;(toggle-frame-maximized)


