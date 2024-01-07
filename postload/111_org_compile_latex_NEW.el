;;; postload/111_org_compile_latex_NEW.el -*- lexical-binding: t; -*-

(defun org-latex-set-export-dir-and-open-iterm ()
  "Set directory for exports and open iterm to perform makepdf.
Perform this on the dired buffer of the directory containing the latex template
for the document that you want to compile."
  (interactive)
  (goto-line 0) ;; go to line containing the directory name
  (setq org-latex-template-dir (dired-copy-filename-as-kill))
  (+macos/open-in-iterm))
