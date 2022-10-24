;;; config--pkg-avy.el --- Generated package (no.11) from my config -*- lexical-binding: t; -*-
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
;;  Generated package (no.11) from my config.
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

;;;; Avy: Colemak layout not detected (ErgoDox not mentioned in dmesg).
(after! avy
  ;; home row priorities: 8 6 4 5 - - 1 2 3 7
  ;;(setq avy-keys '(?n ?e ?i ?s ?t ?r ?i ?a)))
  (setq avy-keys '(?a ?r ?s ?t ?n ?e ?i ?o)))

(provide 'config--pkg-avy)
;;; config--pkg-avy.el ends here
