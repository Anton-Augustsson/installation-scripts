;;; relative-line-numbers.el --- Set and toggle theme
;;
;; Author: Anton Augustsson <anton.augustsson99@gmail.com>
;; URL: https://github.com/Anton-Augustsson/installation-scripts.git

;;; Commentary:

;; Display line numbers on the left side of the window.
;; The line you are on is the actual line number.
;; Meanwhile, the line under and above is 1.

;;; Code:

(defun set-relative-line-numbers ()
  "Vim like line numbers where the next line is one and previous is also one."
  (defvar global-display-line-numbers-mode)
  (global-display-line-numbers-mode)
  (defvar display-line-numbers-type)
  (setq display-line-numbers-type 'relative)
  (add-hook 'term-mode-hook (lambda () (display-line-numbers-mode -1))))

;;; relative-line-numbers.el ends here
