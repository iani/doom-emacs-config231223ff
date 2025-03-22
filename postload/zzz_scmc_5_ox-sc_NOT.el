;;; postload/zz_scmc_5_ox-sc.el -*- lexical-binding: t; -*-

(use-package! ox-sc
;;   :when (and (modulep! +el_sc) (modulep! +ox_sc)) ;
 :after el-sc
 :init
    (message "Ich werde geladen")
    (require 'ox-org)
    (message "Ich WURDE geladen")
;;   ;; « ref_ox-sc-ox_sc-init»
    ;; :config
;;   ;; « ref_ox-sc-ox_sc-config»
    :config
    (message "ox-sc WURDE geladen")

   )

(require 'ox-org)
(message "Ich WURDE geladen ausserhalb von use-package!")
