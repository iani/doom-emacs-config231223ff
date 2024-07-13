;;; postload/01_toggle_input_encoding.el -*- lexical-binding: t; -*-

;;; postload/01_input_encoding.el -*- lexical-binding: t; -*-

(defun set-encoding-greek ()
  "Set input encoding to greek."
  (interactive)
  (set-input-method 'greek))

(defun set-encoding-ucs ()
  "Set input encoding to english (ucs)."
  (interactive)
  (set-input-method 'ucs))

(defun set-encoding-japanese ()
  "Set input encoding to japanese."
  (interactive)
  (set-input-method 'japanese))

(defun toggle-greek-encoding ()
  "Toggle encoding between greek and ucs."
  (interactive)
  ;; (message "The encoding is: %s" current-input-method)
  (if (equal current-input-method "greek")
      (set-input-method 'ucs)
    (set-input-method 'greek)))

(defun toggle-japanese-encoding ()
  "Toggle encoding between greek and ucs."
  (interactive)
  ;; (message "The encoding is: %s" current-input-method)
  (if (equal current-input-method "japanese")
      (set-input-method 'ucs)
    (set-input-method 'japanese)))

(defun set-greek-fontset ()
  "Set greek fontset size. Workaround - experimental."
  (interactive)
  (set-fontset-font
   t 'greek
   (font-spec :family "Helvetica" :weight 'normal :height 0.75)))

(global-set-key (kbd "C-c C-\\") 'toggle-encoding)
(global-set-key (kbd "C-M-s-\\") 'toggle-encoding)
(global-set-key (kbd "C-M-s-f") 'set-greek-fontset)
(global-set-key (kbd "C-M-s-j") 'set-encoding-japanese)
