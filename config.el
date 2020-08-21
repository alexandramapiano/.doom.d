;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))


;; General Configuration -------------
;;             __
;;      (___()'`;
;;      /,    /`
;;      \\"--\\
;;
(setq
 user-full-name "Earnest Ma"
 doom-font(font-spec :family "Jetbrains Mono" :size 18)
 doom-big-font(font-spec :family "Jetbrains Mono" :size 33)
 doom-theme 'doom-one
 display-line-numbers-type t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For elative line numbers, set this to `relative'.

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ----------------- Org-Mode Configuration -----------------------------
;;
;;
;;              |\      _,,,---,,_
;;        ZZZzz /,``'-'`'    -.  ;-;;,_
;;             |,4-  ) )-,_. ,\ (  `'-'
;;            '---''(_/--'  `-'\_)
;;
;; ----------------------------------------------------------------------

;; org config goes here
(use-package! org
  :defer t
  :ensure org-plus-contrib
  :init
  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n!)" "PROJ(p!)" "|" "DONE(x!)"
                                 )
                       (sequence "WAITING(w@/!)" "SMDAY(s@/!)" "|" "CANCELLED(c@/!)" "PHONE(P)" "MEETING(M)"
                                 )
                       ))
  :custom
  (org-directory "~/org/")
  (calendar-latitude 43.7682) ;;Toronto, ON, Canada
  (calendar-longitude -79.4126)
  (org-treat-S-cursor-todo-selection-as-state-change nil)
  (org-global-properties (quote (("Effort_ALL" . "0:05 0:10 0:15 0:20 0:30 0:45 1:00 1:30 2:00 4:00 6:00 8:00"))
                                ))
  (org-tag-alist (quote ((:startgroup)
                         ;; LOCATIONS
                         ("@errands" . ?E)
                         ("@office" . ?O)
                         ("@home" . ?H)
                         (:endgroup)
                         ;; DEVICES
                         (:startgroup)
                         ("computer" . ?c)
                         ("server" . ?s)
                         (:endgroup)
                         ;; CONTEXTS
                         ("work" . ?w)
                         ("email" . ?e)
                         ("learning" . ?l)
                         ("self" . ?s)
                         ("home" . ?h)
                         )
                        ))
  (org-enforce-todo-dependencies t)
  (org-log-into-drawer "LOGBOEK")
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-refile-use-outline-path nil)
  (org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
  )

;; org-capture config
(use-package! org-capture
  :after org
  :bind (("C-c c" . org-capture))
  )

;; org-agenda config
(use-package! org-agenda
  :after org
  :bind (("C-c a" . org-agenda))
  :custom
  (org-agenda-files '("~/org/"))
  (org-agenda-dim-blocked-tasks t)
  (org-agenda-span 1)
  (org-agenda-start-on-weekday 1)
  (org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (org-agenda-skip-deadline-if-done nil)
  (org-agenda-skip-scheduled-if-done nil)
  )

;; org-journal config
(use-package! org-journal
  :after org
  :diminish org-journal-mode
  :bind (("C-c t" . org-journal-new-entry))
  :init
  (setq org-journal-prefix-key "C-c j")
  :custom
  (org-journal-dir "~/org/logboek/")
  (org-journal-file-type 'weekly)
  (org-journal-file-format "%Y-%m-%d.org")
  )

;; org-crypt config
;; This is my current org-crypt config
;; Peeking in .gitignore will tell you that it's called org-crypt-config.el
;; (use-package org-crypt
;; :after org
;; :init
;; (org-crypt-use-before-save-magic)
;; :custom
;; (org-crypt-key "AAAAAAAA...")
;; )
(load! "org-crypt-config.el")
