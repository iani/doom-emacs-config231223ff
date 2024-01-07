;;; postload/111_org_compile_latex_NEW.el -*- lexical-binding: t; -*-

(defun org-latex-set-export-dir-and-open-iterm ()
  "Set directory for exports and open iterm to perform makepdf.
Perform this on the dired buffer of the directory containing the latex template
for the document that you want to compile."
  (interactive)
  (goto-line 0) ;; go to line containing the directory name
  (setq org-latex-template-dir (dired-copy-filename-as-kill))
  (+macos/open-in-iterm))

(defun org-latex-export-buffer ()
  "Export buffer as latex, body only.
Save the resulting latex buffer as body.tex inside org-latex-template-dir."
  (interactive)
  (let ((latex-output (org-export-as
                        ;; backend subtreep visible-only body-only ext-plist
                        'latex     nil      nil          t         nil
                        )))
    (with-temp-buffer
      (insert "\\noindent\n") ;; start first paragraph non-indented
      (insert latex-output)
      (write-file (concat org-latex-template-dir "body.tex")
      ))))

(defun org-latex-export-subtree ()
  "Export subtree as latex, body only.
Save the resulting latex buffer as body.tex inside org-latex-template-dir."
  (interactive)
  (let ((latex-output (org-export-as
                        ;; backend subtreep visible-only body-only ext-plist
                        'latex     t        nil          t         nil
                        )))
    (with-temp-buffer
      (insert "\\noindent\n") ;; start first paragraph non-indented
      (insert latex-output)
      (write-file (concat org-latex-template-dir "body.tex")
      ))))
