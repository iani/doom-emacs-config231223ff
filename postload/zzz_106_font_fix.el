;;; postload/zzz_106_font_fix.el -*- lexical-binding: t; -*-

(defun fix-fonts ()
    "Fix fonts as config.el can't"
  (interactive)
  (custom-set-faces
   '(default ((t (:family "Iosevka" :weight light :height 180)))))
  (set-fontset-font t 'greek (font-spec :family "Helvetica" :weight 'normal :height 0.75)))
