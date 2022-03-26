;; Activate installed packages
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;(package-refresh-contents))


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
;(load-user-file "editing.el")

;; Editing config
(use-package solarized-theme
  :ensure t)
(load-user-file "apperance.el")

;; Auto generated config do not change that file
;(load-user-file "auto-generated.el")
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

;(use-package languagetool
;  :ensure t
;  :defer t
;  :commands (languagetool-check
;             languagetool-clear-suggestions
;             languagetool-correct-at-point
;             languagetool-correct-buffer
;             languagetool-set-language
;             languagetool-server-mode
;             languagetool-server-start
;             languagetool-server-stop)
;  :config
;  (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8")
;        languagetool-console-command "~/.languagetool/languagetool-commandline.jar"
;        languagetool-server-command "~/.languagetool/languagetool-server.jar"))
;(use-package langtool
;  :init
;  (setq langtool-bin "/snap/bin/languagetool"))
;(require 'langtool)

;(setq langtool-java-classpath
;      "/usr/share/language-tools:/usr/share/java/language-tools/*")
;(require 'langtool)

;(setq langtool-language-tool-jar "~/Programs/LanguageTool-5.6/languagetool-commandline.jar")
;(require 'langtool)
;(setq langtool-java-bin "/usr/bin/java")
;(setq langtool-default-language "en-US")
;(add-hook 'markdown-mode-hook
;          (lambda () (set (make-local-variable 'langtool-java-user-arguments)
;                         '("-Dfile.encoding=UTF-8"))))

; https://languagetool.org/download/
; https://simpleit.rocks/lisp/emacs/writing-in-emacs-checking-spelling-style-and-grammar/
; https://www.reddit.com/r/emacs/comments/tgnom4/need_help_with_langtool/
; https://github.com/emacs-languagetool/flycheck-languagetool

; python linting
(use-package flycheck
  :ensure t
  :config 
  (global-flycheck-mode))

; Spelling and grammer check
(use-package flycheck-languagetool
  :ensure t
  :hook (markdown-mode . flycheck-languagetool-setup)
  :init
  (setq flycheck-languagetool-server-jar "~/Programs/LanguageTool-5.6/languagetool-server.jar"))

;(display-line-numbers-mode)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

(setq custom-file "~/.emacs.d/custom.el")
