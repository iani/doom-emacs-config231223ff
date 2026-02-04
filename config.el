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
;; (setq doom-theme 'doom-one)
;; overriding default doom-theme 'doom-one to something else (changing over time):
(setq doom-theme 'doom-zenburn)
;; (setq doom-theme 'doom-peacock)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-agenda-files '("~/org" "~/org/journal/" "~/org/roam" "~/org/roam/daily"))
(setq org-support-shift-select t)
;; (setq org-fancy-priorities-list '("↑" "→" "↓"))
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
 '(default ((t (:family "Iosevka" :weight light :height 180)))))

(set-fontset-font t 'greek (font-spec :family "Helvetica" :weight 'normal :height 0.75))

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

;; (define-package org-fancy-priorities)
;; (use-package! undo-tree
;;   :config
;;   (global-undo-tree-mode))

(map! :leader
      :desc "backslash" "_" #'insert-backslash
      :desc "dired do symink" "m d" #'dired-do-symlink
      :desc "yank from kill ring" "m y" #'yank-from-kill-ring
      :desc "org-roam-set-directory" "n r d" #'org-roam-set-directory
      :desc "org-roam-db-sync" "n r s" #'org-roam-db-sync
      :desc "fix fonts" "o x" #'fix-fonts
      :desc "capture date" "d D" #'org-roam-dailies-capture-date
      :desc "org roam find file" "n r f" #'org-roam-node-find
      :desc "org roam insert file" "n r i" #'org-roam-node-insert
      :desc "consult org roam backlinks" "n r b" #'consult-org-roam-backlinks
      :desc "consult org roam forward links" "n r l" #'consult-org-roam-forward-links
      :desc "consult org roam file find" "n r F" #'consult-org-roam-file-find
      :desc "desktop read" "d r" #'desktop-read
      :desc "dailies capture today" "d c" #'org-roam-dailies-capture-today
      ;; just because I keep typing "t" for "today" ...
      :desc "dailies capture today" "d t" #'org-roam-dailies-capture-today
      :desc "dailies find date" "d d" #'org-roam-dailies-find-date
      :desc "dailies find next" "d n" #'org-roam-dailies-find-next-note
      :desc "dailies find previous" "d p" #'org-roam-dailies-find-previous-note
      :desc "org-mark-ring-goto" "m g o" #'org-mark-ring-goto
      :desc "org-cycle" "m g c" #'org-mark-ring-goto
      ;; ----------- set various date properties --------------
      :desc "checked date inactive" "t c" #'org-set-checked-date-inactive
      :desc "started date active" "t S" #'org-set-scheduled-date-active
      :desc "started date inactive" "t s" #'org-set-scheduled-date-inactive
      :desc "entered date active" "t E" #'org-set-entered-date-active
      :desc "entered date inactive" "t e" #'org-set-entered-date-inactive
      :desc "done date active" "t D" #'org-set-done-date-active
      :desc "done date inactive" "t d" #'org-set-done-date-inactive
      :desc "due date active" "t U" #'org-set-due-date-active
      :desc "due date inactive" "t u" #'org-set-due-date-inactive
      :desc "calendar" "o c" #'calendar
      :desc "calc" "o C" #'calc
      ; :desc "find folder in project" "p F" #'projectile-find-dir
      :desc "org mark element" "o m" #'org-mark-element
      ;; (:prefix-map ("e" . "input encoding")
       :desc "toggle greek input encoding method" "e" #'toggle-greek-encoding
       :desc "toggle japanese input encoding method" "J" #'toggle-japanese-encoding
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
       :desc "sclang open OscMonitor gui" "m" #'sclang-osc-monitor
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
       :desc "org latex set export dir and open terminal" "t" #'org-latex-set-export-dir-and-open-iterm
       :desc "org latex export buffer" "b" #'org-latex-export-buffer
       :desc "org latex export subtree" "s" #'org-latex-export-subtree
       )
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
;;haskell wv
(setq haskell-stylish-on-save t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; latex ...

;; from https://github.com/doomemacs/doomemacs/issues/955
;; customize this to run with xelatex or lualatex ...
;; or to run bibtex etc. ...
;; (after! latex
;;     (add-to-list 'TeX-command-list '("LatexMk" "latexmk -pdflatex='pdflatex -file-line-error -synctex=1' -pdf %t" TeX-run-TeX nil)))

;; from sclang settings - adapt this to add latex path ...
;; (setq exec-path (append exec-path '("/Applications/SuperCollider.app/Contents/MacOS")))
;; also you should try setting PATH by adapting the code given in
;; https://emacs.stackexchange.com/questions/41738/set-environment-variables-for-spawned-subprocesses
;; (getenv  "PATH")
(setenv "PATH" (concat (getenv  "PATH") ":/Library/TeX/texbin"))
(add-to-list 'exec-path "/opt/homebrew/bin")
(setenv "PATH" (concat "/opt/homebrew/bin:" (getenv "PATH")))
;; these don't work?????
;; (setq centaur-tabs-height 52)
;; Now I seem to be getting 2 tabs one below the other.

;; (setq centaur-tabs-set-icons t)


;;  -*- lexical-binding: t; -*-
;; (message "-- config -- [lang | SuperCollider] config.el")
;; ------------ SCLANG

;; Fixing ag?
(after! projectile
  (setq projectile-generic-command "rg --files --hidden --follow --glob '!.git/'")
  (map! :map projectile-command-map
        "a" #'projectile-ripgrep))

(after! counsel
  (setq counsel-grep-base-command
        "rg -i -M 120 --no-heading --line-number --color never %s ."))

;; If anything still tries to call ag, kill it hard:
(setq ag-executable nil)
(after! projectile

  ;; ✅ OVERRIDE projectile-ag to use the SYSTEM ag binary directly
  ;; ✅ Does NOT depend on the ag.el Emacs package
  ;; ✅ Will NEVER say "Package 'ag' is not available"

  (defun projectile-ag (search-term &optional arg)
    "Run ag directly via shell using SEARCH-TERM in the project.
With optional prefix ARG, treat SEARCH-TERM as a regexp."
    (interactive
     (list (projectile--read-search-string-with-default
            (format "Ag %ssearch for"
                    (if current-prefix-arg "regexp " "")))
           current-prefix-arg))

    (if (executable-find "ag")
        (let* ((root (projectile-acquire-root))
               (command
                (if arg
                    (format "ag --regexp '%s' %s" search-term root)
                  (format "ag '%s' %s" search-term root))))
          ;; ✅ Run via compilation so results are clickable
          (compilation-start command 'grep-mode))
      (error "ag executable not found in PATH")))
  (define-key projectile-command-map (kbd "a")
              #'consult-ripgrep))
(after! ag
  ;; Force ag.el to use Projectile's project root cleanly
  (setq ag-project-root-function #'projectile-project-root)
  ;; Avoid weird directory prompts
  (setq ag-reuse-buffers t))

(after! org
  (require 'ox)
  (require 'ox-ascii)
  ;; (set-face-attribute 'org-level-1 nil :height 1.6 :weight 'bold)
  ;; (set-face-attribute 'org-level-2 nil :height 1.4 :weight 'bold)
  ;; (set-face-attribute 'org-level-3 nil :height 1.25 :weight 'bold)
  ;; (set-face-attribute 'org-level-4 nil :height 1.15 :weight 'bold)

  (let ((serif1 "Palatino")
        (serif2 "TeX Gyre Pagella"))
    (set-face-attribute 'org-level-1 nil :family serif1 :height 1.65 :weight 'bold)
    (set-face-attribute 'org-level-2 nil :family serif1 :height 1.45 :weight 'bold)
    (set-face-attribute 'org-level-3 nil :family serif2 :height 1.30 :weight 'semi-bold)
    (set-face-attribute 'org-level-4 nil :family serif2 :height 1.18 :weight 'semi-bold)
    (set-face-attribute 'org-level-5 nil :family serif2 :height 1.1 :weight 'semi-bold)
    (set-face-attribute 'org-level-6 nil :family serif2 :height 1.05 :weight 'semi-bold)
    (set-face-attribute 'org-level-7 nil :family serif2 :height 1.0 :weight 'semi-bold)
    (set-face-attribute 'org-level-8 nil :family serif2 :height 1.0 :weight 'semi-bold)
    ))

(after! ox
  (require 'ox-ascii)
  )

(use-package! ox-ascii
  :after org
  :config
  (setq org-ascii-charset 'utf-8))

(map! :leader
      :desc "Export Org → TXT (UTF-8)"
      "m e t"
      #'org-ascii-export-to-ascii)

(defun my/org-export-with-pandoc ()
  "Export current Org buffer to DOCX via Pandoc."
  (interactive)
  (let ((outfile (concat (file-name-sans-extension buffer-file-name) ".docx")))
    (shell-command
     (format "pandoc %s -o %s"
             (shell-quote-argument buffer-file-name)
             (shell-quote-argument outfile)))
    (message "Exported to %s" outfile)))

(map! :leader
      :desc "Org → Pandoc (DOCX)"
      "m e P"
      #'my/org-export-with-pandoc)

(defun my/org-pandoc-export-apa-docx-debug ()
  "Debug export Org to DOCX with APA using Pandoc."
  (interactive)
  (let* ((infile (buffer-file-name))
         (outfile (concat (file-name-sans-extension infile) ".docx"))
         (bibfile (expand-file-name "references.bib"))
         (cslfile (expand-file-name "~/.csl/apa.csl"))
         (cmd (format
               "pandoc %s --citeproc --bibliography=%s --csl=%s -o %s"
               (shell-quote-argument infile)
               (shell-quote-argument bibfile)
               (shell-quote-argument cslfile)
               (shell-quote-argument outfile))))
    (message "Running: %s" cmd)
    (async-shell-command cmd "*Pandoc Export Debug*")))

(map! :leader
      :desc "Org → Pandoc APA DOCX (DEBUG)"
      "m e A"
      #'my/org-pandoc-export-apa-docx-debug)

(defun my/org-pandoc-export-apa-docx ()
  "Export Org to DOCX with APA citations via Pandoc."
  (interactive)
  (let* ((infile buffer-file-name)
         (outfile (concat (file-name-sans-extension infile) ".docx")))
    (shell-command
     (format
      "pandoc %s --citeproc --bibliography=references.bib --csl=%s -o %s"
      (shell-quote-argument infile)
      (shell-quote-argument "~/.csl/apa.csl")
      (shell-quote-argument outfile)))
    (message "Exported with APA citations to %s" outfile)))

(defun my/org-pandoc-export-apa-docx ()
  "Export Org → Markdown → DOCX with APA citations (robust Pandoc pipeline)."
  (interactive)
  (let* ((infile (file-truename buffer-file-name))
         (base   (file-name-sans-extension infile))
         (mdfile (concat base ".md"))
         (outfile (concat base ".docx"))
         (bibfile "/Users/iani/Documents/Projects/IMAGINE_MOCAP_ELIDEK_Kyriakoulakos240101/PapersFromTeam/PapersIonio/ZannosCarleDCAC25_Paper/references.bib")
         (cslfile "/Users/iani/.csl/apa.csl")
         (cmd (format
               "pandoc %s -f org -t markdown -o %s && pandoc %s --citeproc --bibliography=%s --csl=%s -o %s"
               (shell-quote-argument infile)
               (shell-quote-argument mdfile)
               (shell-quote-argument mdfile)
               (shell-quote-argument bibfile)
               (shell-quote-argument cslfile)
               (shell-quote-argument outfile))))
    (message "Running: %s" cmd)
    (shell-command cmd "*Pandoc Export*")))

(map! :leader
      :desc "Org → Pandoc APA DOCX via md"
      "m e a"
      #'my/org-pandoc-export-apa-docx)
;; (use-package citeproc)

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -jobname=%b %f"
        "biber %b"
        "pdflatex -interaction nonstopmode -jobname=%b %f"
        "pdflatex -interaction nonstopmode -jobname=%b %f"))



