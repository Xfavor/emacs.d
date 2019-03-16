;;; commentary:
;;; code:

;; Temporary configuration ;;
;; define a function, press F1 quickly open your config file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f1>") 'open-my-init-file)

(provide 'init-local)
