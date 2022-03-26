
;(require 'dashboard) ; https://github.com/emacs-dashboard/emacs-dashboard
;(dashboard-setup-startup-hook)

;; Set the title
(setq dashboard-banner-logo-title "Welcome Anton!")
(setq dashboard-projects-backend 'projectile)

;; Set the banner
;(setq dashboard-startup-banner [VALUE])
;; Value can be
;; 'official which displays the official emacs logo
;; 'logo which displays an alternative emacs logo
;; 1, 2 or 3 which displays one of the text banners
;; "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)))


