;;; postload/zzz_104_tidal.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tidal cycles

(setq
 tidal-boot-script-path "/Users/iani/.pulsar/packages/tidalcycles/lib/BootTidal.hs"
 tidal-interpreter "/Users/iani/.ghcup/bin/ghci"
 )

(after! tidal
  (define-key tidal-mode-map (kbd "C-1") 'tidal-run-d1)
  (define-key tidal-mode-map (kbd "C-2") 'tidal-run-d2)
  (define-key tidal-mode-map (kbd "C-3") 'tidal-run-d3)
  (define-key tidal-mode-map (kbd "C-4") 'tidal-run-d4)
  (define-key tidal-mode-map (kbd "C-5") 'tidal-run-d5)
  (define-key tidal-mode-map (kbd "C-6") 'tidal-run-d6)
  (define-key tidal-mode-map (kbd "C-7") 'tidal-run-d7)
  (define-key tidal-mode-map (kbd "C-8") 'tidal-run-d8)
  (define-key tidal-mode-map (kbd "C-9") 'tidal-run-d9)
  (define-key tidal-mode-map (kbd "C-0") 'tidal-run-d10)
  (define-key tidal-mode-map (kbd "M-1") 'tidal-stop-d1)
  (define-key tidal-mode-map (kbd "M-2") 'tidal-stop-d2)
  (define-key tidal-mode-map (kbd "M-3") 'tidal-stop-d3)
  (define-key tidal-mode-map (kbd "M-4") 'tidal-stop-d4)
  (define-key tidal-mode-map (kbd "M-5") 'tidal-stop-d5)
  (define-key tidal-mode-map (kbd "M-6") 'tidal-stop-d6)
  (define-key tidal-mode-map (kbd "M-7") 'tidal-stop-d7)
  (define-key tidal-mode-map (kbd "M-8") 'tidal-stop-d8)
  (define-key tidal-mode-map (kbd "M-9") 'tidal-stop-d9)
  (define-key tidal-mode-map (kbd "M-0") 'tidal-stop-d10)
  (define-key tidal-mode-map (kbd "S-<return>") 'tidal-run-line)
  ;; run my fixed version of tidal-run-region
  (define-key tidal-mode-map (kbd "M-<return>") 'tidal-run-region-fixed)
  )

(defun tidal-run-region-fixed ()
  "Run tidal-eval-multiple-lines instead of eval-region."
  (interactive)
  (tidal-eval-multiple-lines))
