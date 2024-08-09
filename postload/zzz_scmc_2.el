;;; postload/zzz_scmc_2.el -*- lexical-binding: t; -*-

(use-package! el-sc
  ;; :when (modulep! +el_sc)
  :after sclang
  ;; :init
  ;; « ref_el-sc-el_sc-init»
  :config
  (defun sclang-set-default-directory-of-non-file-visiting-buffers ()
    (unless
        ;; (or (local-variable-p 'default-directory)
        (or (buffer-file-name)
            (string-match "^ \\*temp\\*" (buffer-name)) ;;; without this, we kill tangling
            )
      ;; )
      ;; (setq default-directory el-sc-userAppSupportDir)
      (setq default-directory el-sc-gtags-root)
      ;; (message " sclang-set-default-directory-of-non-file-visiting-buffers: %s %s" (current-buffer) default-directory)
      ))

  (add-hook 'sclang-mode-hook #'sclang-set-default-directory-of-non-file-visiting-buffers)

  (when (and (modulep! +gtags)
             (modulep! :tools gtags))
    (when (or (modulep! :tools gtags +ggtags_in_org)
              (modulep! :tools gtags +helm_gtags_in_org))
      ;; (message "@@ use-package @@ el-sc +el_sc :config support for org-mode ")
      (add-to-list '+gtags-doom-lookup-ob-lang-list "sclang"))

    (when (modulep! :tools gtags +ggtags)
      ;; (message "@@ use-package @@ el-sc +el_sc :config requiring ggtags")
      (require 'ggtags)

      (add-hook 'sclang-mode-hook 'ggtags-mode) ;;; nice highlighting

      ;; (add-hook! 'sclang-mode-hook
      ;;   (defun ggtags-mode-with-fixed-gtags-root ()
      ;;     (setq-local ggtags-process-environment
      ;;                 (append ggtags-process-environment
      ;;                         (list (format "GTAGSROOT=%s" el-sc-gtags-root))))
      ;;     (message "[ggtags-mode-with-fixed-gtags-root] ggtags-process-environment: %S" ggtags-process-environment)
      ;;     (ggtags-mode 1)))
      )

    (when (modulep! :tools gtags +helm_gtags)
      (eval-after-load 'helm-gtags
        '(progn
           (defun el-sc--set-gtags-root-a (fun &optional &rest args)
             (if (el-sc-sclang-buffer-or-src-block-p) ;; in order to make this predicate
                 (let ((helm-gtags-direct-helm-completing t) ;; work, we must set this!
                       (process-environment (copy-sequence process-environment)))
                   (setenv "GTAGSROOT" el-sc-gtags-root)
                   ;; (setenv "GTAGSCONF" el-sc-gtags-conf) redundant
                   (apply fun args))
               (apply fun args)))
           (advice-add 'helm-gtags--read-tagname :around #'el-sc--set-gtags-root-a)
           (advice-add 'helm-gtags--tag-directory :around #'el-sc--set-gtags-root-a)
           (advice-add 'helm-gtags--find-tag-simple :around #'el-sc--set-gtags-root-a)
           ))

      ;; (message "@@ use-package @@ el-sc +el_sc :config requiring helm-gtags")
      (require 'helm-gtags)
      (add-hook 'sclang-mode-hook 'helm-gtags-mode) ;;; cool navigation
      )
    )
  )
