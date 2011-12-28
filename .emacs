; Global defaults
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default default-tab-width 4)
(setq-default c-basic-indent 4)

; Modes
(add-to-list 'load-path "~/.emacs.d/jade-mode")
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

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
