;;; postload/01_sclang.el -*- lexical-binding: t; -*-

;; (require 'sclang)

(defun sclang-query-recompile ()
  "Recompile SuperCollider sclang Library if user answers y."
  (interactive)
  (if (yes-or-no-p "Recompile sclang library?")
      (sclang-recompile)))

(defun sclang-query-start ()
  "Start SuperCollider if user answers y."
  (interactive)
  (if (yes-or-no-p "Start sclang?")
      (sclang-start)))

(defun sclang-query-stop ()
  "Stop SuperCollider if user answers y."
  (interactive)
  (if (yes-or-no-p "Stop sclang?")
      (sclang-stop)))

(defun sclang-server-query-quit ()
  "Quit the current server."
  (interactive)
  (sclang-perform-server-command "quit"))
;; helper func for opening script on current buffer:
(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
  (file-truename buffer-file-name) ;; return path for further use.
)
(global-set-key "\C-cz" 'show-file-name)

(defun sclang-open-buffer-as-script ()
  "Open OscData gui on path of current buffer"
  (interactive)
  (sclang-eval-string
   (format "OscData.fromPathGui(\"%s\".postln);" (file-truename buffer-file-name))))

(defun sclang-open-buffer-as-preset ()
  "Open OscData gui on path of current buffer"
  (interactive)
  (sclang-eval-string
   (format "PresetList.fromPath(\"%s\".postln).gui;" (file-truename buffer-file-name))))

(defun dired-open-soundfile-selections-script ()
  "Open dired selected file with SfSelections"
  (interactive)
  (message (dired-get-file-for-visit))
  (sclang-open-selections-file (dired-get-file-for-visit)))

(defun sclang-open-selections-file (path)
  (sclang-eval-string
   (concat "\"" path "\".openSoundFileSelections")))

(defun sclang-post-current-environment ()
  "post currentEnvironment"
  (interactive)
  (sclang-eval-string "currentEnvironment.postln;"))
(defun sclang-snippet-bufplay ()
  "play current snippet with Bufplay play: ..."
  (interactive)
  (let ((snippet (sclang-get-current-snippet)))
    (sclang-eval-string
     (format "Bufplay play: \n%s\n" snippet))))

(defun sclang-current-document-path ()
  ""
  (interactive)
  (sclang-eval-string "Document.current.path.postln;"))
; (add-hook 'sclang-mode-hook 'sclang-extensions-mode)
(defun sclang-time-separator ()
  "Insert time separator string //:--[0]"
  (interactive)
  (forward-line)
  (beginning-of-line)
  (insert "//:--[0]
"))

(defun sclang-buffer-gui ()
  "Open OscData gui on current document."
  (interactive)
  (sclang-eval-string "BufferGui.gui;"))

(defun sclang-browse-score ()
  "Open OscData gui on current document."
  (interactive)
  (sclang-eval-string "OscDataFileList.openCurrentDocument;"))

(defun sclang-scope-audio ()
  "Open scserver meter gui."
  (interactive)
  (sclang-eval-string "Server.default.scope;"))

(defun sclang-scope-control ()
  "Open scserver meter gui."
  (interactive)
  (sclang-eval-string "Server.default.scope(rate: 'control');"))

(defun sclang-meter ()
  "Open scserver meter gui."
  (interactive)
  (sclang-eval-string "Server.default.meter;"))

(defun sclang-help ()
  "Open sclang help gui."
  (interactive)
  (sclang-eval-string "Help.gui"))

(defun sclang-startup ()
  "Run thisProcess.startup"
  (interactive)
  (sclang-eval-string "thisProcess.platform.loadStartupFiles;"))

;; start jack
(defun sclang-start-jack ()
  "Start jackd."
  (interactive)
  (async-shell-command " jackd -r -d alsa -r 44100"))

(defun sclang-osc-trace-on ()
  "Turn on OSCFunc trace"
  (interactive)
  (sclang-eval-string "OSCFunc.trace(true)"))

(defun sclang-osc-trace-off ()
  "Turn off OSCFunc trace"
  (interactive)
  (sclang-eval-string "OSCFunc.trace(false)"))

(defun sclang-scundelify ()
  "Convert //: snippet blocks to regular style () sc blocks in document."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\n//:" nil t)
      (replace-match "\n\)\n//:")
      (goto-char (line-end-position 2))
      (goto-char (line-beginning-position 1))
      (insert "\(\n")
      (goto-char (line-beginning-position 1))
      (delete-blank-lines))
    (goto-char (point-min))
    (re-search-forward "\)\n//:" nil t)
    (replace-match "\n://:")))

(defun sclang-server-plot-tree ()
  "Open plotTree for default server."
  (interactive)
  (sclang-eval-string "Server.default.plotTree"))

(defun sclang-server-meter ()
  "Open i/o meter for default server."
  (interactive)
  (sclang-eval-string "Server.default.meter"))

(defun sclang-server-scope (&optional chans)
  "Open scope for default server."
  (interactive "nHow many channels? ")
  (sclang-eval-string (format "Server.default.scope(%s, rate: \\audio)" chans))
  ;; (sclang-eval-string "Server.default.scope")
  )

(defun sclang-server-control-scope (&optional chans)
  "Open scope for default server at control rate."
  (interactive "nHow many channels? ")
  (message "Making control scope with %s channels" chans)
  (sclang-eval-string (format "Server.default.scope(%s, rate: \\control)" chans))
  )

(defun sclang-server-freqscope ()
  "Open frequency scope for default server."
  (interactive)
  (sclang-eval-string "Server.default.freqscope"))

(defun dired-play-soundfile-in-sclang ()
  "Play current file under cursor from dired in sclang, from disk."
  (interactive)
  (message (dired-get-file-for-visit))
  (sclang-play-soundfile (dired-get-file-for-visit)))

(defun sclang-play-soundfile (path)
  (sclang-eval-string
   (concat "\"" path "\".playAudioFile")))

;; ;; (define-key dired-mode-map (kbd "C-c C-p") 'dired-play-soundfile-in-sclang)

(defun sclang-stop-soundfile ()
  "Stop playing soundfile player."
  (interactive)
  (sclang-eval-string "\\diskplayback.stop"))

;; ;; (define-key dired-mode-map (kbd "C-c C-s") 'sclang-stop-soundfile)

(defun sclang-insert-+> ()
  "Insert +>."
  (interactive)
  (insert "+> \\"))

 (defun sclang-insert-comment-with-date ()
  "Insert /* datestamp nl */ "
  (interactive)
  (insert "/* ")
  (insert (format-time-string "%e %b %Y %H:%M"))
  (insert "\n\n*/")
  (backward-char 3)
  )

(defun sclang-insert-snippet-with-date ()
  "Insert //: datestamp nl /* */ "
  (interactive)
  (insert "//: ")
  (insert (format-time-string "%e %b %Y %H:%M"))

  (insert "\n/*\n\n*/")
  (previous-line 2))

(defun sclang-extensions-gui ()
  "Open gui for browsing user extensions classes and methods.
    Type return on a selected item to open the file where it is defined."
  (interactive)
  (sclang-eval-string "Class.extensionsGui;"))

(defun sclang-reset-server-options ()
  "Reset server options from scripts of sc-hacks.
Run all scd files found in ~/sc-hacks-config/serveroptions
or its subdirectories."
  (interactive)
  ;; TODO : implement this ...
  (sclang-eval-string "Hacks.serverConfig")
  )
