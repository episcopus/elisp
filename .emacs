; Global defaults
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default default-tab-width 4)
(setq-default c-basic-indent 4)
; Get rid of annoying yes or no prompt
(fset 'yes-or-no-p 'y-or-n-p)
; Get rid of annoying confirmation when creating a new buffer
(setq confirm-nonexistent-file-or-buffer nil)
; Kill splash screen
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t
      inhibit-startup-screen t)
; Get rid of number disambiguated buffer names - uses part of path instead
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
; Enable split window navigation using shift-<arrows>
(windmove-default-keybindings) 
; the toolbar is just a waste of valuable screen estate
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
; highlight the current line
(global-hl-line-mode +1)
(set-face-background 'hl-line "#000066")
; tramp, for sudo access
(require 'tramp)
; keep in mind known issues with zsh - see emacs wiki
(setq tramp-default-method "ssh")
; handle expansion and indentation with <tab>
; (load-file "~/.emacs.d/smart-tab.el")
;;;
;; Smart Tab

(defvar smart-tab-using-hippie-expand t
  "turn this on if you want to use hippie-expand completion.")

(defun smart-tab (prefix)
  "Needs `transient-mark-mode' to be on. This smart tab is
  minibuffer compliant: it acts as usual in the minibuffer.

  In all other buffers: if PREFIX is \\[universal-argument], calls
  `smart-indent'. Else if point is at the end of a symbol,
  expands it. Else calls `smart-indent'."
  (interactive "P")
  (labels ((smart-tab-must-expand (&optional prefix)
                                  (unless (or (consp prefix)
                                              mark-active)
                                    (looking-at "\\_>"))))
    (cond ((minibufferp)
           (ido-complete))
          ((smart-tab-must-expand prefix)
           (if smart-tab-using-hippie-expand
               (hippie-expand nil)
             (dabbrev-expand nil)))
          ((smart-indent)))))

(defun smart-indent ()
  "Indents region if mark is active, or current line otherwise."
  (interactive)
  (if mark-active
    (indent-region (region-beginning)
                   (region-end))
    (indent-for-tab-command)))

; (provide 'smart-tab)

; Modes
(autoload 'json-mode "~/.emacs.d/json-mode.el" "Major mode for editing JSON." t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(add-to-list 'load-path "~/.emacs.d/jade-mode")
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(add-to-list 'load-path "~/Projects/elisp/anything-config")
(require 'anything-match-plugin)
(require 'anything-config)
(setq fit-frame-inhibit-fitting-flag t)

(autoload 'actionscript-mode "~/.emacs.d/actionscript-mode-connors.el"
  "Major mode for editing ActionScript files" t)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))

(autoload 'csharp-mode "~/.emacs.d/csharp-mode.el" "Major mode for editing C# code." t)
(setq auto-mode-alist
    (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; (add-to-list 'load-path
;;               "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet) ;; not yasnippet-bundle
;; (setq yas/snippet-dirs '("~/.emacs.d/plugins/yasnippet/snippets"))
;; (yas/initialize)
;; (yas/global-mode 1)
;; (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

; ido-mode
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-default-file-method 'selected-window)

; auto-completion in minibuffer
(icomplete-mode +1)
(set-default 'imenu-auto-rescan t)

; Activate occur easily inside isearch
(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp
                 isearch-string
               (regexp-quote isearch-string))))))

; Mode customizations
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 4))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(add-hook 'php-mode-hook (lambda ()
                          (setq c-basic-offset 4)
                          (setq indent-tabs-mode t)
                          (phpunit-minor-mode t)))

; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

; Hotkeys
(global-set-key (kbd "<C-M-tab>") 'whitespace-mode)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-RET") 'anything)
(global-set-key (kbd "C-x C-i") 'anything-imenu)
(global-set-key (kbd "C-x C-g") 'anything-locate)
(global-set-key (kbd "<tab>") 'smart-tab)

(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))

(global-set-key (kbd "<C-tab>") 'other-window)
(global-set-key (kbd "<C-S-tab>") 'select-next-window)
(put 'downcase-region 'disabled nil)

