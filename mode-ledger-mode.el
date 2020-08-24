;;; mode-ledger-mode.el -*- lexical-binding: t; -*-

(use-package! ledger-mode
  :ensure t
  :defer t
  :custom
  (ledger-clear-whole-transactions 1)
  (ledger-post-auto-align t)
  :mode "\\.dat\\'"
  )
