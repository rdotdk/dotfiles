
;; stop editing my init file with package-initialize
(setq package--init-file-ensured t)


(global-set-key [(control ?h)] 'delete-backward-char)

;;; prefer utf8 encoding
(prefer-coding-system 'utf-8)

;;; store all backup and autosave files in the tmp dir
;;; http://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;; detach custom file
;;; http://emacsblog.org/2008/12/06/quick-tip-detaching-the-custom-file/
(setq custom-file "~/.emacs.d/custom.el")

;; Automatically revert buffers
(global-auto-revert-mode)

;; Set customer package directory
(setq package-user-dir (format "%selpa_%s/" user-emacs-directory emacs-major-version))

;;; setup package archives
;;; http://melpa.milkbox.net/#/getting-started
(require 'package) 
(setq package-archives '(("melpa" . "https://melpa.org/packages/")))

;; set package-enable-at-startup to nil for slightly faster startup
(setq package-enable-at-startup nil)
(package-initialize)

;;; install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; use package
;;; https://github.com/jwiegley/use-package
(eval-when-compile
  (require 'use-package))
(use-package diminish
  :ensure t)

(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

;; paradox
;; https://github.com/Malabarba/paradox
;;(use-package paradox
;;  :ensure t
;;  :commands paradox-list-packages)
;; :config
;; (paradox-enable))

(use-package which-key
  :ensure t
  :defer t
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package magit
  :ensure t
  :commands magit-status
  :bind ("C-x g" . magit-status))

(use-package counsel
  :ensure t
  :diminish ivy-mode
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1)
  :bind
    ("C-c C-r" . ivy-resume)
    ("M-x" . counsel-M-x)
    ("C-x C-f" . counsel-find-file)
    ("<f1> f" . counsel-describe-function)
    ("<f1> v" . counsel-describe-variable)
    ("<f1> l" . counsel-find-library)
    ("<f2> i" . counsel-info-lookup-symbol)
    ("C-c g" . counsel-git)
    ("C-c j" . counsel-git-grep)
    ("C-c k" . counsel-ag)
    ("C-x l" . counsel-locate))

(use-package smex
  :ensure t)

(use-package ag
  :ensure t
  :commands ag)

;;; disable splash screen on emacs start
(setq inhibit-splash-screen t)

;;; disable menubar mode
(menu-bar-mode -1)

;;; disable scrollbar mode
(scroll-bar-mode -1)

;;; disable toolbar mode
(tool-bar-mode -1)

;; highlight matching parens
(show-paren-mode)

;; highlight-symbol
;; https://github.com/nschum/highlight-symbol.el

(use-package highlight-symbol
  :ensure t
  :init
  (global-set-key [(control f3)] 'highlight-symbol)
  (global-set-key [f3] 'highlight-symbol-next)
  (global-set-key [(shift f3)] 'highlight-symbol-prev)
  (global-set-key [(meta f3)] 'highlight-symbol-query-replace))


;; electric pair mode
;; automatic character pairing

;; enable pairing for {}
(setq electric-pair-pairs '((?\{ . ?\})))
(electric-pair-mode)

(use-package cc-mode
  :defer t
  :init
  (setq c-default-style "linux"
        c-basic-offset 4))

;; projectile
(use-package projectile
  :defer t
  :ensure t
  :bind ("C-c p f" .  projectile-find-file)
  :config
  (projectile-global-mode t))

(use-package counsel-projectile
  :defer t
  :ensure t
  :init
  (setq projectile-completion-system 'ivy))

(use-package eldoc
  :diminish eldoc-mode)

(use-package zenburn-theme
  :ensure t
  :init 
  (load-theme 'zenburn t))
