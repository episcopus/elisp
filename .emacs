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
      inhibit-startup-echo-area-message t)
; Get rid of number disambiguated buffer names - uses part of path instead
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

(windmove-default-keybindings) 

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

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/global-mode 1)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

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

; Hotkeys
(global-set-key (kbd "<C-M-tab>") 'whitespace-mode)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-RET") 'anything)
(global-set-key (kbd "C-x C-i") 'anything-imenu)
(global-set-key (kbd "C-x C-g") 'anything-locate)

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
