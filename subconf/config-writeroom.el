;;; config-writeroom.el --- Generated package (no.45) from my config -*- lexical-binding: t; -*-
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
;;  Generated package (no.45) from my config.
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
;;; Code:

(require 'config--pkg-mixed-pitch)

(setq +zen-text-scale 0.8)
(defvar +zen-serif-p t
  "Whether to use a serifed font with `mixed-pitch-mode'.")
(defvar +zen-org-starhide t
  "The value `org-modern-hide-stars' is set to.")

(after! writeroom-mode
  (defvar-local +zen--original-org-indent-mode-p nil)
  (defvar-local +zen--original-mixed-pitch-mode-p nil)
  (defun +zen-enable-mixed-pitch-mode-h ()
    "Enable `mixed-pitch-mode' when in `+zen-mixed-pitch-modes'."
    (when (apply #'derived-mode-p +zen-mixed-pitch-modes)
      (if writeroom-mode
          (progn
            (setq +zen--original-mixed-pitch-mode-p mixed-pitch-mode)
            (funcall (if +zen-serif-p #'mixed-pitch-serif-mode #'mixed-pitch-mode) 1))
        (funcall #'mixed-pitch-mode (if +zen--original-mixed-pitch-mode-p 1 -1)))))
  (defun +zen-prose-org-h ()
    "Reformat the current Org buffer appearance for prose."
    (when (eq major-mode 'org-mode)
      (setq display-line-numbers nil
            visual-fill-column-width 60
            org-adapt-indentation nil)
      (when (featurep 'org-modern)
        (setq-local org-modern-star '("🙘" "🙙" "🙚" "🙛")
                    ;; org-modern-star '("🙐" "🙑" "🙒" "🙓" "🙔" "🙕" "🙖" "🙗")
                    org-modern-hide-stars +zen-org-starhide)
        (org-modern-mode -1)
        (org-modern-mode 1))
      (setq
       +zen--original-org-indent-mode-p org-indent-mode)
      (org-indent-mode -1)))
  (defun +zen-nonprose-org-h ()
    "Reverse the effect of `+zen-prose-org'."
    (when (eq major-mode 'org-mode)
      (when (bound-and-true-p org-modern-mode)
        (org-modern-mode -1)
        (org-modern-mode 1))
      (when +zen--original-org-indent-mode-p (org-indent-mode 1))))
  (pushnew! writeroom--local-variables
            'display-line-numbers
            'visual-fill-column-width
            'org-adapt-indentation
            'org-modern-mode
            'org-modern-star
            'org-modern-hide-stars)
  (add-hook 'writeroom-mode-enable-hook #'+zen-prose-org-h)
  (add-hook 'writeroom-mode-disable-hook #'+zen-nonprose-org-h))

(provide 'config-writeroom)
;;; config-writeroom.el ends here
