;;; postload/zzz_104_sardine.el -*- lexical-binding: t; -*-

;; =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;; SARDINE MODE
;; =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;; Customize the python-mode to run Sardine code using the terminal.

(setq
 python-shell-interpreter "fishery"
 python-shell-interpreter-args "")

(defun sardine/start-sardine ()
  "Start a new interactive Sardine Session"
  (interactive)
  (run-python))

(defun sardine/eval-block ()
  "Evaluate a sardine code block"
  (interactive)
  (mark-paragraph)
  (if (and transient-mark-mode mark-active)
      (python-shell-send-region (point) (mark))
    (python-shell-send-region (point-at-bol) (point-at-eol)))
  (forward-paragraph))

(defun sardine/stop-code ()
  "Stop all the Sardine code currently running"
  (interactive)
  (python-shell-send-string "panic()"))

; Unmapping keys from the Python mode
(add-hook 'python-mode-hook
          (lambda() (local-unset-key (kbd "C-c C-c"))))
(add-hook 'python-mode-hook
          (lambda() (local-unset-key (kbd "C-c C-s"))))

; Remapping keys
(global-set-key (kbd "C-c C-c") #'sardine/eval-block)
(global-set-key (kbd "C-c C-s") #'sardine/stop-code)
