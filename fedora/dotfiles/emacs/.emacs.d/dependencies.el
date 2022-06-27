
;; Activate installed packages
(package-initialize)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)


;(defun ensure-package-installed (&rest packages)
;  "Assure every package is installed, ask for installation if it’s not.
;   Return a list of installed packages or nil for every skipped package."
;  (mapcar
;   (lambda (package)
;     ;; (package-installed-p 'evil)
;     (if (package-installed-p package)
;         nil
;       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
;           (package-install package)
;         package)))
;   packages))
;
;;; make sure to have downloaded archive description.
;;; Or use package-archive-contents as suggested by Nicolas Dudebout
;(or (file-exists-p package-user-dir)
;    (package-refresh-contents))

;; Install packages
;(ensure-package-installed 
;  'evil  
;  'dashboard 'projectile 'all-the-icons 'page-break-lines ; for dashboard (welcome screen)
;  'solarized-theme 
;  'auctex)  

