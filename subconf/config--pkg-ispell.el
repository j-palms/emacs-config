;;; config--pkg-ispell.el --- Generated package (no.23) from my config -*- lexical-binding: t; -*-
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
;;  Generated package (no.23) from my config.
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

(setq ispell-personal-dictionary
      (expand-file-name "misc/ispell_personal" doom-private-dir))
(after! ispell
    ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
    ;; dictionary' even though multiple dictionaries will be configured
    ;; in next line.
    (setenv "LANG" "en_US.UTF-8")
    (setq ispell-program-name "hunspell")
    ;; Configure German, Swiss German, and two variants of English.
    (setq ispell-dictionary "de_DE,en_US")
    ;; ispell-set-spellchecker-params has to be called
    ;; before ispell-hunspell-add-multi-dic will work
    (ispell-set-spellchecker-params)
    (ispell-hunspell-add-multi-dic "de_DE,en_US")
    ;; For saving words to the personal dictionary, don't infer it from
    ;; the locale, otherwise it would save to ~/.hunspell_de_DE.

    ;; The personal dictionary file has to exist, otherwise hunspell will
    ;; silently not use it.
    (unless (file-exists-p ispell-personal-dictionary)
      (write-region "" nil ispell-personal-dictionary nil 0)))

(provide 'config--pkg-ispell)
;;; config--pkg-ispell.el ends here
