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
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(package-refresh-contents) ; Emacs wont work initaly if you dont uncomment this line, yes very bad solution

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)



;;; Dashboard

;; Auto generated config do not change that file
;;(use-package projectile
;;  :ensure t)
;;(use-package page-break-lines
;;  :ensure t)
;;(use-package all-the-icons
;;  :ensure t)
;;(use-package dashboard
;;  :ensure t
;;  :config
;;  (dashboard-setup-startup-hook)
;;  (setq dashboard-banner-logo-title "Welcome Anton!")
;;  (setq dashboard-projects-backend 'projectile)
;;  (setq dashboard-center-content t)
;;  (setq dashboard-items '((recents  . 5)
;;			  (bookmarks . 5)
;;			  (projects . 5))))

;; Max lenght vertical line
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode) ;for emacs 27 >

;; Line numbers
(setq display-line-numbers 'relative)

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

(use-package evil-collection
  :ensure t
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init))

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


;; File manager
(use-package ranger
  :ensure t)

;;; Short cuts and other keybindings

(global-set-key (kbd "C-c t") (lambda () (interactive) (launch-term)))

(define-key evil-normal-state-map (kbd "z s") 'hs-hide-level)

(global-set-key (kbd "C-x h") 'previous-buffer)
(global-set-key (kbd "C-x l") 'next-buffer)

;;; File alist

(setq backup-directory-alist `(("." . "~/.cache/emacs/saves")))
(setq custom-file "~/.cache/emacs/custom.el")


(use-package desktop
  :ensure nil ;; built-in package
  :init
  (setq desktop-path '("~/.cache/emacs/desktop/")  ;; where to save sessions
        desktop-dirname "~/.cache/emacs/desktop/"
        desktop-base-file-name "emacs-desktop"
        desktop-save t
        desktop-auto-save-timeout 300) ;; auto-save every 5 minutes
  :config
  (desktop-save-mode 1))

;;; Languages

(use-package auctex
  :ensure t
  :defer t
  :hook (LaTeX-mode . LaTeX-math-mode)
  :config
  ;; Enable PDF mode by default
  (setq TeX-PDF-mode t)

  ;; Automatically parse TeX files for Local Variables (e.g., TeX-master)
  (setq TeX-parse-self t)
  (setq TeX-auto-save t)

  ;; Add custom compile command flags (globally)
  (setq TeX-command-extra-options "-shell-escape -interaction=nonstopmode")

  ;; Enable RefTeX integration
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t))

;;(use-package auctex
;;  :ensure t
;;  :defer t
;;  :hook (LaTeX-mode . LaTeX-math-mode)
;;  :config
;;  ;; Set default PDF mode
;;  (setq TeX-PDF-mode t)
;;  ;; Add custom compile command flags
;;  (setq TeX-command-extra-options "-shell-escape -interaction=nonstopmode")
;;   ;; Customize TeX-command-list if needed
;;  (add-hook 'LaTeX-mode-hook
;;            (lambda ()
;;              (add-to-list 'TeX-command-list
;;                           '("MyLaTeX" "pdflatex -shell-escape -interaction=nonstopmode %s"
;;                             TeX-run-TeX nil t :help "Run My Custom LaTeX"))))
;;  ;; Enable RefTeX
;;  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;  (setq reftex-plug-into-AUCTeX t))

;;(setq TeX-auto-save t)
;;(setq TeX-parse-self t)
;;(setq TeX-save-query nil) ;; Save without asking
;;(setq TeX-PDF-mode t)     ;; Use PDF mode by default
;;(setq TeX-source-correlate-mode t) ;; Enable source correlation
;;(setq TeX-source-correlate-start-server t) ;; Start server for forward search

;; Open PDFs externally instead of inside Emacs
(setq TeX-view-program-selection '((output-pdf "Zathura"))
      TeX-view-program-list '(("Zathura" "zathura %o"))
      TeX-source-correlate-mode t
      TeX-source-correlate-start-server t)

;;(global-set-key (kbd "C-c m") 'compile-master-tex)


(use-package lsp-mode
  :ensure t
  :hook ((latex-mode . lsp-deferred))
  :config
  (setq lsp-tex-server 'digestif))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (add-hook 'latex-mode-hook (lambda () (flycheck-mode -1))))  ; Disable Flycheck for LaTeX

(use-package languagetool
  :ensure t
  :defer t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :config
  (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
        languagetool-console-command "~/.local/share/languagetool/languagetool-commandline.jar"
        languagetool-server-command "~/.local/share/languagetool/languagetool-server.jar"))


;; Prevent DocView from taking over PDF files
;;add-hook 'doc-view-mode-hook (lambda () (doc-view-toggle-display t)))
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

 
(global-set-key (kbd "C-c o") (lambda () (interactive) (find-file "~/.local/share/emacs/notes.org")))

;;; General editor setup
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)

;; init.el ends here
