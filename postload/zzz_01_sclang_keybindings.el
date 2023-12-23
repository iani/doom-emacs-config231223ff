;;; postload/zzz_01_sclang_keybindings.el -*- lexical-binding: t; -*-

(after! 'sclang
  (define-key sclang-mode-map (kbd "C-M-.") 'sclang-snippet-bufplay)
  (define-key sclang-mode-map (kbd "C-M-.") 'sclang-snippet-bufplay)
  (define-key sclang-mode-map (kbd "C-h g s") 'sclang-startupfiles-gui)
  (define-key sclang-mode-map (kbd "C-h g a") 'sclang-audiofiles-gui)
  (define-key sclang-mode-map (kbd "C-h g p") 'sclang-players-gui)
  (define-key sclang-mode-map (kbd "C-h g e") 'sclang-extensions-gui)
  (define-key sclang-mode-map (kbd "C-h g n") 'sclang-nevent-gui)
  (define-key sclang-mode-map (kbd "C-S-s") 'hydra-snippets/body)
  (define-key sclang-mode-map (kbd "C-S-l") 'hydra-sclang/body)
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Server state visualisation utilities
  ;; TODO: Check and re-assign these commands for consistency with
  ;; default sclang commands C-c C-p x:
  (define-key sclang-mode-map (kbd "C-c P p") 'sclang-server-plot-tree)
  (define-key sclang-mode-map (kbd "C-c P m") 'sclang-server-meter)
  (define-key sclang-mode-map (kbd "C-c P s") 'sclang-server-scope)
  (define-key sclang-mode-map (kbd "C-c P f") 'sclang-server-freqscope)
  (define-key sclang-mode-map (kbd "M-T") 'sclang-cut-current-snippet)
  (define-key sclang-mode-map (kbd "C-M-N") 'sclang-transpose-snippet-down)
  (define-key sclang-mode-map (kbd "C-M-P") 'sclang-transpose-snippet-up)

  (define-key sclang-mode-map (kbd "C-M-S-t")
              'sclang-eval-current-snippet-with-timer)

  ;; (define-key sclang-mode-map (kbd "M-C-.") 'sclang-duplicate-current-snippet)
  ;; (define-key sclang-mode-map (kbd "M-n") 'sclang-goto-next-snippet)
  ;; (define-key sclang-mode-map (kbd "M-N") 'sclang-eval-next-snippet)
  ;; (define-key sclang-mode-map (kbd "M-C-S-n") 'sclang-move-snippet-down)
  ;; (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
  ;; (define-key sclang-mode-map (kbd "M-P") 'sclang-eval-previous-snippet)
  ;; (define-key sclang-mode-map (kbd "M-C-S-p") 'sclang-move-snippet-up)X

  (define-key sclang-mode-map (kbd "H-=") 'sclang-insert-snippet-separator+)
  (define-key sclang-mode-map (kbd "H-8") 'sclang-insert-snippet-separator*)
  (define-key sclang-mode-map (kbd "C-M-=") 'sclang-insert-+>)
  (define-key sclang-mode-map (kbd "C-M-;") 'sclang-insert-comment-with-date)

       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Miscellaneous
  (define-key sclang-mode-map (kbd "C-S-c c") 'sclang-clear-post-buffer)
  (define-key sclang-mode-map (kbd "C-M-=") 'sclang-insert-+>)
  (define-key sclang-mode-map (kbd "C-\"") 'sclang-insert-comment-with-date)
  (define-key sclang-mode-map (kbd "C-M-\"") 'sclang-insert-snippet-with-date)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Does this have effect?

(set-fontset-font
   t 'greek
   (font-spec :family "Helvetica" :weight 'normal :height 0.75))
