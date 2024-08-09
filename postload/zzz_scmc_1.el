;;; postload/zzz_scmc_1.el -*- lexical-binding: t; -*-

(use-package! sclang
  :commands (sclang-start sclang-mode)
  :bind (("C-c M-S" . sclang-start))
  :init
  (eval-after-load 'sclang-interp
    '(progn
       ;; (message " -- eval-after-load sclang-interp -- fboundp sclang-customize: %S" (fboundp 'sclang-customize))
       (unless (fboundp 'sclang-customize) ;; prevent to trigger loading of `sclang.el' twice!
         (require 'sclang))
       ))
  :config
  (when (and (modulep! +tree-sitter)
             (modulep! :tools tree-sitter)
             (modulep! :tools tree-sitter-ext))
    ;; (message "@@ use-package @@ sclang :config — +tree-sitter")
    (after! evil-textobj-tree-sitter
      (pushnew! evil-textobj-tree-sitter-major-mode-language-alist
                '(sclang-mode . "supercollider"))
      ;; (message "@@ use-package @@ sclang :config — evil-textobj-tree-sitter-major-mode-language-alist: %S" evil-textobj-tree-sitter-major-mode-language-alist)
      ))

  (when (and (modulep! +window_purpose) (modulep! :ui window-purpose))
    (after! sclang-interp
      ;; (message "@@ use-package @@ el-sc +el_sc set special window-purpose for: %s" sclang-post-buffer)
      (add-to-list 'purpose-user-name-purposes (cons sclang-post-buffer 'sc-post))
      (add-to-list 'purpose-user-name-purposes (cons sclang-workspace-buffer 'sc-work))
      ;; (add-to-list 'purpose-user-name-purposes (cons
      ;;                                           (concat sclang-workspace-buffer "dummy*")
      ;;                                           'sc-work))
      (purpose-compile-user-configuration) ; activates your changes
      ))

  (when (and (modulep! +mc_popup_rules) (modulep! :ui popup))
    (set-popup-rule! "\\(*Definitions*\\|*References*\\)"
                     :slot 3
                     :vslot 3
                     ;; :height 0.1
                     :size #'+popup-shrink-to-fit
                     ;; :modeline t
                     :select t
                     )
    )

  (when (modulep! :tools lookup)
    (set-lookup-handlers! 'sclang-mode
      :documentation #'sclang-find-help-in-gui
      ))
  )
