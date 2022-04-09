;;; theme.el --- Set and toggle theme
;;
;; Author: Anton Augustsson <anton.augustsson99@gmail.com>
;; URL: https://github.com/Anton-Augustsson/installation-scripts.git

;;; Commentary:

;; Both light and dark themes can be set.
;; These two themes can then be toggled between by pressing F7.

;;; Code:

(defvar *theme-light*)
(defvar *theme-dark*)
(defvar *current-theme*)

(defun aa/set-theme (theme)
  "Set the THEME of Emacs."
  (disable-theme *current-theme*)
  (progn
    (load-theme theme t))
  (setq *current-theme* theme))

(defun aa/toggle-theme ()
  "Toggle THEME between dark and light."
  (interactive)
  (cond ((eq *current-theme* *theme-dark*) (aa/set-theme *theme-light*))
	((eq *current-theme* *theme-light*) (aa/set-theme *theme-dark*))))

(defun aa/theme (theme-light theme-dark default-theme)
  "Initaly seting the them to DEFAULT-THEME then can toggle between THEME-LIGHT THEME-DARK with F7."
  (setq *theme-light* theme-light)
  (setq *theme-dark* theme-dark)
  (setq *current-theme* default-theme)

  (aa/set-theme *current-theme*)
  (global-set-key (kbd "<f7>") 'aa/toggle-theme)) ;Change keybinding here

;;; theme.el ends here
