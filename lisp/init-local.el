;;; commentary:
;;; code:

;;; Temporary configuration ;;
;;; define a function, press F1 quickly open your config file
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f1>") 'open-my-init-file)

;;; press F2 come back here.
(defun open-my-local-file()
  (interactive)
  (find-file "~/.emacs.d/lisp/init-local.el"))
(global-set-key (kbd "<f2>") 'open-my-local-file)

;;; press F2 come back here.
(defun open-my-org()
  (interactive)
  (find-file "~/org/principle.org"))
(global-set-key (kbd "<f12>") 'open-my-org)


;;; config neotree
(require 'neotree)
(global-set-key [f8] 'neotree)
(setq neo-smart-open t)


(defadvice show-paren-function (around fix-show-paren-function activate)
  (cond ((looking-at-p "\\s(") ad-dolist)
        (t (save-excursion
             (ignore-errors (backward-up-list))
             ad-do-it)))
  )

;;; Support Java language
(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (flycheck-mode +1)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))
(cond
 ((eq system-type 'windows-nt)
  (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
  (setq meghanada-maven-path "mvn.cmd"))
 (t
  (setq meghanada-java-path "java")
  (setq meghanada-maven-path "mvn")))

;; Support org output to pdf
(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                              "xelatex -interaction nonstopmode %f"
                              ))


;;; Support org-mind-map, but here is a bug, I suggest that turn on org-mind-map when you want to use.
;;(load "org-mind-map.el")

;;; Support to load python templates
(add-hook 'find-file-hooks 'maybe-load-template)
(defun maybe-load-template ()
  (interactive)
  (when (and
         (string-match "\\.py$" (buffer-file-name))
         (eq 1 (point-max)))
    (insert-file "~/.emacs.d/templates/template.py")
    (goto-char (point-max))
    (insert (concat "# @Time    : " (current-time-string)"\n\n"))
    ))

;;; 多行注释
;; 1. 选中一段区域到最后一行行首（！很重要！）；
;; 2. 按 C-x r t ；
;; 3. 输入注释内容；

;;; 反多行注释：
;; 1. 选中一段区域到最后一行，紧挨着注释字符之后的位置（！很重要！）；
;; 2. 按 c-x r k；

 ;; 快捷键放大/缩小字体
(global-set-key (kbd "<M-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<M-mouse-5>") 'text-scale-decrease)

(provide 'init-local)
