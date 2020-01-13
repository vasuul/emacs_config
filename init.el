;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; No bells
(setq ring-bell-function 'ignore)

;; No splash screen
(setq inhibit-startup-message t)

;; Stretch the cursor over multi char glyphs (i.e. tabs)
(setq x-stretch-cursor t)

;; Set the default window size
(add-to-list 'default-frame-alist '(height . 60))
(add-to-list 'default-frame-alist '(width . 160))

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

(require 'package)
(package-initialize)

;; Set up our package locations
;; ("melpa-stable" . "https://stable.melpa.org/packages/")
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("gnu" . "https://elpa.gnu.org/packages/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Taken from config at
;; https://github.com/nilsdeppe/MyEnvironment/blob/master/.emacs.el
(mapc #'(lambda (add) (add-to-list 'load-path add))
      (eval-when-compile
        (require 'package)
        (package-initialize)
        ;; Install use-package if not installed yet.
        (unless (package-installed-p 'use-package)
          (package-refresh-contents)
          (package-install 'use-package))
        ;; (require 'use-package)
        (let ((package-user-dir-real (file-truename package-user-dir)))
          ;; The reverse is necessary, because outside we mapc
          ;; add-to-list element-by-element, which reverses.
          (nreverse
           (apply #'nconc
                  ;; Only keep package.el provided loadpaths.
                  (mapcar #'(lambda (path)
                              (if (string-prefix-p package-user-dir-real path)
                                  (list path)
                                nil))
                          load-path))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Change the default garbage collection threshold during startup
;; Then put it back to something small after we start so that we areen't
;;  garbage collecting so much during startup
(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda ()
			       (setq gc-cons-threshold 1000000)))

(show-paren-mode t)               ; Highlight matching braces
(delete-selection-mode t)         ; overwrite the selected section on edit
(setq column-number-mode t)       ; Show column numbers
(setq make-backup-files nil)      ; don't make backup files
(setq-default case-fold-search t  ; Case insensitive search by default
	      search-highlight t) ; highlight all matches
(global-hl-line-mode t)           ; Highlight the current line

;; Delete trailing whitespace on save
(add-hook 'before-save-hook
	  (lambda ()
	    delete-trailing-whitespace))

;; Don't ask to follow version-control symlinks.  Just do it
(setq vc-follow-symlinks t)

(eval-when-compile
  (require 'use-package))
(use-package use-package
  :commands use-package-autoload-keymap)

;; Keep emacs Custom-settings in separate file
;; Ideally this will be where the OS/system specific stuff goes
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
    (load custom-file))

;; And now...
;;  We load all of our packages
;; TODO: Maybe put this into a packages.el file?

;; Emacs starup profiler
(use-package esup
  :ensure t
  :init
  (setq esup-child-max-depth 0)
  ;; Use a hook so the message doesn't get clobbered by other messages.
  (add-hook
   'emacs-startup-hook
   (lambda ()
     (message "Emacs took %s to start with %d garbage collections."
              (format "%.2f seconds"
                      (float-time
                       (time-subtract after-init-time before-init-time)))
              gcs-done))))

;; nyan mode because I like it...
(use-package nyan-mode
  :ensure t
  :config
  (setq nyan-wavy-trail t)
  (setq nyan-bar-length 30)
  (setq nyan-minimum-window-width 80)
  (nyan-mode))


;(setq rainbow-file (expand-file-name "rainbow-mode-1.0.1.el" user-emacs-directory))
;(if (file-exists-p rainbow-file)
;    ((load rainbow-file)
;     (require 'rainbow-mode)))

;; Load nyan mode becuase it is fun
;(require 'nyan-mode)
;(setq nyan-wavy-trail t)
;(nyan-mode)

;; Set speed bar do special-d
;(global-set-key (kbd "s-d") 'sr-speedbar-toggle)

;; Finally, load my special fancy modeline
;(load (expand-file-name "modeline.el" user-emacs-directory))

