;;; launch-term.el --- Launch a new terminal in a new window.
;;
;; Author: Anton Augustsson <anton.augustsson99@gmail.com>
;; URL: https://github.com/Anton-Augustsson/installation-scripts.git

;;; Commentary:

;; Launches the terminal to the right of current window.
;; It also change the focus to the new window

;;; Code:

(defun launch-term ()
  "Split window and launch term."
  (interactive)
  (split-window-right)
  (other-window 1)
  (term "/bin/zsh"))

;;; launch-term.el ends here
