;;; postload/08_projectile_use_commander.el -*- lexical-binding: t; -*-

(setq projectile-switch-project-action #'projectile-commander)
(defun projectile-use-commander ()
  "Use commander when switching project."
  (interactive)
  (setq projectile-switch-project-action #'projectile-commander)
  (message "Activated projectile commander"))
