;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org" "~/org/journal/" "~/org/roam" "~/org/roam/daily"))
(setq org-support-shift-select t)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka")))))

(let ((user-packages (concat doom-private-dir "user-packages/*"))
      (postload (concat doom-private-dir "postload/*.el")))
  (message "looking for user packages in: %s" user-packages)
  (message "found: %s" (file-expand-wildcards user-packages))
  (message "looking for postload items in: %s" postload)
  (message "found: %s" (file-expand-wildcards postload))
  (mapcar (lambda (path)
            (add-to-list 'load-path (concat path "/")))
          (file-expand-wildcards user-packages))
  (mapcar (lambda (path)
            (message "loading: %s" path)
            (load-file path))
          (file-expand-wildcards postload))
  )

;; (use-package! undo-tree
;;   :config
;;   (global-undo-tree-mode))

(map! :leader
      :desc "desktop read" "d r" #'desktop-read
      :desc "dailies capture today" "d c" #'org-roam-dailies-capture-today
      :desc "org-mark-ring-goto" "m g o" #'org-mark-ring-goto
      :desc "org-cycle" "m g c" #'org-mark-ring-goto
      :desc "started date active" "o a s" #'org-set-started-date-active
      :desc "started date inactive" "o a S" #'org-set-started-date-inactive
      :desc "entered date active" "o a e" #'org-set-entered-date-active
      :desc "entered date inactive" "o a E" #'org-set-entered-date-inactive
      :desc "done date active" "o a d" #'org-set-done-date-active
      :desc "done date inactive" "o a D" #'org-set-done-date-inactive
      :desc "calendar" "o c" #'calendar
      :desc "calc" "o C" #'calc
      ; :desc "find folder in project" "p F" #'projectile-find-dir
      :desc "org mark element" "o m" #'org-mark-element
      ;; (:prefix-map ("e" . "input encoding")
       :desc "toggle input encoding method" "e" #'toggle-encoding
       ;; :desc "toggle" "t" #'toggle-encoding
       ;; :desc "english ucs" "e" #'set-encoding-ucs)
       (:prefix-map ("v" . "various iani")
       :desc "projectile commander" "p" #'projectile-use-commander
       :desc "projectile find dir" "d" #'projectile-find-dir
       :desc "evil mode" "e" #'evil-mode
       :desc "undo tree" "t" #'undo-tree-mode)
       (:prefix-map ("k" . "scsynth")
       :desc "boot server" "B" #'sclang-server-boot
       :desc "start jack" "j" #'sclang-start-jack
       :desc "server meter" "m" #'sclang-meter
       :desc "server tree" "t" #'sclang-server-plot-tree
       :desc "record" "r" #'sclang-server-record
       :desc "stop recording" "R" #'sclang-server-stop-recording
       :desc "stop recording" "f" #'sclang-server-stop-recording
       :desc "server scope audio" "s a" #'sclang-scope-audio
       :desc "server scope control" "s c" #'sclang-scope-audio
       :desc "quit server" "Q" #'sclang-server-query-quit
       :desc "reset server options" "o" #'sclang-reset-server-options)
      (:prefix-map ("j" . "SuperCollider")
       (:prefix ("l" . "sclang")
       :desc "sclang open script" "o" #'sclang-open-buffer-as-script
       :desc "sclang open script" "O" #'sclang-open-buffer-as-preset
       :desc "sclang post currentEnvironment" "e" #'sclang-post-current-environment
       :desc "sclang cmd period" "." #'sclang-main-stop
       :desc "query start sclang" "S" #'sclang-query-start
       :desc "sclang run startup" "u" #'sclang-startup
       :desc "sclang open help" "h" #'sclang-help
       :desc "query stop sclang" "Q" #'sclang-query-stop
       :desc "query recompile library" "L" #'sclang-query-recompile
       :desc "show post buffer" "p" #'sclang-show-post-buffer
       :desc "clear post buffer" "c" #'sclang-clear-post-buffer
       :desc "switch to workspace" "w" #'sclang-switch-to-workspace
       :desc "Open score browser on current document" "B" #'sclang-browse-score
       :desc "Open Buffer gui" "b" #'sclang-buffer-gui
       ;; :desc "duplicate current snippet" "d" #'sclang-duplicate-current-snippet
       )
       (:prefix ("s" . "sclang-snippets")
        :desc "sclang copy snippet" "c" #'sclang-copy-current-snippet
        :desc "sclang duplicate snippet" "d" #'sclang-duplicate-current-snippet
        :desc "sclang cut snippet" "x" #'sclang-cut-current-snippet
        :desc "sclang cut snippet" "u" #'sclang-cut-current-snippet
        :desc "insert time snippet separator" "t" #'sclang-time-separator
        :desc "sclang previous snippet" "p" #'sclang-goto-previous-snippet
        :desc "sclang next snippet" "n" #'sclang-goto-next-snippet
        :desc "sclang eval snippet" "e" #'sclang-eval-current-snippet
        :desc "sclang eval snippet" "." #'sclang-eval-current-snippet
        :desc "sclang forward snippet heading" "j" #'sclang-goto-next-heading
        :desc "sclang backward snippet heading" "k" #'sclang-goto-previous-heading
        )
       (:prefix ("e" . "sclang-eval")
       :desc "eval line" "l" #'sclang-eval-line
       :desc "eval snippet" "." #'sclang-eval-current-snippet
       )
       (:prefix ("o" . "OSC")
       :desc "start tracing" "s" #'sclang-osc-trace-on
       :desc "quit tracing" "q" #'sclang-osc-trace-off
       )
       (:prefix ("j" . "server")
       :desc "boot server" "b" #'sclang-server-boot
       :desc "start jack" "j" #'sclang-start-jack
       :desc "server meter" "m" #'sclang-meter
       :desc "server tree" "t" #'sclang-server-plot-tree
       :desc "record" "r" #'sclang-server-record
       :desc "stop recording" "R" #'sclang-server-stop-recording
       :desc "server scope audio" "a" #'sclang-scope-audio
       :desc "server scope control" "c" #'sclang-scope-control
       :desc "quit server" "q" #'sclang-server-quit
       :desc "reset server options" "o" #'sclang-reset-server-options)
       ;; :desc "run server config scripts" "c" #'sclang-server-config
       :desc "browse builtin classes" "B" #'sclang-browse-definitions
       :desc "browse user extension classes" "E" #'sclang-extensions-gui)
      (:prefix-map ("l" . "latex")
       (:prefix ("b" . "buffer")
        ;;; TODO : replace org-journal-new-entry with real commands
        :desc "pdflatex -> pdf" "p" #'pdflatex-compile-buffer
        :desc "xelatex -> pdf" "x" #'xelatex-compile-buffer
        :desc "lualatex -> pdf" "l" #'lualatex-compile-buffer
        :desc "edit template" "e" #'org-journal-new-entry
        :desc "reveal template path" "r" #'org-journal-new-entry
        :desc "set template path" "t" #'org-journal-search)
       (:prefix ("s" . "subtree")
        :desc "pdflatex -> pdf" "p" #'org-journal-new-entry
        :desc "xelatex -> pdf" "x" #'org-journal-new-entry
        :desc "lualatex -> pdf" "l" #'org-journal-new-entry
        :desc "edit template" "e" #'org-journal-new-entry
        :desc "reveal template path" "r" #'org-journal-new-entry
        :desc "set template path" "t" #'org-journal-search))
      (:prefix ("b" . "buffer")
        :desc "pdflatex -> pdf" "p" #'org-journal-new-entry
        :desc "xelatex -> pdf" "x" #'org-journal-new-entry
        :desc "lualatex -> pdf" "l" #'org-journal-new-entry
        :desc "edit template" "e" #'org-journal-new-entry
        :desc "reveal template path" "r" #'org-journal-new-entry
        :desc "set template path" "t" #'org-journal-search))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-roam-ui:

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t
        org-roam-directory (expand-file-name "~/org/roam/")
        diary-file (expand-file-name "~/org/roam/etc/diary")
        ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;haskell
(setq haskell-stylish-on-save t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tidal cycles
(setq tidal-boot-script-path "~/.config/emacs/.local/straight/repos/Tidal/BootTidal.hs")
;; (setq tidal-boot-script-path "~/.pulsar/packages/tidalcycles/lib/BootTidal.hs")
