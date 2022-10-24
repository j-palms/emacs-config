;;; config-irc.el --- Generated package (no.55) from my config -*- lexical-binding: t; -*-
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
;;  Generated package (no.55) from my config.
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

(defun auth-server-pass (server)
  (if-let ((secret (plist-get (car (auth-source-search :host server)) :secret)))
      (if (functionp secret)
          (funcall secret) secret)
    (error "Could not fetch password for host %s" server)))

(defun register-irc-auths ()
  (require 'circe)
  (require 'dash)
  (let ((accounts (-filter (lambda (a) (string= "irc" (plist-get a :for)))
                           (auth-source-search :require '(:for) :max 10))))
    (appendq! circe-network-options
              (mapcar (lambda (entry)
                        (let* ((host (plist-get entry :host))
                               (label (or (plist-get entry :label) host))
                               (_ports (mapcar #'string-to-number
                                               (s-split "," (plist-get entry :port))))
                               (port (if (= 1 (length _ports)) (car _ports) _ports))
                               (user (plist-get entry :user))
                               (nick (or (plist-get entry :nick) user))
                               (channels (mapcar (lambda (c) (concat "#" c))
                                                 (s-split "," (plist-get entry :channels)))))
                          `(,label
                            :host ,host :port ,port :nick ,nick
                            :sasl-username ,user :sasl-password auth-server-pass
                            :channels ,channels)))
                      accounts))))
(after! circe
  (setq-default circe-use-tls t)
  (setq circe-notifications-alert-icon "/usr/share/icons/breeze/actions/24/network-connect.svg"
        lui-logging-directory (expand-file-name "irc" doom-etc-dir)
        lui-logging-file-format "{buffer}/%Y/%m-%d.txt"
        circe-format-self-say "{nick:+13s} ┃ {body}")

  (custom-set-faces!
    '(circe-my-message-face :weight unspecified))

  (enable-lui-logging-globally)
  (enable-circe-display-images)

  (defun lui-org-to-irc ()
    "Examine a buffer with simple org-mode formatting, and converts the empasis:
  *bold*, /italic/, and _underline_ to IRC semi-standard escape codes.
  =code= is converted to inverse (highlighted) text."
    (goto-char (point-min))
    (while (re-search-forward "\\_<\\(?1:[*/_=]\\)\\(?2:[^[:space:]]\\(?:.*?[^[:space:]]\\)?\\)\\1\\_>" nil t)
      (replace-match
       (concat (pcase (match-string 1)
                 ("*" "")
                 ("/" "")
                 ("_" "")
                 ("=" ""))
               (match-string 2)
               "") nil nil)))
  
  (add-hook 'lui-pre-input-hook #'lui-org-to-irc)

  (defun lui-ascii-to-emoji ()
    (goto-char (point-min))
    (while (re-search-forward "\\( \\)?::?\\([^[:space:]:]+\\):\\( \\)?" nil t)
      (replace-match
       (concat
        (match-string 1)
        (or (cdr (assoc (match-string 2) lui-emojis-alist))
            (concat ":" (match-string 2) ":"))
        (match-string 3))
       nil nil)))
  
  (defun lui-emoticon-to-emoji ()
    (dolist (emoticon lui-emoticons-alist)
      (goto-char (point-min))
      (while (re-search-forward (concat " " (car emoticon) "\\( \\)?") nil t)
        (replace-match (concat " "
                               (cdr (assoc (cdr emoticon) lui-emojis-alist))
                               (match-string 1))))))
  
  (define-minor-mode lui-emojify
    "Replace :emojis: and ;) emoticons with unicode emoji chars."
    :global t
    :init-value t
    (if lui-emojify
        (add-hook! lui-pre-input #'lui-ascii-to-emoji #'lui-emoticon-to-emoji)
      (remove-hook! lui-pre-input #'lui-ascii-to-emoji #'lui-emoticon-to-emoji)))
  (defvar lui-emojis-alist
    '(("grinning"                      . "😀")
      ("smiley"                        . "😃")
      ("smile"                         . "😄")
      ("grin"                          . "😁")
      ("laughing"                      . "😆")
      ("sweat_smile"                   . "😅")
      ("joy"                           . "😂")
      ("rofl"                          . "🤣")
      ("relaxed"                       . "☺️")
      ("blush"                         . "😊")
      ("innocent"                      . "😇")
      ("slight_smile"                  . "🙂")
      ("upside_down"                   . "🙃")
      ("wink"                          . "😉")
      ("relieved"                      . "😌")
      ("heart_eyes"                    . "😍")
      ("yum"                           . "😋")
      ("stuck_out_tongue"              . "😛")
      ("stuck_out_tongue_closed_eyes"  . "😝")
      ("stuck_out_tongue_wink"         . "😜")
      ("zanzy"                         . "🤪")
      ("raised_eyebrow"                . "🤨")
      ("monocle"                       . "🧐")
      ("nerd"                          . "🤓")
      ("cool"                          . "😎")
      ("star_struck"                   . "🤩")
      ("party"                         . "🥳")
      ("smirk"                         . "😏")
      ("unamused"                      . "😒")
      ("disapointed"                   . "😞")
      ("pensive"                       . "😔")
      ("worried"                       . "😟")
      ("confused"                      . "😕")
      ("slight_frown"                  . "🙁")
      ("frown"                         . "☹️")
      ("persevere"                     . "😣")
      ("confounded"                    . "😖")
      ("tired"                         . "😫")
      ("weary"                         . "😩")
      ("pleading"                      . "🥺")
      ("tear"                          . "😢")
      ("cry"                           . "😢")
      ("sob"                           . "😭")
      ("triumph"                       . "😤")
      ("angry"                         . "😠")
      ("rage"                          . "😡")
      ("exploding_head"                . "🤯")
      ("flushed"                       . "😳")
      ("hot"                           . "🥵")
      ("cold"                          . "🥶")
      ("scream"                        . "😱")
      ("fearful"                       . "😨")
      ("disapointed"                   . "😰")
      ("relieved"                      . "😥")
      ("sweat"                         . "😓")
      ("thinking"                      . "🤔")
      ("shush"                         . "🤫")
      ("liar"                          . "🤥")
      ("blank_face"                    . "😶")
      ("neutral"                       . "😐")
      ("expressionless"                . "😑")
      ("grimace"                       . "😬")
      ("rolling_eyes"                  . "🙄")
      ("hushed"                        . "😯")
      ("frowning"                      . "😦")
      ("anguished"                     . "😧")
      ("wow"                           . "😮")
      ("astonished"                    . "😲")
      ("sleeping"                      . "😴")
      ("drooling"                      . "🤤")
      ("sleepy"                        . "😪")
      ("dizzy"                         . "😵")
      ("zipper_mouth"                  . "🤐")
      ("woozy"                         . "🥴")
      ("sick"                          . "🤢")
      ("vomiting"                      . "🤮")
      ("sneeze"                        . "🤧")
      ("mask"                          . "😷")
      ("bandaged_head"                 . "🤕")
      ("money_face"                    . "🤑")
      ("cowboy"                        . "🤠")
      ("imp"                           . "😈")
      ("ghost"                         . "👻")
      ("alien"                         . "👽")
      ("robot"                         . "🤖")
      ("clap"                          . "👏")
      ("thumpup"                       . "👍")
      ("+1"                            . "👍")
      ("thumbdown"                     . "👎")
      ("-1"                            . "👎")
      ("ok"                            . "👌")
      ("pinch"                         . "🤏")
      ("left"                          . "👈")
      ("right"                         . "👉")
      ("down"                          . "👇")
      ("wave"                          . "👋")
      ("pray"                          . "🙏")
      ("eyes"                          . "👀")
      ("brain"                         . "🧠")
      ("facepalm"                      . "🤦")
      ("tada"                          . "🎉")
      ("fire"                          . "🔥")
      ("flying_money"                  . "💸")
      ("lighbulb"                      . "💡")
      ("heart"                         . "❤️")
      ("sparkling_heart"               . "💖")
      ("heartbreak"                    . "💔")
      ("100"                           . "💯")))
  
  (defvar lui-emoticons-alist
    '((":)"   . "slight_smile")
      (";)"   . "wink")
      (":D"   . "smile")
      ("=D"   . "grin")
      ("xD"   . "laughing")
      (";("   . "joy")
      (":P"   . "stuck_out_tongue")
      (";D"   . "stuck_out_tongue_wink")
      ("xP"   . "stuck_out_tongue_closed_eyes")
      (":("   . "slight_frown")
      (";("   . "cry")
      (";'("  . "sob")
      (">:("  . "angry")
      (">>:(" . "rage")
      (":o"   . "wow")
      (":O"   . "astonished")
      (":/"   . "confused")
      (":-/"  . "thinking")
      (":|"   . "neutral")
      (":-|"  . "expressionless")))

  (defun named-circe-prompt ()
    (lui-set-prompt
     (concat (propertize (format "%13s > " (circe-nick))
                         'face 'circe-prompt-face)
             "")))
  (add-hook 'circe-chat-mode-hook #'named-circe-prompt)

  (appendq! all-the-icons-mode-icon-alist
            '((circe-channel-mode all-the-icons-material "message" :face all-the-icons-lblue)
              (circe-server-mode all-the-icons-material "chat_bubble_outline" :face all-the-icons-purple))))

(defun auth-server-pass (server)
  (if-let ((secret (plist-get (car (auth-source-search :host server)) :secret)))
      (if (functionp secret)
          (funcall secret) secret)
    (error "Could not fetch password for host %s" server)))

(defun register-irc-auths ()
  (require 'circe)
  (require 'dash)
  (let ((accounts (-filter (lambda (a) (string= "irc" (plist-get a :for)))
                           (auth-source-search :require '(:for) :max 10))))
    (appendq! circe-network-options
              (mapcar (lambda (entry)
                        (let* ((host (plist-get entry :host))
                               (label (or (plist-get entry :label) host))
                               (_ports (mapcar #'string-to-number
                                               (s-split "," (plist-get entry :port))))
                               (port (if (= 1 (length _ports)) (car _ports) _ports))
                               (user (plist-get entry :user))
                               (nick (or (plist-get entry :nick) user))
                               (channels (mapcar (lambda (c) (concat "#" c))
                                                 (s-split "," (plist-get entry :channels)))))
                          `(,label
                            :host ,host :port ,port :nick ,nick
                            :sasl-username ,user :sasl-password auth-server-pass
                            :channels ,channels)))
                      accounts))))

(add-transient-hook! #'=irc (register-irc-auths))
(defun lui-org-to-irc ()
  "Examine a buffer with simple org-mode formatting, and converts the empasis:
*bold*, /italic/, and _underline_ to IRC semi-standard escape codes.
=code= is converted to inverse (highlighted) text."
  (goto-char (point-min))
  (while (re-search-forward "\\_<\\(?1:[*/_=]\\)\\(?2:[^[:space:]]\\(?:.*?[^[:space:]]\\)?\\)\\1\\_>" nil t)
    (replace-match
     (concat (pcase (match-string 1)
               ("*" "")
               ("/" "")
               ("_" "")
               ("=" ""))
             (match-string 2)
             "") nil nil)))

(add-hook 'lui-pre-input-hook #'lui-org-to-irc)
(defun lui-ascii-to-emoji ()
  (goto-char (point-min))
  (while (re-search-forward "\\( \\)?::?\\([^[:space:]:]+\\):\\( \\)?" nil t)
    (replace-match
     (concat
      (match-string 1)
      (or (cdr (assoc (match-string 2) lui-emojis-alist))
          (concat ":" (match-string 2) ":"))
      (match-string 3))
     nil nil)))

(defun lui-emoticon-to-emoji ()
  (dolist (emoticon lui-emoticons-alist)
    (goto-char (point-min))
    (while (re-search-forward (concat " " (car emoticon) "\\( \\)?") nil t)
      (replace-match (concat " "
                             (cdr (assoc (cdr emoticon) lui-emojis-alist))
                             (match-string 1))))))

(define-minor-mode lui-emojify
  "Replace :emojis: and ;) emoticons with unicode emoji chars."
  :global t
  :init-value t
  (if lui-emojify
      (add-hook! lui-pre-input #'lui-ascii-to-emoji #'lui-emoticon-to-emoji)
    (remove-hook! lui-pre-input #'lui-ascii-to-emoji #'lui-emoticon-to-emoji)))
(defvar lui-emojis-alist
  '(("grinning"                      . "😀")
    ("smiley"                        . "😃")
    ("smile"                         . "😄")
    ("grin"                          . "😁")
    ("laughing"                      . "😆")
    ("sweat_smile"                   . "😅")
    ("joy"                           . "😂")
    ("rofl"                          . "🤣")
    ("relaxed"                       . "☺️")
    ("blush"                         . "😊")
    ("innocent"                      . "😇")
    ("slight_smile"                  . "🙂")
    ("upside_down"                   . "🙃")
    ("wink"                          . "😉")
    ("relieved"                      . "😌")
    ("heart_eyes"                    . "😍")
    ("yum"                           . "😋")
    ("stuck_out_tongue"              . "😛")
    ("stuck_out_tongue_closed_eyes"  . "😝")
    ("stuck_out_tongue_wink"         . "😜")
    ("zanzy"                         . "🤪")
    ("raised_eyebrow"                . "🤨")
    ("monocle"                       . "🧐")
    ("nerd"                          . "🤓")
    ("cool"                          . "😎")
    ("star_struck"                   . "🤩")
    ("party"                         . "🥳")
    ("smirk"                         . "😏")
    ("unamused"                      . "😒")
    ("disapointed"                   . "😞")
    ("pensive"                       . "😔")
    ("worried"                       . "😟")
    ("confused"                      . "😕")
    ("slight_frown"                  . "🙁")
    ("frown"                         . "☹️")
    ("persevere"                     . "😣")
    ("confounded"                    . "😖")
    ("tired"                         . "😫")
    ("weary"                         . "😩")
    ("pleading"                      . "🥺")
    ("tear"                          . "😢")
    ("cry"                           . "😢")
    ("sob"                           . "😭")
    ("triumph"                       . "😤")
    ("angry"                         . "😠")
    ("rage"                          . "😡")
    ("exploding_head"                . "🤯")
    ("flushed"                       . "😳")
    ("hot"                           . "🥵")
    ("cold"                          . "🥶")
    ("scream"                        . "😱")
    ("fearful"                       . "😨")
    ("disapointed"                   . "😰")
    ("relieved"                      . "😥")
    ("sweat"                         . "😓")
    ("thinking"                      . "🤔")
    ("shush"                         . "🤫")
    ("liar"                          . "🤥")
    ("blank_face"                    . "😶")
    ("neutral"                       . "😐")
    ("expressionless"                . "😑")
    ("grimace"                       . "😬")
    ("rolling_eyes"                  . "🙄")
    ("hushed"                        . "😯")
    ("frowning"                      . "😦")
    ("anguished"                     . "😧")
    ("wow"                           . "😮")
    ("astonished"                    . "😲")
    ("sleeping"                      . "😴")
    ("drooling"                      . "🤤")
    ("sleepy"                        . "😪")
    ("dizzy"                         . "😵")
    ("zipper_mouth"                  . "🤐")
    ("woozy"                         . "🥴")
    ("sick"                          . "🤢")
    ("vomiting"                      . "🤮")
    ("sneeze"                        . "🤧")
    ("mask"                          . "😷")
    ("bandaged_head"                 . "🤕")
    ("money_face"                    . "🤑")
    ("cowboy"                        . "🤠")
    ("imp"                           . "😈")
    ("ghost"                         . "👻")
    ("alien"                         . "👽")
    ("robot"                         . "🤖")
    ("clap"                          . "👏")
    ("thumpup"                       . "👍")
    ("+1"                            . "👍")
    ("thumbdown"                     . "👎")
    ("-1"                            . "👎")
    ("ok"                            . "👌")
    ("pinch"                         . "🤏")
    ("left"                          . "👈")
    ("right"                         . "👉")
    ("down"                          . "👇")
    ("wave"                          . "👋")
    ("pray"                          . "🙏")
    ("eyes"                          . "👀")
    ("brain"                         . "🧠")
    ("facepalm"                      . "🤦")
    ("tada"                          . "🎉")
    ("fire"                          . "🔥")
    ("flying_money"                  . "💸")
    ("lighbulb"                      . "💡")
    ("heart"                         . "❤️")
    ("sparkling_heart"               . "💖")
    ("heartbreak"                    . "💔")
    ("100"                           . "💯")))

(defvar lui-emoticons-alist
  '((":)"   . "slight_smile")
    (";)"   . "wink")
    (":D"   . "smile")
    ("=D"   . "grin")
    ("xD"   . "laughing")
    (";("   . "joy")
    (":P"   . "stuck_out_tongue")
    (";D"   . "stuck_out_tongue_wink")
    ("xP"   . "stuck_out_tongue_closed_eyes")
    (":("   . "slight_frown")
    (";("   . "cry")
    (";'("  . "sob")
    (">:("  . "angry")
    (">>:(" . "rage")
    (":o"   . "wow")
    (":O"   . "astonished")
    (":/"   . "confused")
    (":-/"  . "thinking")
    (":|"   . "neutral")
    (":-|"  . "expressionless")))

(provide 'config-irc)
;;; config-irc.el ends here
