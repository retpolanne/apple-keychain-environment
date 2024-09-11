;;; apple-keychain-environment.el --- load ssh env from apple's keychain -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Anne Macedo
;;
;; Author: Anne Macedo <annie@retpolanne.com>
;; Maintainer: Anne Macedo <annie@retpolanne.com>
;; Created: September 11, 2024
;; Modified: September 11, 2024
;; Version: 0.0.1
;; Keywords: tools, ssh
;; Homepage: https://github.com/retpolanne/apple-keychain-environment
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(setq-default ssh-path "$HOME/.ssh/id_ed25519")

(defun apple-keychain-environment-refresh ()
  "Set ssh-agent environment variables using Apple Keychain."
  (interactive)
  (let ((ssh (shell-command-to-string "ssh-agent -s")))
    (list (and ssh
               (string-match "SSH_AUTH_SOCK[=\s]\\([^\s;\n]*\\)" ssh)
               (setenv       "SSH_AUTH_SOCK" (match-string 1 ssh)))
          (and ssh
               (string-match "SSH_AGENT_PID[=\s]\\([0-9]*\\)?" ssh)
               (setenv       "SSH_AGENT_PID" (match-string 1 ssh)))))
  (shell-command-to-string (format "ssh-add --apple-use-keychain %s" ssh-path)))

(provide 'apple-keychain-environment)
;;; apple-keychain-environment.el ends here
