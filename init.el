;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Setup index to package archive melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;have emacs save state
(desktop-save-mode 1)

;;Load in workgroups
;; (add-to-list 'load-path "~/.elisp/workgroups/")
(require 'workgroups)
;;Set workgroups command key
;;(setq wg-prefix-key (kbd "C-c w"))
;;activate on startup
(workgroups-mode 1)
;;default workgroup to load
(wg-load "/home/mandrake/emacs_state/wg-save")

;;paradox-list-packages command, token permits rating system
(setq paradox-github-token "0bfb5cc63319a4d41cf963f01ae5f81a9467674e")

;; enable emacs to load graphics files like a buffer
(setq auto-image-file-mode t)

;; permit emacs to use pdbtrack to automatically start tracking a breakpoint encountered in an emacs shell
(add-hook 'comint-output-filter-functions 'python-pdbtrack-comint-output-filter-function)

;; Show column number as well as line number
(setq column-number-mode t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Enable clipboard copy OUT of Emacs
(setq x-select-enable-clipboard t)

;;Replace a selected region with a paste, like every other editor
(delete-selection-mode)

;;Ensure no trailing spaces/tabs remain at the ends of each line (especially important for doctest)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;stop emacs from changing the creation date of the source file
(setq backup-by-copying t)

;; stop creating those backup~ files
(setq make-backup-files nil)
;; stop creating those #autosave# files
(setq auto-save-default nil)

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
       (global-font-lock-mode t)
))

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Enable wheelmouse support by default
(if (not running-xemacs)
    (require 'mwheel) ; Emacs
  (mwheel-install) ; XEmacs
)

;; Change mouse scroll wheel to only move one line at a time (less jumpy than original setting)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000) ;; slow but steady scrolling, no jumping
 (setq auto-window-vscroll nil) ;; helps with consistent behavior

;; Change control pgdown and control pgup to scroll buffer, not cursor
(global-set-key [(control next )]  (lambda () (interactive) (scroll-up   4)) )
(global-set-key [(control prior)]  (lambda () (interactive) (scroll-down 4)) )

;;colors
(set-background-color "black")
(set-foreground-color "#27CA19") ;;LimeGreen old setting
(set-cursor-color     "yellow")
(set-mouse-color      "yellow")

;;(set-frame-font "-b&h-luximono-medium-r-normal-*-*-160-*-*-m-*-iso8859-15")
(set-default-font "-Misc-Fixed-Medium-R-Normal--15-140-75-75-C-90-ISO8859-1")

(set-face-foreground font-lock-comment-face       "darkgrey")
(set-face-foreground font-lock-function-name-face "yellow green")
(set-face-foreground font-lock-string-face        "olive drab")
(set-face-foreground font-lock-variable-name-face "green")
(set-face-foreground font-lock-builtin-face       "yellow green")
(set-face-foreground font-lock-constant-face      "yellow green")
(set-face-foreground font-lock-keyword-face       "green")
(set-face-foreground font-lock-type-face          "yellow green")
(set-face-foreground font-lock-warning-face       "red")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-matching-paren-distance 256000)
 '(paradox-automatically-star t)
 '(wg-query-for-save-on-emacs-exit t)
 '(wg-restore-position t))

;;set up our C environment
(setq c-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))

(setq objc-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))

(setq c++-mode-hook
    (function (lambda ()
                (setq indent-tabs-mode nil)
                (setq c-indent-level 2))))


 (setq auto-mode-alist (cons '("\\.h\\'" . c++-mode) auto-mode-alist))

;;Force autoreload if the file on disk changes
(add-hook 'global-auto-revert-mode-hook
          (lambda ()
            (setq global-auto-revert-mode-text " GAutRev")))

;;Enable ANSI color in shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;;fix the names of directories etc. in the shell
;;We are redefining the following colors to whatever we call, so be careful
;;["black" "red" "green" "yellow" "PaleBlue" "magenta" "cyan" "white"]
;; (setq ansi-color-names-vector
;;       ["black" "red" "green" "yellow" "RoyalBlue4" "magenta" "cyan" "white"])
;; (setq ansi-color-map (ansi-color-make-color-map))


;;Start in the same dir always and load the last desktop automatically
;; (setq default-directory "/home/mandrake/emacs_state")
;; (setq your-own-path default-directory)
;; (if (file-exists-p
;;      (concat your-own-path ".emacs.desktop"))
;;     (desktop-read your-own-path))
;; (add-hook 'kill-emacs-hook
;;       `(lambda ()
;;         (desktop-save ,your-own-path t)))

;;Start with only one window
;;(setq inhibit-startup-screen t)
;;(add-hook 'emacs-startup-hook 'delete-other-windows)

 ;;;;Matlab mode setup

(autoload 'matlab-mode "/home/mandrake/.emacs_addons/matlab.el" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "/home/mandrake/.emacs_addons/matlab.el" "Interactive Matlab mode." t)

(global-set-key "\M-g"          'goto-line)
(define-key esc-map "r"         'query-replace)
(global-set-key "\M-r"          'replace-string)
(global-set-key "\M-@"          'uncomment-region)
(global-set-key "\M-#"          'comment-region)
(global-set-key "\M--"          'dash-underline-last-line)

;; Let me use narrow to region
(put 'narrow-to-region 'disabled nil)

;; Enable auto-completion
;;(add-to-list 'load-path "~/.elisp/auto-complete/")
;;(add-to-list 'ac-dictionary-directories "~/.elisp/auto-complete/ac-dict")
;;(ac-config-default)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

;;Add sort-by-length capability
(defun sort-lines-by-length (reverse beg end)
  "Sort lines by length."
  (interactive "P\nr")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line nil nil
                   (lambda (l1 l2)
                     (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
                                        (list l1 l2)))))))))

;; Adding support for YAML Mode
(add-hook 'yaml-mode-hook
	  (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
