;;; postload/zzz_scmc_8_tree-sitter.el -*- lexical-binding: t; -*-

(eval-when! (modulep! +tree-sitter)
  (add-hook! 'sclang-mode-local-vars-hook #'tree-sitter!))
