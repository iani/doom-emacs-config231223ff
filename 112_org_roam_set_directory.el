;;; 112_org_roam_set_directory.el -*- lexical-binding: t; -*-

(defun org-roam-set-directory ()
  "Read a directory path interactively from the user.
  Set org-roam-directory to that path and update org-roam database."
  (interactive)
  (let ((new-directory
         (read-directory-name
          "select an org-roam directory: "
          (file-truename "~/org/roam")
          (file-truename "~/org/roam")
          )))
    (message "Setting roam directory to %s" new-directory)
    (setq org-roam-directory new-directory)
    (org-roam-db-sync)
    (message "Updated org-roam-db to %s" new-directory)))
