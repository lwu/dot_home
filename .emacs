;; lwu .emacs 2013 (CocoaEmacs)

;; paths and directories
(add-to-list 'load-path "~/src/dot_home/elisp")
; (add-to-list 'load-path "~/src/ESS/lisp")


(setq mac-command-modifier 'meta) ; command => meta
(setq mac-option-modifier 'super) ; option  => super

(require 'ido)
(ido-mode t)

(require 'haml-mode)
(add-hook 'haml-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;(require 'ess-site) ; test, guarded

; (set-frame-font "Andale Mono:20") ; XEmacs-only
;; (mac-font-panel-mode) ; CarbonEmacs-only
;; (set-default-font "-apple-monaco-medium-r-normal--20-0-72-72-m-0-iso10646-1")

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(menu-bar-mode -1)

(defun zenburn-init ()
  (load-theme 'zenburn))

(add-hook 'after-init-hook 'zenburn-init) ; test if sunset?

; (when window-system ; ... ; TODO resize to max frame-size when not window-system

(set-default-font "Inconsolata-24")
(set-frame-size (selected-frame) 104 28)

(add-to-list 'default-frame-alist '(font . "Inconsolata-24")) ; future frame defaults
(add-to-list 'default-frame-alist '(width . 104))
(add-to-list 'default-frame-alist '(height . 28))


(setq js-indent-level 2)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style "k&r")
 '(column-number-mode t)
 '(custom-safe-themes (quote ("8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" default)))
 '(delete-key-deletes-forward t)
 '(font-lock-mode t t (font-lock))
 '(line-number-mode t)
 '(mwheel-follow-mouse t)
 '(paren-mode (quote sexp) nil (paren))
 '(pc-select-selection-keys-only nil)
 '(query-user-mail-address nil)
 '(recent-files-permanent-submenu t)
 '(user-mail-address "lwu2@"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; (require 'tramp)
(setq tramp-default-method "ssh")
; (require 'whitespace-visual-mode) ; XEmacs-only

(server-start) ; for emacsclient

(require 'recentf)
(global-set-key "\C-c\ \C-f" 'recentf-open-files)

(recentf-mode 1)
; (require 'icicles)
(setq visible-bell t)
(transient-mark-mode t) ; region mark highlighting
; (icy-mode t) ; icicle?
(global-hl-line-mode nil)
(set-face-background 'hl-line "#FFF") ; Emacs 22-only

(define-key global-map [(meta return)] 'mac-toggle-max-window)
(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
;; (require 'tabbar)
;; (tabbar-mode t)
;; (set-face-attribute
;;    'tabbar-default-face nil
;;    :background "gray60")
;;   (set-face-attribute
;;    'tabbar-unselected-face nil
;;    :background "gray85"
;;    :foreground "gray30"
;;    :box nil)
;;   (set-face-attribute
;;    'tabbar-selected-face nil
;;    :background "#f2f2f6"
;;    :foreground "black"
;;    :box nil)
;;   (set-face-attribute
;;    'tabbar-button-face nil
;;    :box '(:line-width 1 :color "gray72" :style released-button))
;;   (set-face-attribute
;;    'tabbar-separator-face nil
;;    :height 0.7)

(define-key global-map [(control prior)] 'tabbar-backward)
(define-key global-map [(control next)] 'tabbar-forward)

(cond ((fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)))

; http://www.emacswiki.org/emacs/DuplicateLines
; # consecutive duplicates
(defun uniquify-region-lines (beg end)
    "Remove duplicate adjacent lines in region."
    (interactive "*r")
    (save-excursion
      (goto-char beg)
      (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
        (replace-match "\\1"))))

(defun uniquify-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))

; Key bindings
; ____________

(global-set-key [(super tab)] 'other-frame)
(global-set-key [(meta \`)]   'other-frame)

(global-set-key [(control home)] 'beginning-of-buffer)
(global-set-key [(control end)]  'end-of-buffer)

(fset 'duplicate-line [?\C-a ?\C-  down ?\M-w ?\C-y ?\C-p])
(global-set-key [(control c) (y)] 'duplicate-line)
(global-set-key [(control x) (y)] 'duplicate-line)
(global-set-key [(control x) (control y)] 'duplicate-line)

; Meta [ and ] enlarge and shrink the current window
(global-set-key [(meta \[)] 'enlarge-window)
(global-set-key [(meta \])] 'shrink-window)

; C-\ kills current buffer.
(global-set-key [(control \\)] 'kill-this-buffer)

; [(control c) r] query and replaces
(global-set-key [(control c) (r)] 'query-replace)

; [(control c) b] opens up bookmark list
(global-set-key [(control c) (b)] 'bookmark-bmenu-list)

(defun switch-to-other-buffer (&optional norecord)
      "Select most recently selected buffer other than the current buffer.
    Optional second arg NORECORD non-nil means
    do not put this buffer at the front of the list of recently selected ones."
      (interactive)
      (switch-to-buffer (other-buffer (current-buffer)) norecord))

; switch to recent buffer
(global-set-key [(control meta l)] 'switch-to-other-buffer)
(global-set-key [(control \.)] 'switch-to-other-buffer)

; (control shift 1) opens a shell
;(global-set-key [(control !)] 'shell)
(global-set-key [(control !)] 'tshell)

;;; swiped from $EMACS_PATH/19.30/lisp/dired.el
(defvar dired-font-lock-keywords
  '(;; Put directory headers in italics.
    ("^  \\(/.+\\)" 1 font-lock-type-face)
    ;; Put symlinks in bold italics.
    ("\\([^ ]+\\) -> [^ ]+$" . font-lock-function-name-face)
    ;; Put marks in bold.
    ("^[^ ]" . font-lock-reference-face)
    ;; Put files that are subdirectories in bold.
    ("^..d.* \\([^ ]+\\)$" 1 font-lock-keyword-face))
  "Additional expressions to highlight in Dired mode.")

(put 'dired-mode 'font-lock-defaults 'dired-font-lock-keywords)

(defun delete-backward-line ()
  (interactive)
  (kill-line -0))

(global-set-key [(control backspace)] 'delete-backward-line)

; [(control x) b] replaces normal switch-to-buffer with cooler iswitchb-buffer
;  which does regexp searching on the fly for easier buffer switching
; (require 'iswitchb)
; (global-set-key [(control x) (b)] 'iswitchb-buffer)

(setq ido-confirm-unique-completion t) ; wait for RET even if unique
(setq ido-default-buffer-method 'samewindow)
(setq ido-use-filename-at-point t)
; (ido-mode t) ; comment out until fix C-x C-f up issue
; (ido-everywhere t)
; (setq ido-enable-flex-matching t)
; (set-face-background 'ido-first-match "white")
; (set-face-foreground 'ido-subdir "blue3")

(windmove-default-keybindings 'meta) ; thx emacsblog.org

(global-set-key [(control c) (control g)] 'grep)

(global-set-key [(control c) (f)] 'font-lock-mode)

; (meta n) and (meta p) scroll buffer ahead/behind
(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

(defun scroll-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default)."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))

(global-set-key [(meta n)] 'scroll-n-lines-ahead)
(global-set-key [(meta p)] 'scroll-n-lines-behind)

;;;; --- bounces from one sexp "(){}[]<>" to another (ala vi's %)
;;;; --- written by Joe Casadonte (joc@netaxs.com)
(defun joc-bounce-sexp ()
  "Will bounce between matching parens just like % in vi"
  (interactive)
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
        (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
                  ((string-match "[\]})>]" prev-char) (backward-sexp 1))
                  (t (error "%s" "Not on a paren, brace, or bracket")))))

(global-set-key [(control =)] 'joc-bounce-sexp)

; delete line and remaining blanks (like dd in vi)
(global-set-key [(control delete)] '(lambda ()
				      (interactive)
				      (kill-line 1)))

; better buffer selection
(global-set-key [(control x) (control b)] 'electric-buffer-list)

; Options
; _______

;;{{{ Uniqify Buffer Names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward) ;/dir1/dir2/non-unique-file

; control , and . move back and forth through the buffer list
; (require 'swbuff) ; http://perso.wanadoo.fr/david.ponce/more-elisp.html
; (global-set-key [(control ,)] 'swbuff-switch-to-previous-buffer)
; (global-set-key [(control \.)] 'swbuff-switch-to-next-buffer)

(require 'bs) ; http://home.netsurf.de/olaf.sylvester/emacs/
; nicer than list-buffers and electric-buffer-list
(global-set-key [(control x) (control b)] 'bs-show)

; enable parens matching
(show-paren-mode 1)

; make y/n suffice for yes/no q
(fset 'yes-or-no-p 'y-or-n-p)

; Misc
; ____

; Make sure emacs isn't accidentally killed
(defun paranoid-exit-from-emacs()
  (interactive)
  (if (yes-or-no-p "Do you want to exit? ")
      (save-buffers-kill-emacs)))
(global-set-key "\C-x\C-c" 'paranoid-exit-from-emacs)

; code copied from XEmacs's Options\Edit Init File menu code
(defun edit-dot-emacs ()
  "Edits the user's .emacs file"
  (interactive)
  (progn
    (find-file (or user-init-file "~/.xemacs/custom.el"))
    (or (eq major-mode (quote emacs-lisp-mode)) (emacs-lisp-mode))))

(global-set-key [(control c) (d)] 'edit-dot-emacs)

; calendar
(global-set-key [(control c) (c)] 'calendar)

(global-set-key [(control c) (g)] 'goto-line)

(require 'bookmark)
(define-key bookmark-bmenu-mode-map [return] 'bookmark-bmenu-select)

; enable pending delete (keystrokes delete then overwrite
;  selected text)
(cond
 ((fboundp 'turn-on-pending-delete)
  (turn-on-pending-delete))
 ((fboundp 'pending-delete-on)
  (pending-delete-on t)))

; enable pending delete (keystrokes delete then overwrite
;  selected text)
; (pending-delete-mode)

; don't display anything in modeline when pending delete is on
(setq pending-delete-modeline-string "")

; Enable mouse wheel
(defun scroll-down-whee (lines-to-scroll)
  (interactive)
  (scroll-down lines-to-scroll))

(defun scroll-up-whee (lines-to-scroll)
  (interactive)
  (scroll-up lines-to-scroll))

(defun scroll-down-less ()
  (interactive)
  (scroll-down-whee 3))

(defun scroll-up-less ()
  (interactive)
  (scroll-up-whee 3))

(defun scroll-down-more ()
  (interactive)
  (scroll-down-whee 8))

(defun scroll-up-more ()
  (interactive)
  (scroll-up-whee 8))

; normal mouse scroll
(global-set-key [button4] 'scroll-down-less)
(global-set-key [button5] 'scroll-up-less)

; control scrolls faster
(global-set-key [(control button4)] 'scroll-down-more)
(global-set-key [(control button5)] 'scroll-up-more)


; c indenting style
(setq c-set-style 'k&r)

; enable interactive completion mode in minibuffer
(icomplete-mode t)

;convert a buffer from dos ^M end of lines to unix end of lines
(defun dos2unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t)
    (replace-match "")))

;versa vice
(defun unix2dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t)
    (replace-match "\r\n")))


;; (taken from sample .emacs in XEmacs Help)
;;
;; Change the pointer used during garbage collection.
;;
;; Note that this pointer image is rather large as pointers go,
;; and so it won't work on some X servers (such as the MIT
;; R5 Sun server) because servers may have lamentably small
;; upper limits on pointer size.
;;(if (featurep 'xpm)
;;   (set-glyph-image gc-pointer-glyph
;;       (expand-file-name "trash.xpm" data-directory)))
;;
;; Here's another way to do that: it first tries to load the
;; pointer once and traps the error, just to see if it's
;; possible to load that pointer on this system; if it is,
;; then it sets gc-pointer-glyph, because we know that
;; will work.  Otherwise, it doesn't change that variable
;; because we know it will just cause some error messages.

;; (cond (running-xemacs
;;        (if (featurep 'xpm)
;;            (let ((file (expand-file-name "recycle.xpm" data-directory)))
;;              (if (condition-case error
;;                      ;; check to make sure we can use the pointer.
;;                      (make-image-instance file nil
;;                                           '(pointer))
;;                    (error nil)) ; returns nil if an error occurred.
;;                  (set-glyph-image gc-pointer-glyph file))))))

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
