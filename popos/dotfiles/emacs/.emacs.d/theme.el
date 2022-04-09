(defvar *theme-light*)
(defvar *theme-dark*)
(defvar *current-theme*)
;; Defining the themes
;; Helper function to set theme 
(defun aa/set-theme (theme)
  (disable-theme *current-theme*)
  (progn
    (load-theme theme t))
  (setq *current-theme* theme)) 

;; Toogle theme
(defun aa/toggle-theme ()
     (interactive)
     (cond ((eq *current-theme* *theme-dark*) (aa/set-theme *theme-light*))
	   ((eq *current-theme* *theme-light*) (aa/set-theme *theme-dark*)))) 

(defun aa/theme (theme-light theme-dark default-theme)
  (setq *theme-light* theme-light) ;To change light theme change here
  (setq *theme-dark* theme-dark)   ;To change dark theme change here
  (setq *current-theme* default-theme)   ;To change defoult theme chage here

  (aa/set-theme *current-theme*)
  (global-set-key (kbd "<f7>") 'aa/toggle-theme))   ; F7 key


;; Set default theme and keybinding
;(set-theme *current-theme*)
;(global-set-key (kbd "<f7>") 'toggle-theme)   ; F7 key

;; Hide uesesary stuff from gui
;(menu-bar-mode -1) 
;(toggle-scroll-bar -1) 
;(tool-bar-mode -1) 
