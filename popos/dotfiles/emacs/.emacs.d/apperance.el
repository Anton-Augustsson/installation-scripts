
;; Defining the themes
(defvar *theme-light* 'solarized-light) ;To change light theme change here
(defvar *theme-dark* 'solarized-dark)   ;To change dark theme change here
(defvar *current-theme* *theme-dark*)   ;To change defoult theme chage here

;; Helper function to set theme 
(defun set-theme (theme)
  (disable-theme *current-theme*)
  (progn
    (load-theme theme t))
  (setq *current-theme* theme)) 

;; Toogle theme
(defun toggle-theme ()
     (interactive)
     (cond ((eq *current-theme* *theme-dark*) (set-theme *theme-light*))
	   ((eq *current-theme* *theme-light*) (set-theme *theme-dark*)))) 

;; Set default theme and keybinding
(set-theme *current-theme*)
(global-set-key (kbd "<f7>") 'toggle-theme)   ; F7 key

;; Hide uesesary stuff from gui
(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 
