;; Activate installed packages
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;(package-refresh-contents) ; Emacs wont work initaly if you dont uncomment this line, yes very bad solution


(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Use to lead file
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;; evil mode config
(setq evil-want-keybinding nil) ; is needed for evil-collention
(use-package evil
  :ensure t
  :config
  (evil-mode))

(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(use-package evil-collection
  :ensure t
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))

;; Editing config
(use-package solarized-theme
  :ensure t)
(load-user-file "apperance.el")

;; Auto generated config do not change that file
(use-package projectile
  :ensure t)
(use-package page-break-lines
  :ensure t)
(use-package all-the-icons
  :ensure t)
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(load-user-file "dashboard-conf.el")

(use-package auctex
  :ensure t
  :defer t)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package flyspell
  :ensure t)
(dolist (hook '(python-mode-hook markdown-mode-hook git-commit-setup-hook org-mode-hook))
     (add-hook hook (lambda () (flyspell-mode 1))))

(use-package hl-todo
  :ensure t)

(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
	("FIXME"  . "#FF0000")
	("DEBUG"  . "#A020F0")
	("GOTCHA" . "#FF4500")
	("STUB"   . "#1E90FF")))
(define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
(define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
(define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
(define-key hl-todo-mode-map (kbd "C-c i") 'hl-todo-insert)

(use-package magit
  :ensure t)

;  :init
;  (message "Loading Magit!")
;  :config
;  (message "Loaded Magit!")
;  :bind (("C-x g" . magit-status)
;         ("C-x C-g" . magit-status)))


;for emacs 27 >
;(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(add-hook 'term-mode-hook (lambda () (display-line-numbers-mode -1)))

(add-hook 'org-mode-hook 'visual-line-mode)
(use-package org-bullets
  :ensure t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


;; On start up
;https://emacs.stackexchange.com/questions/19610/how-to-start-term-in-a-separate-window-at-launch
(defun launch-term ()
  "Split window and launch term."
  (interactive)
  (split-window-right)
  (other-window 1)
  (term "/bin/zsh"))
;(other-window 1))

;(define-key hl-todo-mode-map (kbd "C-c i") 'hl-todo-insert)
(global-set-key (kbd "C-c t") (lambda () (interactive) (launch-term)))
;(funcall (key-binding (kbd "C-c t")))

;; C-c C-v for copy and past
(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(setq backup-directory-alist `(("." . "~/.saves")))
(setq custom-file "~/.emacs.d/custom.el")

;;; init.el ends here
