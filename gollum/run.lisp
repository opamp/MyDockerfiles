#!/usr/bin/clisp

;; wiki root dir
(defvar *wikidir* #p"/srv/wiki/")
(defvar *gollum-command* "gollum")
(defvar *gollum-port* 10080)

(defun init-wiki-dir? (wikidir)
  (ignore-errors (ext:probe-directory (merge-pathnames #p".git/" wikidir))))

(defun setup-wiki-dir (wikidir)
  (run-shell-command (concatenate 'string
                                  "git init " (namestring wikidir))))

(defun start-server (port option)
  (run-shell-command (concatenate 'string
                                  *gollum-command* " --port "
                                  (write-to-string port)
                                  " " option)))



(unless (init-wiki-dir? *wikidir*)
  (setup-wiki-dir *wikidir*))
(start-server 10080 "--mathjax")
