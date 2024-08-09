;;; postload/zzz_scmc_4_sclang-extensions.el -*- lexical-binding: t; -*-

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
