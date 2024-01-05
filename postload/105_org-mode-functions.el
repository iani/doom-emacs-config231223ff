;;; postload/05_org-mode-utils.el -*- lexical-binding: t; -*-
;; Mon Aug  9 13:03:57 2021

;; 1 date_entered 2 date_scheduled 3 date_done 4 date_due

;;===== 1 DATE_ENTERED ACTIVE
(defun org-set-entered-date-active ()
  "Set DATE_ENTERED property with active timestamp from user."
  (interactive)
  (org-set-property
   "DATE_ENTERED"
   (concat
    "<"
    (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
    ">")))

;;===== DATE_ENTERED INACTIVE
(defun org-set-entered-date-inactive ()
  "Set DATE_DUE property with inactive timestamp from user."
  (interactive)
  (org-set-property
   "DATE_ENTERED"
   (concat
           "["
           ;; (substring
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
           ;; 1 -1)
           "]")))

;;===== 2 DATE_SCHEDULED ACTIVE
(defun org-set-scheduled-date-active ()
  "Set DATE_SCHEDULED property with active timestamp from user."
  (interactive)
  (org-set-property
   "DATE_SCHEDULED"
   (concat
    "<"
   (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
   ">")))

;;===== DATE_SCHEDULED INACTIVE
(defun org-set-scheduled-date-inactive ()
  "Set DATE_DUE property with inactive timestamp from user."
  (interactive)
  (org-set-property
   "DATE_SCHEDULED"
   (concat
           "["
          ;; (substring
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
         ;;   1 -1)
           "]")))

;;===== 3 DATE_DONE ACTIVE
(defun org-set-done-date-active ()
  "Set DATE_DONE property with active timestamp from user."
  (interactive)
  (org-set-property
   "DATE_DONE"
   (concat
    "<"
   (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
   ">")))

;;===== DATE_DONE INACTIVE
(defun org-set-done-date-inactive ()
  "Set DATE_DONE property with inactive timestamp from user."
  (interactive)
  (org-set-property
   "DATE_DONE"
   (concat
           "["
           ;; (substring
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
           ;; 1 -1)
           "]")))

;;===== 4. DATE_DUE ACTIVE
(defun org-set-due-date-active ()
  "Set DATE_DUE property with active timestamp from user."
  (interactive)
  (org-set-property
    "DATE_DUE"
   (concat
    "<"
    (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
    ">")))

;;===== DATE_DUE INACTIVE
(defun org-set-due-date-inactive ()
  "Set DATE_DONE property with inactive timestamp from user."
  (interactive)
  (org-set-property
   "DATE_DUE"
   (concat
    "["
    ;; (substring
    (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
    ;; 1 -1)
    "]")))



(defun org-set-date-from-user-active ()
  "Set DATE property with active timestamp from user "
  (interactive)
  (org-set-property
   "DATE"
   (concat
    "<"
   (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
   ">")))

(defun org-set-date-from-user-inactive ()
  "Set DATE property with current time. Inactive timestamp."
  (interactive)
  (org-set-property
   "DATE"
   (concat
           "["
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
           "]")))

(defun org-set-date (&optional active property)
  "Set DATE property with current time, in style according to prefix argument."
  (interactive "P")
  (org-set-property
   (if property property "DATE")
   (cond ((equal active nil)
          (format-time-string (cdr org-time-stamp-formats) (current-time)))
         ((equal active '(64))
          (concat "["
                  (substring
                   (format-time-string (cdr org-time-stamp-formats) (current-time))
                   1 -1)
                  "]"))
         ((equal active '(16))
          (concat
           "["
           (substring
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
            1 -1)
           "]"))
         ((equal active '(4))
          (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))))))

(defun org-insert-current-date (arg)
  "Insert current date in format readable for org-capture minibuffer.
        If called with ARG, use japanese/american military format YYMMDD."
  (interactive "P")
  (if arg
      (insert (format-time-string "%y%m%d"))
    (insert (format-time-string "%a %e %b %Y %H:%M"))))

(defun org-insert-current-time (arg)
  "Insert current time in short format HH:MM"
  (interactive "P")
  (insert (format-time-string "%H:%M")))

;; (defun org-insert-current-date (arg)
;;   "Insert current date in format readable for org-capture minibuffer.
;;         If called with ARG, use japanese/american military format YYMMDD."
;;   (interactive "P")
;;   (if arg
;;       (insert (format-time-string "%y%m%d"))
;;     (insert (format-time-string "%e %b %Y %H:%M"))))

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make heading movement commands skip initial * marks
(defun org-jump-forward-heading-same-level (&optional do-cycle)
  "Jump forward heading same level, and skip to beginning of heading itself."
  (interactive "P")
  (org-forward-heading-same-level 1)
  (re-search-forward " ")
  (if do-cycle (org-cycle)))

(defun org-jump-backward-heading-same-level (&optional do-cycle)
  "Jump backward heading same level, and skip to beginning of heading itself."
  (interactive "P")
  (org-backward-heading-same-level 1)
  (re-search-forward " ")
  (if do-cycle (org-cycle)))

(defun jump-outline-up-heading (&optional do-cycle)
  "Jump upward heading, and skip to beginning of heading itself."
  (interactive "P")
  (outline-up-heading 1)
  (re-search-forward " ")
  (if do-cycle (org-cycle)))

(defun jump-outline-next-visible-heading ()
  "Jump to next visible heading, and skip to beginning of heading itself."
  (interactive)
  (outline-next-visible-heading 1)
  (re-search-forward " "))

(defun jump-outline-previous-visible-heading ()
  "Jump to previous visible heading, and skip to beginning of heading itself."
  (interactive)
  (outline-previous-visible-heading 1)
  (re-search-forward " "))

(defun jump-outline-previous-visible-heading-and-cycle ()
  "Jump to previous visible heading, and hide subtree."
  (interactive)
  (outline-previous-visible-heading 1)
  (re-search-forward " ")
  (org-cycle))

(defun jump-outline-next-visible-heading-and-cycle ()
  "Jump to previous visible heading, and hide subtree."
  (interactive)
  (outline-next-visible-heading 1)
  (re-search-forward " ")
  (org-cycle))

(defun org-find-next-src-block ()
  "Search for next #+BEGIN_SRC block header."
  (interactive)
  (re-search-forward "\\#\\+BEGIN_SRC " nil t))

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun org-copy-contents ()
  "Copy contents of current section to kill ring."
  (interactive)
  (let* ((element (org-element-at-point))
         (begin (plist-get (cadr element) :contents-begin))
         (end (plist-get (cadr element) :contents-end)))
    (copy-region-as-kill begin end)))

(defun org-next-src-block ()
  "Jump to the next src block using SEARCH-FORWARD."
  (interactive)
  (search-forward "\n#+BEGIN_SRC")
  (let ((block-beginning (point)))
    (org-show-entry)
    (goto-char block-beginning)
    (goto-char (line-end-position 2))))

(defun org-show-properties-block ()
  "Show the entire next properties block using SEARCH-FORWARD."
  (interactive)
  (search-forward ":PROPERTIES:")
  (let ((block-beginning (point)))
    (org-show-entry)
    (goto-char block-beginning)
    (org-cycle)
    ;; (goto-char (line-end-position 2))
    ;; (org-hide-block-toggle t)
    ))

;; org-mode-hook is run every time that org-mode is turned on for a buffer
;; It customizes some settings in the mode.
(add-hook
 'org-mode-hook
 (lambda ()
           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; own stuff:
   ;; Make javascript blocks open in sclang mode in org-edit-special
   ;; This is because sclang blocks must currently be marked as javascript
   ;; in order to render properly with hugo / pygments for webite creation.
   ;; (setq org-src-lang-modes (add-to-list 'org-src-lang-modes '("javascript" . sclang)))
   ;; (setq org-hide-leading-stars t)
   ;; (org-indent-mode) ;; this results in added leading spaces in org-edit-special
   (visual-line-mode)
   ;; turn off prelude mode because its key bindings interfere with table bindings.
   ;; Instead, the prelude-mode keybindings have been copied to org-mode above,
   ;; minus the unwanted keybindings for tables.
   ;; (prelude-off)
   ;; disable whitespace mode, which was previously disabled by prelude-mode
   ;; (org-bullets-mode)
   (whitespace-mode -1)
   ))

;; (defun org-customize-mode ()
;;   "Customize some display options for ORG-MODE.
;; - map javascript to sclang-mode in babel blocks.
;; - hide extra leading stars for sections.
;; - turn on visual line mode."
;; )

(global-set-key (kbd "C-c C-x t") 'org-insert-current-date)
(global-set-key (kbd "C-c C-x T") 'org-insert-current-time)
(provide 'org_mode_utils_and_key_map)
;;; 029_org_mode_utils_and_key_map.el ends here
