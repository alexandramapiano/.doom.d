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
(fset 'yes-or-no-p 'y-or-n-p)
(prefer-coding-system 'utf-8)

;; Prompt when unsaved buffers before quitting Emacs Daemon.
;; emacsclient -e '(kill-emacs)'
;; emacsclient -e '(client-save-kill-emacs)'
(load! "emacs-daemon-quit-prompt.el")

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
;;                                              t h i s   i s   l o n g
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
  :config
  (setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n!)" "|" "DONE(x!)"
                                 )
                       (sequence "WAITING(w@/!)" "SMDAY(s@/!)" "|" "CANCELLED(c@/!)" "PHONE(P)" "MEETING(M)"
                                 )
                       ))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "yellow" :weight bold)
                ("NEXT" :foreground "white" :weight bold)
                ("PROJ" :foreground "green" :weight bold)
                ("WAITING" :foreground "blue" :weight bold)
                ("SMDAY" :foreground "cyan")
                ("PHONE" :foreground "gray")
                ("MEETING" :foreground "gray")
                )))
  (setq org-todo-state-tags-triggers
        (quote (("CANCELLED" ("CANCELLED" . t) ("WAITING") ("SMDAY"))
                ("WAITING" ("WAITING" . t))
                ("SMDAY" ("SMDAY" . t))
                ("DONE" ("WAITING") ("SMDAY") ("CANCELLED"))
                ("TODO" ("WAITING") ("CANCELLED") ("SMDAY"))
                ("NEXT" ("WAITING") ("CANCELLED") ("SMDAY")))))
  :custom
  (org-directory "~/org/")
  (calendar-latitude 43.7682)   ;; Toronto, ON, Canada -> Change to your location
  (calendar-longitude -79.4126) ;; Try M-x sunrise-sunset
  (org-modules '(org-crypt
                 org-habit
                 org-clock
                 ol-bibtex
                 ol-bbdb
                 ol-docview
                 ol-info
                 ol-irc
                 ol-w3m
                 ol-gnus
                 ol-mhe
                 ol-rmail
                 ol-eww
                 org-protocol
                 ))
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
  ;;(org-tags-exclude-from-inheritance '("ex" "ex2"))
  (org-columns-set-default-format "%80ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM")
  (org-treat-S-cursor-todo-selection-as-state-change nil)
  (org-enforce-todo-dependencies t)
  (org-log-into-drawer "LOGBOOK")
  (org-use-fast-todo-selection 'auto)
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-refile-use-outline-path 'file)
  (org-refile-targets '((org-agenda-files . (:maxlevel . 4))))
  (org-log-done 'time)
  (org-log-reschedule 'note)
  (org-habit-show-habits-only-for-today t) ;;alternate - nil
  (org-clock-into-drawer "CLOCKING")
  )

;; org-capture config
(use-package! org-capture
  :after org
  :bind (("C-c c" . org-capture))
  :custom
  (org-default-notes-file "~/org/actie.org")
  (org-capture-templates
   `(("t" "Task" entry (file, "~/org/actie.org")
      "* TODO %^{Task}\n:PROPERTIES:\n- Added: %U\n:END:"
      :empty-lines 1 :immediate-finish t :clock-resume :kill-buffer)
     ("h" "New Habit" entry (file, "~/org/actie.org")
      "* TODO %^{Habit}\nSCHEDULED: %^{Next due date and frequency}t\n:PROPERTIES:\n:STYLE: habit\n:END:"
      ;;You still have to manually put in the frequency for now :(
      :empty-lines 1 :immediate-finish t :clock-resume :kill-buffer)
     ("r" "Reviews")
     ("rd" "Daily Review" entry (file+olp+datetree, "~/org/beoordeling.org")
      (file "~/org/templates/review-daily.org")
      :immediate-finish t)
     ("rw" "Weekly Review" entry (file+olp+datetree, "~/org/beoordeling.org")
      (file "~/org/templates/review-weekly.org")
      :immediate-finish t)
     )
   )
  )

;; org-agenda config
(use-package! org-agenda
  :after org
  :bind (("C-c a" . org-agenda))
  :custom
  (org-agenda-window-setup 'other-window) ;;options include other-window, current-window, only-window, reorganize-frame, other-frame
  (org-agenda-restore-windows-after-quit 't)
  (org-agenda-files '("~/org/"))
  (org-agenda-dim-blocked-tasks t)
  (org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (org-agenda-skip-deadline-if-done nil)
  (org-agenda-skip-scheduled-if-done nil)
  (org-agenda-span 4)
  (org-agenda-start-on-weekday nil)
  (org-agenda-start-day "-1d")
  )
(evil-set-initial-state 'org-agenda-mode 'emacs)

;; org-journal config
(use-package! org-journal
  :after org
  :diminish org-journal-mode
  :bind (("C-c t" . org-journal-new-entry))
  :init
  (setq org-journal-prefix-key "C-c j")
  :preface
  (defun org-journal-file-header-func (time)
    "Custom function to create journal header."
    (concat
      (pcase org-journal-file-type
       (`daily "#+TITLE: Dagelijks dagboek\n#+STARTUP: showeverything")
       (`weekly "#+TITLE: Wekelijks dagboek\n#+STARTUP: folded")
       (`monthly "#+TITLE: Maandelijks dagboek\n#+STARTUP: folded")
       (`yearly "#+TITLE: Jaarlijks dagboek \n#+STARTUP: folded")
     )))
  :custom
  (org-journal-dir "~/org/logboek/")
  (org-journal-file-type 'weekly)
  (org-journal-file-format "%V_%Y-%m.org")
  (org-journal-date-format "%A, %d %B %Y")
  (org-journal-file-header 'org-journal-file-header-func)
  )


;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at (point))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

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


;; ledger-mode
;;
(load! "mode-ledger-mode.el")


;;          _______           _    E N D  O F
;;     _.-'|+__|__-|'-._,.-(((_)   C O N F I G  F I L E
