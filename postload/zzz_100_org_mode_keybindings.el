;;; postload/zzz_100_org_mode_keybindings.el -*- lexical-binding: t; -*-

(after! 'org
     (define-key org-mode-map (kbd "C-M-{") 'backward-paragraph)
     (define-key org-mode-map (kbd "C-M-}") 'forward-paragraph)
     (define-key org-mode-map (kbd "C-c C-S") 'org-schedule)
     (define-key org-mode-map (kbd "C-c C-s") 'sclang-main-stop)

  )
