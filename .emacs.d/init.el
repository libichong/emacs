(defvar *emacs-load-start* (current-time))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq stack-trace-on-error t)

;; Package Init
(require 'package)
(add-to-list 'package-archives '("popkit" . "https://elpa.popkit.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(setq load-prefer-newer t)

 (defun require-package (package &optional min-version no-refresh)
   "Install given PACKAGE, optionally requiring MIN-VERSION.
 If NO-REFRESH is non-nil, the available package lists will not be
 re-downloaded in order to locate PACKAGE."
   (if (package-installed-p package min-version)
       t
     (if (or (assoc package package-archive-contents) no-refresh)
         (package-install package)
       (progn
         (package-refresh-contents)
         (require-package package min-version t)))))
(package-initialize)

(require-package 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)

;; Basic Setting

;; (w32-send-sys-command 61728))
;; (w32-send-sys-command 61488))
;; (run-with-idle-timer 1 nil 'w32-send-sys-command 61488)
(run-with-idle-timer 1 nil 'toggle-frame-maximized)

(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (locale-is-utf8-p))
  (setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding (Chinese/Japanese/Korean characters)
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (unless (eq system-type 'windows-nt)
    (set-selection-coding-system 'utf-8))
  (prefer-coding-system 'utf-8))

;; (image-type-available-p 'gif)
;; (image-type-available-p 'jpeg)
;; (image-type-available-p 'tiff)
;; (image-type-available-p 'xbm)
;; (image-type-available-p 'xpm)
;; (image-type-available-p 'png)
(auto-image-file-mode t)
(autoload 'thumbs "thumbs" "Preview images in a directory." t)
(add-to-list 'exec-path "C:/Program Files (x86)/gs/gs9.20/bin/")
(setq doc-view-ghostscript-program "gswin32c")
(setq doc-view-dvipdf-program "C:/texlive/2016/bin/win32/dvipdfm.exe")
(autoload 'doc-view-mode "doc-view" "doc-view-mode" t)
(setq w32-get-true-file-attributes nil) ;; Fix read/save file bug on windows.
(setq doc-view-ghostscript-program "gswin32c") ;; Fix doc-view on windows.
(setq-default indicate-buffer-boundaries 'left)
(setq echo-keystrokes 0.1)
(setq system-time-locale "C")
(setq major-mode 'text-mode)
(setq-default show-trailing-whitespace t)
(setq-default show-leading-whitespace t)
(set-face-attribute 'trailing-whitespace nil
                    :background "#2F4545")
(delete-selection-mode 1)
;;(setq browse-url-browser-function 'eww-browse-url)
(setq-default default-directory "~/org/")

(grep-compute-defaults)
(setq find-program "~\\bin\\fd.cmd")
(setq grep-program "~\\bin\\grep.exe")
(grep-apply-setting 'grep-find-command "fd . -name \"*.org\" -type f -print0 | xargs -0 -e grep --color=always -nH -e ")
(grep-apply-setting 'grep-command "grep --color=always -nH -e ")
(global-set-key [S-f3] 'grep-find)

;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

;; inhibit the startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; no ring bell
(setq ring-bell-function 'ignore)

(setq enable-recursive-minibuffers t)
;; don't let the cursor go into minibuffer prompt
(setq minibuffer-prompt-properties (quote (read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)))
(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

;; show the pwd as *
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; (require 'saveplace)
;; (toggle-save-place-globally 1)

(mouse-avoidance-mode 'animate)

;; don't save the duplicate kill string
(setq kill-do-not-save-duplicates t)

(setq frame-title-format
      '(buffer-file-name
        "%f"
        (dired-directory dired-directory "%b")))

(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)

(set-face-attribute 'default nil :family "Consolas" :height 110)
(if (display-graphic-p)
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Microsoft YaHei" :size 11))))

(setq kill-ring-max 200)
(setq large-file-warning-threshold 400000000)
(setq-default make-backup-files nil)
(setq tab-always-indent 'complete)
(setq compilation-ask-about-save nil)
(setq compilation-window-height 12)
(setq compilation-scroll-output t)
(setq read-file-name-completion-ignore-case t)
;; (global-set-key (kbd "<C-f100>") 'menu-bar-mode)
(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq inhibit-splash-screen t)

(global-linum-mode t); always show line numbers

(setq-default indent-tabs-mode nil)
(setq tab-witdth 4)
(setq-default tab-width 4)
(setq fill-column 80)
(setq-default line-spacing 5)

(setq scroll-margin 3
      scroll-conservatively 10000)
;; disable blink cursor
(blink-cursor-mode t)
(column-number-mode t)
(show-paren-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(mouse-avoidance-mode 'animate)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
;; hilight syntax
(global-font-lock-mode t)
(global-auto-revert-mode t)
(setq mouse-yank-at-point t)
;; share the clipboard with external program
(setq select-enable-clipboard t)
;; stop to blink the cursor
(transient-mark-mode 1)
(setq sentence-end
      "\\([¡££¡£¿]\\|¡­¡­\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

;; delete and copy directory recursively
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)
(require 'dired )
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory

(define-key key-translation-map (kbd "<lwindow>") 'event-apply-super-modifier)
(define-key key-translation-map (kbd "<apps>") 'event-apply-alt-modifier)
(setq w32-pass-lwindow-to-system nil
      w32-pass-rwindow-to-system nil
      w32-pass-apps-to-system nil
      w32-capslock-is-shiftlock nil
      w32-enable-caps-lock nil
      w32-lwindow-modifier 'super ;; Left Windows key
      w32-rwindow-modifier 'alt
      w32-recognize-altgr nil
      w32-apps-modifier 'hyper
      )

;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(defun bc-before-save-file ()
  (untabify (point-min) (point-max))
  (delete-trailing-whitespace (point-min) (point-max)))
(add-hook 'before-save-hook 'bc-before-save-file)

;; Server Mode
(require 'server)
(defun server-ensure-safe-dir (dir) t)
(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(add-hook 'server-visit-hook 'call-raise-frame)
(defun call-raise-frame ()
  (raise-frame))

;; Commands aliases
(defalias 'qrr 'query-replace-regexp)
(defalias 'rs 'replace-string)
(defalias 'bkl 'bookmark-bmenu-list)
(defalias 'bks 'bookmark-set)
(defalias 'bkj 'bookmark-jump)
(defalias 'bkd 'bookmark-delete)
(defalias 'bcf 'byte-compile-file)
(defalias 'cc 'calc)
(defalias 'sh 'shell)
(defalias 'ps 'powershell)
(defalias 'rf 'recentf-open-files)
(defalias 'lcd 'list-colors-display)

;; Basic functions
(defun bc-kill-whole-line ()
  (interactive)
  (beginning-of-line)
  (kill-line))
(defun comment-and-go-down ()
  "Comments the current line and goes to the next one"
  (interactive)
  (condition-case nil (comment-region (point-at-bol) (point-at-eol)) (error nil))
  (forward-line 1))
(defun uncomment-and-go-up ()
  "Uncomments the current line and goes to the previous one"
  (interactive)
  (condition-case nil (uncomment-region (point-at-bol) (point-at-eol)) (error nil))
  (forward-line -1))
(defun bc-tidy-buffer ()
  "Make lisp code neat."
  (interactive "*")
  (save-excursion
    (unless (memq major-mode '(makefile-mode))
      (indent-region (point-min) (point-max) nil)
      )))

(defun emacs-git-push()
  (interactive)
  (shell-command (concat "emacs-git-push.cmd")))

(defun init ()
  "Go to Init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun ps1 ()
  "Go to Init.ps1"
  (interactive)
  (find-file "C:/Users/bichongl/OneDrive/app/init.ps1"))

(require 'hi-lock)
(defun toggle-mark-word-at-point ()
  (interactive)
  (if hi-lock-interactive-patterns
      (unhighlight-regexp (car (car hi-lock-interactive-patterns)))
    (highlight-symbol-at-point)))

;; Package Management
(use-package evil
  :config
  (evil-mode t)
  (use-package evil-leader
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader ",")
    (evil-leader/set-key
      "b" 'helm-mini
      "<SPC>"     'other-window
      "f"         'find-file-at-point
      "qq"        'kill-this-buffer
      "qw"        'evil-window-delete
      "w"         'save-buffer
      "f"         'helm-projectile
      "e"         'helm-find-files
      "H"         'unhighlight-regexp'
      "g"         'magit-status
      "i"         'helm-imenu
      "n"         'linum-mode
      "a"         'apropos-command
      "x"         'helm-M-x
      "V"         'exchange-point-and-mark
      "d"         'dired-jump
      "s"         'split-window-below
      "v"         'split-window-right
      "m"         'other-window
      ","         'evil-next-buffer
      "."         'evil-prev-buffer
      "h"         'toggle-mark-word-at-point
  ))

  (use-package evil-escape
  :defer t
  :after evil
  :diminish evil-escape-mode
  :config
  (evil-escape-mode)
  (global-set-key [escape] 'evil-escape)
  (global-set-key (kbd "C-c C-g") 'evil-escape)
  (setq evil-escape-key-sequence "jk"))
)

(use-package counsel  :ensure t )

(use-package smart-tabs-mode
  :ensure t
  :config (progn
            (smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python
                       'ruby 'nxml)
))

(use-package swiper
  :ensure t
  :diminish ivy-mode
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "M-f") 'counsel-describe-function)
    (global-set-key (kbd "M-v") 'counsel-describe-variable)
    (global-set-key (kbd "M-l") 'counsel-load-library)
    (global-set-key (kbd "M-i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "M-u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package avy
  :commands (avy-goto-char
             avy-goto-char-2
             avy-goto-line)
  :defer t
  :bind (("C-;"   . avy-goto-char)
         ("C-'"   . avy-goto-char-2)
         ("C-l"   . avy-goto-line)))

(use-package auto-complete
  :defer t
  :diminish auto-complete-mode
  :config
  (ac-config-default)
  (global-auto-complete-mode t))


(use-package dired+
  :defer t
  :init
 (progn
   (toggle-diredp-find-file-reuse-dir 1)))

(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-listing-switches "-alh")

(use-package helm-config
  :demand t
  :ensure helm
  :defer t
  :bind (("C-c h"   . helm-command-prefix)
         ("C-h a"   . helm-apropos)
         ("C-x f"   . helm-multi-files)
         ("M-s b"   . helm-occur)
         ("M-s n"   . my-helm-find)
         ("M-H"     . helm-resume)
         ("M-z"     . helm-semantic-or-imenu)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b"   . helm-mini)
         ("C-x f"   . helm-find-files)
         ("C-h SPC" . helm-all-mark-rings)
         ("C-M-s"   . helm-occur)
         ("C-M-r"   . helm-regexp) ;; sinimar with helm-occur,but regex
         ("<f7>"    . helm-recentf)
         )

  :preface
  :config
  (use-package helm-descbinds
    :bind ("C-h b" . helm-descbinds)
    :init
    (fset 'describe-bindings 'helm-descbinds)
    :config
    (require 'helm-config))

    (helm-mode 1)

  (use-package helm-swoop
    :defer t
    :bind(("M-i" . helm-swoop))
    :init
    (custom-set-faces
     `(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
     `(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
     )
    :config
    ;; Don't use word at cursor by default
    (setq helm-swoop-pre-input-function (lambda () nil))
    )

  (helm-autoresize-mode 1)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

  (bind-key "<tab>" #'helm-execute-persistent-action helm-map)
  (bind-key "C-i" #'helm-execute-persistent-action helm-map)
  (bind-key "C-z" #'helm-select-action helm-map)
  (bind-key "A-v" #'helm-previous-page helm-map)

  (when (executable-find "curl")
    (setq helm-net-prefer-curl t)))

(use-package powerline
  :config
  (powerline-default-theme))

(use-package magit
  :defer t
  :commands (magit-status
             magit-log
             magit-commit
             magit-stage-file)
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix))
  :preface
  (defun magit-monitor (&optional no-display)
    "Start git-monitor in the current directory."
    (interactive)
    (when (string-match "\\*magit: \\(.+\\)" (buffer-name))
      (let ((name (format "*git-monitor: %s*"
                          (match-string 1 (buffer-name)))))
        (or (get-buffer name)
            (let ((buf (get-buffer-create name)))
              (ignore-errors
                (start-process "*git-monitor*" buf "git-monitor"
                               "-d" (expand-file-name default-directory)))
              buf)))))

  (defun magit-status-with-prefix ()
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively 'magit-status)))

  (defun lusty-magit-status (dir &optional switch-function)
    (interactive (list (if current-prefix-arg
                           (lusty-read-directory)
                         (or (magit-get-top-dir)
                             (lusty-read-directory)))))
    (magit-status-internal dir switch-function))

  (defun eshell/git (&rest args)
    (cond
     ((or (null args)
          (and (string= (car args) "status") (null (cdr args))))
      (magit-status-internal default-directory))
     ((and (string= (car args) "log") (null (cdr args)))
      (magit-log "HEAD"))
     (t (throw 'eshell-replace-command
               (eshell-parse-command
                "*git"
                (eshell-stringify-list (eshell-flatten-list args)))))))

  :init
  (add-hook 'magit-mode-hook 'hl-line-mode)

  :config
  (setenv "GIT_PAGER" "")

  (remove-hook 'server-switch-hook 'magit-commit-diff)

  (unbind-key "M-h" magit-mode-map)
  (unbind-key "M-s" magit-mode-map)
  (unbind-key "M-m" magit-mode-map)
  (unbind-key "M-w" magit-mode-map)
  (unbind-key "<C-return>" magit-file-section-map)

  ;; (bind-key "M-H" #'magit-show-level-2-all magit-mode-map)
  ;; (bind-key "M-S" #'magit-show-level-4-all magit-mode-map)
  (bind-key "U" #'magit-unstage-all magit-mode-map)

  (add-hook 'magit-log-edit-mode-hook
            #'(lambda ()
                (set-fill-column 72)
                (flyspell-mode 1)))

  (add-hook 'magit-status-mode-hook #'(lambda () (magit-monitor t))))

(use-package ielm
  :bind ("C-c :" . ielm)
  :config
  (defun my-ielm-return ()
    (interactive)
    (let ((end-of-sexp (save-excursion
                         (goto-char (point-max))
                         (skip-chars-backward " \t\n\r")
                         (point))))
      (if (>= (point) end-of-sexp)
          (progn
            (goto-char (point-max))
            (skip-chars-backward " \t\n\r")
            (delete-region (point) (point-max))
            (call-interactively #'ielm-return))
        (call-interactively #'paredit-newline))))

  (add-hook 'ielm-mode-hook
            (function
             (lambda ()
               (bind-key "<return>" #'my-ielm-return ielm-map)))
            t))

(use-package anzu
  :commands (anzu-query-replace
             anzu-query-replace-regexp)
  :defer t
  :diminish anzu-mode
  :config (global-anzu-mode +1)
  :bind (("M-%"   . anzu-query-replace)
         ("C-M-%"   . anzu-query-replace-regexp)))

(use-package bm
  :defer t
  :bind (
         ("<C-f2>" . bm-toggle)
         ("<f2>" . bm-next)
         ("<S-f2>" . bm-previous)))

(use-package undo-tree
  :defer t
  :commands undo-tree
  :diminish undo-tree-mode
  :config (global-undo-tree-mode))

(use-package htmlize)

(use-package org-ac
  :defer t
  :init
  (require 'org-ac)
  (org-ac/config-default))

(use-package org
  :defer t
  :init
   (setq org-html-validation-link nil
         org-export-html-postamble nil
         org-export-with-toc nil
         org-return-follows-link t
         org-startup-indented t
         org-src-fontify-natively t
         org-export-with-tags nil
         org-export-with-timestamps nil
         org-export-with-section-numbers nil
         org-export-with-todo-keywords nil
         org-export-headline-levels 5
         org-export-with-tasks t
         org-export-with-priority t
         org-export-with-clocks t
        org-export-backends '(ascii html icalendar latex md))
   :bind  (("C-c a" . org-agenda)
          ("C-c S" . org-store-link)
          ("C-c l" . org-insert-link)
          ("C-. n" . org-velocity-read))
   :config
   (setq org-agenda-files '("~/org/gtd.org")
         org-default-notes-file (concat org-directory "home.org")
         org-log-done 'time)
   (defun org-outlook-open (path) (w32-shell-execute "open" "C:/Program Files/Microsoft Office/Office16/OUTLOOK.exe" (concat "outlook:" path)))
   (org-add-link-type "outlook" 'org-outlook-open)

   (defun org-summary-todo (n-done n-not-done)
     "Switch entry to DONE when all subentries are done, to TODO otherwise."
     (let (org-log-done org-log-states)   ; turn off logging
       (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

   ;; -- Org statistics cookies --
   (setq org-provide-todo-statistics t)
   (setq org-provide-todo-statistics '('("TODO" "NEXT") '("DONE" "CANCELED")))
   (setq org-hierarchical-todo-statistics nil) ; consider all entries in the sublist
   (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
   ;; Use XeLaTeX to export PDF in Org-mode
   (setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))
   (setq org-startup-truncated nil)
   (require 'ox-latex)
   (unless (boundp 'org-latex-classes)
     (setq org-latex-classes nil))
   (add-to-list 'org-latex-classes
             '("article"
               "\\documentclass[12pt,a4paper]{article}
               \\usepackage{xeCJK}
               \\setCJKmainfont[BoldFont=SimHei, ItalicFont=KaiTi]{SimSun}
               \\setCJKmonofont{KaiTi}
               %\\pagestyle{plain}
               \\usepackage{hyperref}
               \\usepackage{geometry}
               \\geometry{a4paper, textwidth=6.5in, textheight=10in,
               marginparsep=7pt, marginparwidth=.6in}
               \\hypersetup{
               colorlinks=true,
               linkcolor=[rgb]{0,0.37,0.53},
               citecolor=[rgb]{0,0.47,0.68},
               filecolor=[rgb]{0,0.37,0.53},
               urlcolor=[rgb]{0,0.37,0.53},
               pagebackref=true,
               linktoc=all,}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
             )
   (setq org-file-apps
           '((auto-mode . emacs)
             ("\\.mm\\'" . default)
             ("\\.doc\\'" . default)
             ("\\.docx\\'" . default)
             ("\\.xls\\'" . default)
             ("\\.xlsx\\'" . default)
             ("\\.ppt\\'" . default)
             ("\\.pptx\\'" . default)
             ("\\.x?html?\\'" . default)
             ("\\.pdf\\'" . default)))
   ;; (setq org-agenda-files (list org-directory))
   (org-display-inline-images t)
   (setq org-image-actual-width nil)
   (eval-after-load 'org-indent '(diminish 'org-indent-mode))
   (setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "goldenrod" :weight bold)
              ("POSTPONED" :foreground "peru" :weight bold)
              ("IN-PROGRESS" :foreground "firebrick" :weight bold))))
   (setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/org/"
         :base-extension "org"
         :publishing-directory "~/org/html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("org-static"
         :base-directory "~/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/org/html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static"))
        ))
   (defun op ()
     (interactive)
     (org-octopress-setup-publish-project)
     (org-publish-project "org" t))

  (setq org-agenda-span 'week)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (setq org-todo-keywords '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "NEXT(n)" "HOLD(h)" "CANCELLED(c)" "DONE(d)" "POSTPONED(p)"))))

(use-package org-ref
  :defer t
  :init
  (setq reftex-default-bibliography '("~/org/me.bib"))
  (setq org-ref-bibliography-notes "~/org/note.org"
      org-ref-default-bibliography '("~/org/me.bib")
      org-ref-pdf-directory "~/org/")
  )

(use-package org-preview-html
  :defer t
  :diminish t
  :bind
  (("M-p" . org-preview-html/preview)))
  ;; :init
  ;; (add-hook 'org-mode-hook 'org-preview-html-mode))

(use-package org-bullets
  :init
  (setq org-bullets-bullet-list '("▲" "●" "◉" "■" "○"))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;;; Packages
(use-package volatile-highlights
  :defer t

  :config
  (volatile-highlights-mode t)
  :diminish volatile-highlights-mode)

(use-package align
  :bind (("M-["   . align-code)
         ("C-c [" . align-regexp))
  :defer t
  :commands align
  :preface
  (defun align-code (beg end &optional arg)
    (interactive "rP")
    (if (null arg)
        (align beg end)
      (let ((end-mark (copy-marker end)))
        (indent-region beg end-mark nil)
        (align beg end-mark)))))

(use-package color-moccur
  :commands (isearch-moccur isearch-all isearch-moccur-all)
  :bind ("M-s O" . moccur)
  :defer t
  ;;  (use-package moccur-edit)
  :init
  (bind-key "M-o" #'isearch-moccur isearch-mode-map)
  (bind-key "M-h" #'helm-occur-from-isearch isearch-mode-map)
  (bind-key "M-O" #'isearch-moccur-all isearch-mode-map)
  (bind-key "M-H" #'helm-multi-occur-from-isearch isearch-mode-map))

(use-package nxml-mode
  :ensure nxml
  :defer t
  :commands nxml-mode
  :init
  (defalias 'xml-mode 'nxml-mode)
  :config
  (defun my-nxml-mode-hook ()
    (bind-key "<return>" #'newline-and-indent nxml-mode-map))

  (add-hook 'nxml-mode-hook 'my-nxml-mode-hook)

  (defun tidy-xml-buffer ()
    (interactive)
    (save-excursion
      (call-process-region (point-min) (point-max) "tidy" t t nil
                           "-xml" "-i" "-wrap" "0" "-omit" "-q" "-utf8")))

  (bind-key "C-c M-h" #'tidy-xml-buffer nxml-mode-map)

  (require 'hideshow)
  (require 'sgml-mode)

  (add-to-list 'hs-special-modes-alist
               '(nxml-mode
                 "<!--\\|<[^/>]*[^/]>"
                 "-->\\|</[^/>]*[^/]>"

                 "<!--"
                 sgml-skip-tag-forward
                 nil))

  (add-hook 'nxml-mode-hook 'hs-minor-mode)

  ;; optional key bindings, easier than hs defaults
  (bind-key "C-c h" #'hs-toggle-hiding nxml-mode-map))

(use-package python-mode
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :config
  (defvar python-mode-initialized nil)

  (defun my-python-mode-hook ()
    (unless python-mode-initialized
      (setq python-mode-initialized t)

      (info-lookup-add-help
       :mode 'python-mode
       :regexp "[a-zA-Z_0-9.]+"
       :doc-spec
       '(("(python)Python Module Index" )
         ("(python)Index"
          (lambda
            (item)
            (cond
             ((string-match
               "\\([A-Za-z0-9_]+\\)() (in module \\([A-Za-z0-9_.]+\\))" item)
              (format "%s.%s" (match-string 2 item)
                      (match-string 1 item)))))))))

    (setq indicate-empty-lines t)
    (set (make-local-variable 'parens-require-spaces) nil)
    (setq indent-tabs-mode nil)

    (bind-key "C-c C-z" #'python-shell python-mode-map)
    (unbind-key "C-c c" python-mode-map))

  (add-hook 'python-mode-hook 'my-python-mode-hook))

(use-package powershell
  :defer t
  :commands powershell-mode
  :diminish powershell-mode)

(use-package projectile
  :diminish projectile-mode
  :commands projectile-mode
  :defer t
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (use-package helm-projectile
    :defer t
    :config
    (setq projectile-completion-system 'helm)
    (helm-projectile-on))
  (projectile-mode)
  (bind-key "s s"
            #'(lambda ()
                (interactive)
                (helm-do-grep-1 (list (projectile-project-root)) t))
            'projectile-command-map))

(use-package whitespace
  :defer t
  :diminish (global-whitespace-mode
             whitespace-mode
             whitespace-newline-mode)
  :commands (whitespace-buffer
             whitespace-cleanup
             whitespace-mode)
  :defines (whitespace-auto-cleanup
            whitespace-rescan-timer-time
            whitespace-silent)
  :preface
  (defun normalize-file ()
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (whitespace-cleanup)
      (delete-trailing-whitespace)
      (goto-char (point-max))
      (delete-blank-lines)
      (set-buffer-file-coding-system 'unix)
      (goto-char (point-min))
      (while (re-search-forward "\r$" nil t)
        (replace-match ""))
      (set-buffer-file-coding-system 'utf-8)
      (let ((require-final-newline t))
        (save-buffer))))

  (defun maybe-turn-on-whitespace ()
    "Depending on the file, maybe clean up whitespace."
    (let ((file (expand-file-name ".clean"))
          parent-dir)
      (while (and (not (file-exists-p file))
                  (progn
                    (setq parent-dir
                          (file-name-directory
                           (directory-file-name
                            (file-name-directory file))))
                    ;; Give up if we are already at the root dir.
                    (not (string= (file-name-directory file)
                                  parent-dir))))
        ;; Move up to the parent dir and try again.
        (setq file (expand-file-name ".clean" parent-dir)))
      ;; If we found a change log in a parent, use that.
      (when (and (file-exists-p file)
                 (not (file-exists-p ".noclean"))
                 (not (and buffer-file-name
                           (string-match "\\.texi\\'" buffer-file-name))))
        (add-hook 'write-contents-hooks
                  #'(lambda () (ignore (whitespace-cleanup))) nil t)
        (whitespace-cleanup))))

  :init
  (add-hook 'find-file-hooks 'maybe-turn-on-whitespace t)

  :config
  (remove-hook 'find-file-hooks 'whitespace-buffer)
  (remove-hook 'kill-buffer-hook 'whitespace-buffer)

  ;; For some reason, having these in settings.el gets ignored if whitespace
  ;; loads lazily.
  (setq whitespace-auto-cleanup t
        whitespace-line-column 110
        whitespace-rescan-timer-time nil
        whitespace-silent t
        whitespace-style '(face trailing lines space-before-tab empty)))

(use-package rainbow-mode
  :diminish rainbow-mode
  :defer t
  :init
  (add-hook 'css-mode-hook #'rainbow-mode)
  (add-hook 'less-mode-hook #'rainbow-mode)
  )

(use-package css-mode
  :defer t
  :mode (
         ("\\.css$" . css-mode)
         )
  :config
  (setq css-indent-offset 2))

(require 'xcscope)
(add-hook 'c-mode-hook (function cscope-minor-mode))
(add-hook 'c++-mode-hook
          '(lambda ()
             (cscope-minor-mode t)
             (setq c-basic-offset 4)
             (c-set-offset 'substatement-open 0)
             (c-set-offset 'case-label '+)))

(add-hook 'csharp-mode-hook
          '(lambda ()
             (cscope-minor-mode)
             (auto-complete-mode t)
             (c-set-offset 'substatement-open 0)
             (c-set-offset 'arglist-close 0)
             (c-set-offset 'case-label 0)))
(add-hook 'lisp-mode-hook (function cscope-minor-mode))
(add-hook 'js2-mode-hook (function cscope-minor-mode))
(add-hook 'go-mode-hook (function cscope-minor-mode))

(use-package json-mode
  :defer t
  :mode ("\\.json\\'" . json-mode))

(use-package web-mode
  :mode (("\\.html$"  . web-mode)
         ("\\.xhtml$" . web-mode)
         ("\\.tmpl$"  . web-mode)
         ("\\.tpl$"   . web-mode)
         ("\\.php$"   . web-mode)
         ("\\.aspx$"   . web-mode)
         ("\\.less$"  . css-mode))
  :defer t
  :init
  (setq web-mode-markup-indent-offset 2))

(use-package js2-mode
  :defer t
  :mode ("\\.js\\'" . js2-mode))

(use-package skewer-mode
  :defer t
  :diminish skewer-mode
  :config
  (setq httpd-port 8123)
  (define-key skewer-mode-map (kbd "C-0") 'skewer-eval-defun)
  (add-hook 'js2-mode-hook 'skewer-mode)
  (add-hook 'css-mode-hook 'skewer-css-mode)
  (add-hook 'html-mode-hook 'skewer-html-mode))

(use-package winner
  :if (not noninteractive)
  :defer t
  :bind (("<f10>" . winner-redo)
         ("<S-f10>" . winner-undo))
  :init
  (winner-mode 1))

;; (when (memq window-system '(mac ns))
  ;; (exec-path-from-shell-initialize)
  ;; (exec-path-from-shell-copy-env "GOPATH"))

(setenv "GOPATH" "C:/GoCode")
(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :defer t
  :init
  (progn
    (use-package auto-complete   :ensure :defer t)
    (use-package flycheck        :ensure :defer t)
    (use-package go-autocomplete :ensure :defer t)
    (use-package go-errcheck     :ensure :defer t)
    (use-package gotest          :ensure :defer t)
    (add-hook 'go-mode-hook
              (lambda ()
                (go-set-project)
                (flycheck-mode)
                (auto-complete-mode)
                (add-hook 'before-save-hook 'gofmt-before-save)
                (setq tab-width 4)))))

(use-package markdown-mode
  :defer t
  :mode (("\\`README\\.md\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode)))

(use-package csharp-mode
  :commands csharp-mode
  :diminish csharp-mode
  :defer t
  :mode "\\.cs\\'" ".script")

;; Key Binding
(defadvice async-shell-command (before uniqify-running-shell-command activate)
  (let ((buf (get-buffer "*Async Shell Command*")))
    (if buf
        (let ((proc (get-buffer-process buf)))
          (if (and proc (eq 'run (process-status proc)))
              (with-current-buffer buf
                (rename-uniquely)))))))

(bind-key "M-!" #'async-shell-command)
(bind-key "M-'" #'insert-pair)
(bind-key "M-\"" #'insert-pair)
(bind-key "C-`" #'other-window)

(bind-key "M-g c" #'goto-char)
(bind-key "M-g l" #'goto-line)

(defun delete-indentation-for
  (interactive)
  (delete-indentation t))
(defun copy-current-buffer-name ()
  (interactive)
  (let ((name (buffer-file-name)))
    (kill-new name)
    (message name)))

(bind-key "C-c C-0" #'copy-current-buffer-name)

(defvar lisp-modes '(emacs-lisp-mode
                     inferior-emacs-lisp-mode
                     ielm-mode
                     lisp-mode
                     inferior-lisp-mode
                     lisp-interaction-mode
                     slime-repl-mode))

(defun scratch ()
  (interactive)
  (let ((current-mode major-mode))
    (switch-to-buffer-other-window (get-buffer-create "*scratch*"))
    (goto-char (point-min))
    (when (looking-at ";")
      (forward-line 4)
      (delete-region (point-min) (point)))
    (goto-char (point-max))
    (if (memq current-mode lisp-modes)
        (funcall current-mode))))

(bind-key "C-h s" #'scratch)
(bind-key "C-h v" #'find-variable)
(bind-key "C-h V" #'apropos-value)
;;global key binding
(global-set-key [(meta backspace)] '(lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key [(meta down)] 'comment-and-go-down)
(global-set-key [(meta up)] 'uncomment-and-go-up)
(global-set-key [(super return)] 'find-file-at-point)
(global-set-key [(meta k)] 'bc-kill-whole-line)
(global-set-key [S-f1] '(lambda ()
                        (interactive)
                        (find-file "~/.emacs.d/init.el")))
(global-set-key [f1] '(lambda ()
                        (interactive)
                        (find-file "~/org/home.org")))

(global-set-key [f8] 'helm-bookmarks)
(global-set-key [C-f4] '(lambda ()
                        (interactive)
                        (find-file "~/org/gtd.org")))
(global-set-key [f5] 'read-only-mode)
(global-set-key [f6] 'revert-buffer)
(global-set-key [f9] 'eshell)
(global-set-key [f12] 'save-buffer)
(global-set-key [C-f12] 'emacs-git-push)
(bind-key "C-c =" #'count-matches)
(defun delete-current-line (&optional arg)
  (interactive "p")
  (let ((here (point)))
    (beginning-of-line)
    (kill-line arg)
    (goto-char here)))

(global-set-key (kbd "M-o") 'delete-other-windows)

(bind-key "C-x K" #'delete-current-buffer-file)
(bind-key "C-k" #'delete-current-line)
(require 'helm-everything)
(global-set-key [f3] 'helm-everything)
(global-set-key [C-f3] 'grep)
(bind-key "C-c n" #'insert-user-timestamp)
(bind-key "C-c o" #'customize-option)
(bind-key "C-c O" #'customize-group)
(bind-key "C-c F" #'customize-face)

(bind-key "C-c q" #'fill-region)
(bind-key "C-c r" #'replace-regexp)
(bind-key "C-c u" #'rename-uniquely)
(bind-key "C-c v" #'ffap)

(defun view-clipboard ()
  (interactive)
  (delete-other-windows)
  (switch-to-buffer "*Clipboard*")
  (let ((inhibit-read-only t))
    (erase-buffer)
    (clipboard-yank)
    (goto-char (point-min))))

(bind-key "C-c V" #'view-clipboard)
(bind-key "C-c z" #'clean-buffer-list)

(bind-key "C-c =" #'count-matches)
(bind-key "C-c ;" #'comment-or-uncomment-region)

(bind-key "C-h c" #'finder-commentary)
(bind-key "C-h e" #'view-echo-area-messages)
(bind-key "C-h f" #'find-function)
(bind-key "C-h F" #'find-face-definition)

(use-package theme
  :defer t
  :ensure github-theme
  :init
  (load-theme 'github t))
  (global-hl-line-mode 1)
(set-face-attribute 'region nil :background "#BFCDDB")
(set-face-foreground 'font-lock-comment-face "#007F00")
(set-face-foreground 'font-lock-comment-delimiter-face "#007F00")
(set-face-foreground 'font-lock-string-face "#A31111")
(set-face-foreground 'font-lock-preprocessor-face "#0000FF")
(set-face-foreground 'font-lock-keyword-face "#0000FF")
(set-face-foreground 'linum "#2B91AF")
(setq linum-format "%4d  ")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-swoop-target-line-face ((t (:foreground nil :background nil :inherit hl-line))))
 '(helm-swoop-target-word-face ((t (:foreground nil :background nil :bold nil :inherit isearch))))
 '(org-checkbox ((t (:foreground "DarkOrchid3"))))
 '(org-date ((t (:foreground "red" :underline t))))
 '(org-level-1 ((t (:foreground "blue" :width normal :height 1.3))))
 '(org-level-2 ((t (:foreground "DarkOrchid4" :height 1.2 :width normal))))
 '(org-level-3 ((t (:foreground "firebrick4" :height 1.1 :width normal))))
 '(org-level-4 ((t (:foreground "purple" :height 1.0 :width normal))))
 '(org-link ((t (:foreground "cornflower blue" :underline t))))
 '(org-special-keyword ((t (:foreground "DeepPink3"))))
 '(org-tag ((t (:background "gold" :box (:line-width 2 :color "grey75" :style released-button))))))

(set-face-attribute 'mode-line nil
                    :foreground "black"
                    :background "DarkOrange"
                    :box nil)

;; show time
(let* ((time (current-time))
       (low-sec (nth 1 time))
       (micro-sec (nth 2 time)))
  (message "load time: %dms"
           (/ (+ (* (- low-sec (nth 1 *emacs-load-start*)) 1000000)
                 (- micro-sec (nth 2 *emacs-load-start*))) 1000)))

(provide 'init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (helm-projectile github-theme csharp-mode markdown-mode gotest go-errcheck go-autocomplete flycheck go-mode skewer-mode js2-mode web-mode json-mode rainbow-mode projectile powershell python-mode color-moccur volatile-highlights org-bullets org-preview-html org-ref org-ac htmlize bm anzu magit powerline helm-swoop helm-descbinds helm dired+ auto-complete avy smart-tabs-mode counsel evil-escape evil-leader evil use-package))))
