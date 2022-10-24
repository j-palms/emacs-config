;;; config--pkg-org-gtd.el --- Generated package (no.75) from my config -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 TEC
;;
;; Author: TEC <https://git.tecosaur.net/tec>
;; Maintainer: TEC <contact@tecosaur.net>
;; Created: October 24, 2022
;; Modified: October 24, 2022
;; Version: 2022.10.24
;; Homepage: https://git.tecosaur.net/tec/emacs-config
;; Package-Requires: ((emacs "27.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Generated package (no.75) from my config.
;;
;;  This is liable to have unstated dependencies, and reply on other bits of
;;  state from other configuration blocks. Only use this if you know /exactly/
;;  what you are doing.
;;
;;  This may function nicely as a bit of self-contained functionality, or it
;;  might be a horrid mix of functionalities and state.
;;
;;  Hopefully, in future static analysis will allow this to become more
;;  properly package-like.
;;
;;  Package statement:
;;   (package! org-gtd :recipe (:host github :repo "j-palms/org-gtd.el"))
;;
;;; Code:

(require 'org)

(use-package! org-gtd
  :after org
  :custom
  (org-gtd-directory "~/org/gtd")
  (org-edna-use-inheritance t)
  :config
  (org-edna-mode)
  (map! :prefix "C-c"
        "d c" #'org-gtd-capture
        "d e" #'org-gtd-engage
        "d p" #'org-gtd-process-inbox
        "d n" #'org-gtd-show-all-next
        "d s" #'org-gtd-show-stuck-projects
        "d a" #'org-gtd-archive-completed-items)
  (map! :map org-gtd-process-map
        "C-c c" #'org-gtd-choose))
;; (setq org-capture-templates
;;       `(("s" "Slipbox" entry  (file "notes/inbox.org")
;;          "* %?\n")))

(defun josua/set-org-capture-templates ()
  (interactive)
  (setq org-capture-templates
      `(("i" "Inbox" entry  (file "gtd/inbox.org")
         ,(concat "* %?\n"
                 ;;":PROPERTIES:\n"
                 ;;":CATEGORY: %\1 %\\1 \n"
                 ;;":END:\n"
                  "/Entered on/ %U"))
        ("s" "Slipbox" entry  (file "notes/inbox.org")
         "* %?\n"))))

(josua/set-org-capture-templates)

(map! "C-c C" #'org-capture)

(defun jethro/org-capture-inbox ()
  (interactive)
  (org-capture nil "i"))

(defun jethro/org-capture-slipbox ()
  (interactive)
  (org-capture nil "s"))

(provide 'config--pkg-org-gtd)
;;; config--pkg-org-gtd.el ends here
