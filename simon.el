(setq prelude-flyspell nil)

;; Get rid of number disambiguated buffer names - uses part of path instead
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; Enable split window navigation using shift-<arrows>
(windmove-default-keybindings)
;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;;----------------------------------------------------------------------
;; Bookmarks
;; (require 'bm)

;; ;; Bookmark hotkeys
;; (global-set-key (kbd "<C-f2>") 'bm-toggle)
;; (global-set-key (kbd "<f2>")   'bm-next)
;; (global-set-key (kbd "<S-f2>") 'bm-previous)

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

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(provide 'simon)
