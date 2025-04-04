;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;; (package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;; (package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;; (package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;; (package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)
(unpin! org-roam)
(package! org-roam-ui)

(package! haskell-mode)
(package! lsp-haskell)
(package! tidal)
(package! org-fancy-priorities)
;; 3  :hook (org-mode . org-fancy-priorities-mode)
  ;; :config
  ;; (setq org-fancy-priorities-list '("↑" "→" "↓")))org-fancy-priorities)
(package!
  el-sc :recipe (:type git :host nil :repo "https://doom:ifGdKsph8aBv9FXoDfky@gitlab.com/scLiterate/el-sc.git")
  )

(package!
  ob-sc :recipe (:type git :host nil :repo "https://doom:ifGdKsph8aBv9FXoDfky@gitlab.com/scLiterate/ob-sc.git")
  )

(package!
  ox-sc :recipe (:type git :host nil :repo "https://doom:ifGdKsph8aBv9FXoDfky@gitlab.com/scLiterate/ox-sc.git"
  :files ("*.el" ;;
          ;;
          "*.org"
          ;;"ox-sc-setupfile.*.org"
          )
                       )
  )

(package!
  org-sc :recipe (:type git :host nil :repo "https://doom:ifGdKsph8aBv9FXoDfky@gitlab.com/scLiterate/org-sc.git")
  )

(package!
  sclang-el :recipe (:type git :host nil :repo "https://doom:ifGdKsph8aBv9FXoDfky@gitlab.com/scLiterate/sclang-el.git"
                           :files ("el/*.el")
                           )
  )

(package!
  el-sc-tweaks :recipe (:type git :host nil :repo "https://doom:ifGdKsph8aBv9FXoDfky@gitlab.com/scLiterate/el-sc-tweaks.git")
  )

(package!
  ob-hook-ctrl :recipe (:type git :host nil :repo "https://doom:z54yMaxw_c4E-44XqN5m@gitlab.com/obTools/ob-hook-ctrl.git")
  )

(package!
  ob-tangle-protect-hook :recipe (:type git :host nil
                                :repo "https://doom:z54yMaxw_c4E-44XqN5m@gitlab.com/obTools/ob-tangle-protect-hook.git")
  )


(package! sclang-extensions)
