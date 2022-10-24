;;; config--pkg-theme-magic.el --- Generated package (no.33) from my config -*- lexical-binding: t; -*-
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
;;  Generated package (no.33) from my config.
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
;;   (package! theme-magic :pin "844c4311bd26ebafd4b6a1d72ddcc65d87f074e3")
;;
;;; Code:

(use-package! theme-magic
  :commands theme-magic-from-emacs
  :config
  (defadvice! theme-magic--auto-extract-16-doom-colors ()
    :override #'theme-magic--auto-extract-16-colors
    (list
     (face-attribute 'default :background)
     (doom-color 'error)
     (doom-color 'success)
     (doom-color 'type)
     (doom-color 'keywords)
     (doom-color 'constants)
     (doom-color 'functions)
     (face-attribute 'default :foreground)
     (face-attribute 'shadow :foreground)
     (doom-blend 'base8 'error 0.1)
     (doom-blend 'base8 'success 0.1)
     (doom-blend 'base8 'type 0.1)
     (doom-blend 'base8 'keywords 0.1)
     (doom-blend 'base8 'constants 0.1)
     (doom-blend 'base8 'functions 0.1)
     (face-attribute 'default :foreground))))

(provide 'config--pkg-theme-magic)
;;; config--pkg-theme-magic.el ends here
