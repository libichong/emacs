;;; package --- Summary

;;; Commentary:
;;; Code:

;; ;;; use es.exe provided by everything
;; Switch   Description
;; -r   Search the database using a basic POSIX regular expression.
;; -i   Does a case sensitive search.
;; -w   Does a whole word search.
;; -p   Does a full path search.
;; -h
;; --help   Display this help.
;; -n <num>     Limit the amount of results shown to <num>.
;; -s   Sort by full path.
(require 'helm)

(defgroup everything nil
  "Bridge to the Windows desktop search-engine everything. See http://www.voidtools.com."
  :group 'external
  :prefix "everything-")

(defcustom everything-cmd "C:/app/emacs/bin/es.exe"
  "Path to es.exe."
  :group 'everything
  :type 'string)

(defvar everything-result-buffer "*everything*" "Name of buffer to write the query response to.
After successfully fetching the matching filenames, this buffer holds one filename per line.
See `everything-post-process-hook' to post-process this buffer.")


(defun everything-query-list nil
"Query Input And Return Output As List."
(interactive)
(with-current-buffer (current-buffer)
  (everything-CLI-query (read-from-minibuffer "Query Everything: "))
  (set-buffer (get-buffer-create everything-result-buffer))
  (while (search-forward "\\" nil t)
    (replace-match "/" nil t))
  (split-string (buffer-substring-no-properties (point-min) (point))
                "\n" t)))

(defun everything-CLI-query (query)
"Main Interface To Everything.
'(everything-cmd-query QUERY)
some es parameters
-r      Search the database using a basic POSIX regular expression.
-i      Does a case sensitive search.
-w      Does a whole word search.
-p      Does a full path search.
-h      Display this help.
-n <num>    Limit the amount of results shown to <num>.
-s      Sort by full path"
(let ((args-for-es (list query)))
  (when (not (file-exists-p everything-cmd)) (error (concat everything-cmd " not found")))
    (when (get-buffer everything-result-buffer)
      (kill-buffer everything-result-buffer))
    (apply #'call-process  everything-cmd nil (get-buffer-create everything-result-buffer) nil args-for-es)))


(defvar helm-everything-source
'((name . "Everything")
  (candidate-number-limit . 20)
  (candidates . files-from-everything)
  (action . (("Find file " . find-file)))
))

;; (everything-query-list)

(defun helm-everything nil
  "Top Level."
  (interactive)
  (setq files-from-everything (everything-query-list))
  (helm-other-buffer helm-everything-source everything-result-buffer))

(provide 'helm-everything)
