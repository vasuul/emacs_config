;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

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
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Point to ispell for spell checking
(setq ispell-program-name "/usr/local/bin/ispell")

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Load nyan mode becuase it is fun
(require 'nyan-mode)
(setq nyan-wavy-trail t)
(nyan-mode)

;; We like column indicators
(require 'fill-column-indicator)
(setq fci-rule-column 80)
(setq fci-rule-width 1)
(setq fci-rule-color "red")
(add-hook 'after-change-major-mode-hook 'fci-mode)

(require 'column-marker)

;; Set speed bar do special-d
(global-set-key (kbd "s-d") 'sr-speedbar-toggle)

;; Finally, load my special fancy modeline
(load (expand-file-name "modeline.el" user-emacs-directory))

