;;; init.el --- Emacs configuration of Anton Augustsson -*- lexical-binding: t; -*-
;;
;; Author: Anton Augustsson <anton.augustsson99@gmail.com>
;; URL: https://github.com/Anton-Augustsson/installation-scripts.git

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation; either version 3 of the License, or (at your option) any later
;; version.

;; This program is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
;; FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
;; details.

;; You should have received a copy of the GNU General Public License along with
;; GNU Emacs; see the file COPYING.  If not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
;; USA.

;;; Commentary:

;; Emacs configuration of Anton Augustsson
;;
;; Using Evil mode to improve ergonomics.
;; Tailored for python and latex

;;; Code:


;;; Package managment

;; Activate installed packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;(package-refresh-contents) ; Emacs wont work initaly if you dont uncomment this line, yes very bad solution

;; use-package installation
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

;; Use to load file
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))

(defun load-user-file (file)
  "Load a FILE in current user's configuration directory."
  (interactive "f")
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "theme.el")
(load-user-file "relative-line-numbers.el")
(load-user-file "launch-term.el")


;;; Dashboard

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
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome Anton!")
  (setq dashboard-projects-backend 'projectile)
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
			  (bookmarks . 5)
			  (projects . 5))))


;;; Apperance

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

;; Theme
(use-package solarized-theme
  :ensure t
  :config
  (aa/theme 'solarized-light 'solarized-dark 'solarized-dark))

(defun set-hl-todo-colours ()
  "Define colour of keywords such as TODO and FIXME."
  (defvar hl-todo-keyword-faces)
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
	("FIXME"  . "#FF0000")
	("DEBUG"  . "#A020F0")
	("GOTCHA" . "#FF4500")
	("STUB"   . "#1E90FF"))))

;; Highlighted TODO
(use-package hl-todo
  :ensure t
  :config
  (set-hl-todo-colours)
  (define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
  (define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
  (define-key hl-todo-mode-map (kbd "C-c i") 'hl-todo-insert)
  (global-hl-todo-mode))

;; Max lenght vertical line
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode) ;for emacs 27 >

;; Line numbers
(set-relative-line-numbers)

;; Centred window
(use-package centered-window
  :ensure t
  :config (centered-window-mode t))

;; Font size
(set-face-attribute 'default nil :height 120)

;;; Editing

;; Evil mode installation and config
(use-package evil
  :init (setq evil-want-keybinding nil) ; is needed for evil-collention
  :ensure t
  :config (evil-mode))

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

;; Auto completion
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package pos-tip
  :ensure t)

(use-package company-quickhelp
  :ensure t
  :config (company-quickhelp-mode))

(use-package company-jedi
  :ensure t)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)
;M-x jedi:install-server
(eval-after-load 'company
  '(define-key company-active-map (kbd "C-c h") #'company-quickhelp-manual-begin))

;; File manager
(use-package ranger
  :ensure t)

;; Linting
(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

;; Spelling
(use-package flyspell
  :ensure t
  :config
  (dolist (hook '(python-mode-hook markdown-mode-hook git-commit-setup-hook org-mode-hook emacs-lisp-mode-hook))
     (add-hook hook (lambda () (flyspell-mode 1)))))

;; Version control
(use-package magit
  :ensure t)

;; Show hide code block
(add-hook 'python-mode-hook 'hs-minor-mode)

;;; Languages

(use-package auctex
  :ensure t
  :defer t)

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


;;; Short cuts and other keybindings

(global-set-key (kbd "C-c t") (lambda () (interactive) (launch-term)))

(define-key evil-normal-state-map (kbd "z s") 'hs-hide-level)

;;; File alist

(setq backup-directory-alist `(("." . "~/.saves")))
(setq custom-file "~/.emacs.d/custom.el")

;;; init.el ends here
