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

;; these don't work?????
;; (setq centaur-tabs-height 52)
;; Now I seem to be getting 2 tabs one below the other.

;; (setq centaur-tabs-set-icons t)


;;  -*- lexical-binding: t; -*-
;; (message "-- config -- [lang | SuperCollider] config.el")

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

(use-package! el-sc-tweaks
 ;; :when (and (modulep! +el_sc) (modulep! +el_sc_tweaks))
  :after el-sc
  ;; :init
  ;; « ref_el-sc-tweaks-el_sc_tweaks-init»
  ;; :config
  ;; « ref_el-sc-tweaks-el_sc_tweaks-config»
  )

;; (use-package! sclang-extensions
;;  ;; :when (modulep! +sclang_extensions)
;;   :after sclang
;;   :init
;;   (message "@@ use-package @@ sclang-extensions +sclang_extensions performing :init")
;;   :config
;;   (message "@@ use-package @@ sclang-extensions +sclang_extensions performing :config")

;;   (add-hook 'sclang-mode-hook 'sclang-extensions-mode)

;;   (setq sclang-run-supercollider-if-not-active? nil)

;;   (setq sclang-bury-post-on-start? nil)

;;   (define-key sclang-extensions-mode-map (kbd "C-c C-l") nil) ;; mc unset double of C-c C-f
;;   (define-key sclang-extensions-mode-map (kbd "C-c C-c") nil) ;; mc unset override (prefer re-mapped C-c C-d)

;;   ;; (advice-remove 'sclang-mode 'use-sclang-post-buffer-mode) ;;; new syntax not working
;;   (eval-after-load "sclang-extensions"
;;     '(progn
;;        (ad-disable-advice 'sclang-mode 'around 'use-sclang-post-buffer-mode)
;;        (ad-activate 'sclang-mode)))

;;   (if (eq company-global-modes t)
;;       (setq company-global-modes '(not sclang-mode))
;;     (if (eq (car-safe company-global-modes) 'not)
;;         (add-to-list 'company-global-modes 'sclang-mode t)
;;       (message "\n  +++++ Check company-global-modes config -- unsure how to add sclang-mode \n")
;;       (warn "+++++ Check company-global-modes config -- not adding sclang-mode")))

;;   (scl:defun-memoized scl:method-arg-info (class method-name)
;;     "Get the name and description of each argument for a method. "
;;     (let ((k (scl:ensure-non-meta-class class)))
;;       (or
;;        ;; Try class method. ;;; mc: No, try instance method doc first.
;;        (scl:request
;;         (concat "SCDoc.getMethodDoc(\"%s\", \"-%s\", false)" ;;; mc
;;                 ".findChild(\\METHODBODY)"
;;                 ".findChild(\\ARGUMENTS).children.collect{|x| "
;;                 "[x.text, x.findChild(\\PROSE).findChild(\\TEXT).text] "
;;                 "} ") k method-name)
;;        ;; Try instance method. ;;; mc: No, try class method doc second.
;;        (scl:request
;;         (concat "SCDoc.getMethodDoc(\"%s\", \"*%s\", false)" ;;; mc
;;                 ".findChild(\\METHODBODY)"
;;                 ".findChild(\\ARGUMENTS).children.collect{|x| "
;;                 "[x.text, x.findChild(\\PROSE).findChild(\\TEXT).text] " "} ")
;;         k method-name))))

;;   (defun scl:method-at-point ()
;;     "Return a method info for the method at point."
;;     (-when-let* ((class (or (scl:class-of-thing-at-point) "AbstractFunction"))
;;                  (method (scl:symbol-near-point)))
;;       ;; Try the class as is, as well as the meta-class.

;;       (if (s-starts-with? "Meta_" class)
;;           (->> (scl:all-methods class)
;;                (-map 'scl:method-item)
;;                (-remove 'null)
;;                (--first (equal (car it) (symbol-name method))))
;;         (or
;;          (->> (scl:all-methods class)
;;               (-map 'scl:method-item)
;;               (-remove 'null)
;;               (--first (equal (car it) (symbol-name method))))

;;          (->> (scl:all-methods (concat "Meta_" class))
;;               (-map 'scl:method-item)
;;               (-remove 'null)
;;               (--first (equal (car it) (symbol-name method))))))))

;;   ;; (require 'ob-sclang) ;; commented for testing [2022-07-04 Mo]

;;   (cl-defun scl:blocking-eval-string (expr &optional (timeout-ms 50))
;;     "Ask SuperCollider to evaluate the given string EXPR. Wait a maximum TIMEOUT-MS."
;;     ;; (message "expr:: %S" expr) ;;; why the hell this string has so strange properies?
;;     ;; (message "noPr:: %S" (substring-no-properties expr)) ;;; this is the way to go
;;     ;; (message "noPr:: %s" (substring-no-properties expr)) ;;; small '%s' not escaped!
;;     (unless (s-blank? expr)
;;       (let ((result nil)
;;             ;; -- ;;; Is this the faster solution? Don't thing so.
;;             ;; -- ;;; Still not sure, if it really works this way [2015-03-05 Thu].
;;             ;; (elapsed 0)
;;             ;; fmt
;;             )
;;         ;; Prevent expressions from crashing sclang.
;;         ;;     (setq fmt (format "{ var res; Interpreter.postCompileErrors_(false);
;;         ;; res = try { (%S).interpret.asCompileString } {|err| err};
;;         ;; Interpreter.postCompileErrors_(true);
;;         ;; Emacs.message(res) }.value" (substring-no-properties expr)))

;;         ;;         ;; SuperCollider will eval the string and then call back with the result.
;;         ;;         ;; We rebind Emacs' `message' action to intercept the response.
;;         ;;         ;; -- ;;; mc: chapeau! But VERY hard to debug!
;;         ;;         ;; -- ;;  There must be no intermediate message until receive!
;;         ;;         ;; -- ;;; cannot post at all or put something like this:
;;         ;;         ;; -- ;; (\"sc-res: \" + res).postln;
;;         ;;         (flet ((message (str &rest _) (setq result str)))
;;         ;;           (sclang-eval-string fmt)
;;         ;;           ;; Block until we receive a response or the timeout expires.
;;         ;;           (while (and (not result) (> timeout-ms elapsed))
;;         ;;             (sleep-for 0 10)
;;         ;;             (setq elapsed (+ 10 elapsed)))
;;         ;;           result)
;;         ;;         ;; ---

;;         ;; -- ;;; result can either be a syntax or an evaluation error.
;;         ;; -- ;;; This difference doesn't matter for the purposes here.
;;         ;; -- ;;; Any error should return a propper elsip nel value here.

;;         ;; ;; -- ;;; elegant syntax but slower?, definitely cleaner and more robust.
;;         (setq result (sclang-eval-sync-results-code-post-no-errors
;;                       (substring-no-properties expr))) ;;; no properties did the trick!

;;         (when (s-equals? "nil" result)
;;           (setq result nil))

;;         ;; ;;; this become redundant while sending string "nil" for exec error, too.
;;         ;; (when (s-contains? "ERROR:" result)
;;         ;;   (message "There was not a syntax but an evaluation ERROR.")
;;         ;;   (setq result "nil")) ;;

;;         ;; (message "res: %s" result)
;;         result
;;         ;; ;; ----

;;         )))

;;   (scl:defun-memoized scl:methods (class)
;;     "Return a list of methods implemented by CLASS."
;;     (unless (s-blank? class)
;;       (scl:request "%s.methods.collect {|m| [m.name, m.ppArgumentString, m.ownerClass] }"
;;                    class)))

;;   (defun scl:clear-all-caches ()
;;     (interactive)
;;     (setq scl:methods-cache (make-hash-table :test 'equal))
;;     (setq scl:all-methods-cache (make-hash-table :test 'equal))
;;     (setq scl:instance-vars-cache (make-hash-table :test 'equal))
;;     (setq scl:class-vars-cache (make-hash-table :test 'equal))
;;     (setq scl:superclasses-cache (make-hash-table :test 'equal))
;;     (setq scl:subclasses-cache (make-hash-table :test 'equal))
;;     (setq scl:class-summary-cache (make-hash-table :test 'equal))
;;     )

;;   (defun scl:class-of-thing-at-point ()
;;     "Return the class of the sclang expression at point."
;;     (scl:logged
;;       ;; Find the first sclang token in the expression.
;;       (let* ((words
;;               (-map 's-trim
;;                     (-> (buffer-substring-no-properties
;;                          (scl:expression-start-pos)
;;                          (point))
;;                         (s-trim)
;;                         (split-string (rx (any "."))))))
;;              (token (nth 0 words))
;;              (next  (nth 1 words)))
;;         ;; (message "words: %s \n  token: %s next: %s" words token next)
;;         (cond
;;          ;; Return immediately for literals.
;;          ((null token)                nil)
;;          ((s-starts-with? "[" token)  "Array")
;;          ((s-ends-with? "]" token)    "Array")
;;          ((s-starts-with? "\"" token) "String")
;;          ((s-ends-with? "\"" token)   "String")
;;          ((s-starts-with? "\\" token) "Symbol")
;;          ((s-starts-with? "'" token)  "Symbol")
;;          ;; ((s-starts-with? "~" token)  "Buffer") ;;; mc: Buffer???, no it's a var!
;;          ((and (s-numeric? token)
;;                next
;;                (s-numeric? next)      "Float"))
;;          ((s-numeric? token)          "Integer")
;;          ;; Evaluate with SuperCollider.
;;          (t
;;           (-when-let (response (scl:class-of token)) ;;; if nil body not evaluated
;;             ;; (message "token response %s" response)
;;             response))))))
;;   )

;; (use-package! ox-sc
;;  ;; :when (and (modulep! +el_sc) (modulep! +ox_sc)) ;
;;   :after el-sc
;;   ;; :init
;;   ;; « ref_ox-sc-ox_sc-init»
;;   ;; :config
;;   ;; « ref_ox-sc-ox_sc-config»
;;   )

(use-package! org-sc
 ;; :when (modulep! +org_sc)
  :after sclang
  ;; :init
  ;; « ref_org-sc-org_sc-init»
  ;; :config
  ;; « ref_org-sc-org_sc-config»
  )

;; (use-package! ob-sc
;;  ;; :when (and (modulep! +ob_sc) (modulep! :babel ob-hook-ctrl))
;;   :after sclang
;;   ;; :init
;;   ;; « ref_ob-sc-ob_sc-init»
;;   ;; :config
;;   ;; « ref_ob-sc-ob_sc-config»
;;   )

(eval-when! (modulep! +tree-sitter)
  (add-hook! 'sclang-mode-local-vars-hook #'tree-sitter!))
