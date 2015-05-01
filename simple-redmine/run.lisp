#!/usr/bin/clisp

;; redmine-root/db directory path
(defvar *db-directory* #p"/srv/redmine/db/")

;; thin command
(defvar *thin-command* "thin")

;; port number
(defvar *port-number* 1080)



(defun start-thin (port)
  (let ((command
         (concatenate 'string
                      *thin-command*
                      " -e production -p "
                      (write-to-string port)
                      " start")))
    (run-shell-command command)))


(defun setup-db-dir ()
  (run-shell-command (concatenate 'string "cp -R db.tmp/* " (namestring *db-directory*)))
  (run-shell-command "bundle exec rake generate_secret_token")
  (run-shell-command "RAILS_ENV=production bundle exec rake db:migrate")
  (run-shell-command "RAILS_ENV=production REDMINE_LANG=ja bundle exec rake redmine:load_default_data"))


(if (ignore-errors (ext:probe-directory (merge-pathnames #p"migrate/" *db-directory*)))
    (start-thin *port-number*)
    (progn
      (setup-db-dir)
      (start-thin *port-number*)))
