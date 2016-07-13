;;; init.el --- My emacs init file
;;;
;;; Commentary:
;;;
;;; Initial bootstrap to install `use-package` then a bunch of calls to it to
;;; install all the various modules we make use of.  Some random configuration
;;; at the end that doesn't really fit anywhere else.
;;;
;;; You'll have to run the following out of band commands to get this configuration
;;; working.  Mostly, this is just the Rust stuff.
;;;
;;; `curl https://sh.rustup.rs -sSf | sh`
;;; `rustup update stable`
;;; `rustup default stable`
;;; `cargo install racer`
;;; `sudo mkdir -p /usr/local/src`
;;; `sudo git clone https://github.com/rust-lang/rust.git /usr/local/src/rust`
;;;
;;; Code:
;;;


;; Initial bootstrap to get use-package so that we can set up
;; the rest of the packages and configuration defined below.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(setq use-package-verbose t)


;; Completion
(use-package company
  :ensure t
  :defer 0
  :diminish company-mode
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t))


;; Completion backend for Python
(use-package company-jedi
  :ensure t
  :defer 0
  :config
  (add-to-list 'company-backends 'company-jedi)
  (setq jedi:complete-on-dot t))


;; Battery usage
(use-package fancy-battery
  :ensure t
  :defer 0
  :config
  (fancy-battery-mode))


;; Syntax checking
(use-package flycheck
  :ensure t
  :defer 0
  :diminish flycheck-mode
  :config
  (global-flycheck-mode))


;; Syntax checking for Rust
(use-package flycheck-rust :ensure t :defer 0)


;; Git added/removed/modified annotation
(use-package git-gutter
  :ensure t
  :defer 0
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode t)
  (custom-set-variables '(git-gutter:always-show-separator t))
  (custom-set-variables '(git-gutter:separator-sign " "))
  (set-face-foreground 'git-gutter:separator "gray"))


;; Markdown
(use-package markdown-mode
  :ensure t
  :defer 0)


;; Good looking theme
(use-package monokai-theme
  :ensure t
  :defer 0
  :config
  (custom-set-variables '(custom-enabled-themes (quote (monokai)))))


;; File browser
(use-package neotree
  :ensure t
  :defer 0
  :config
  (global-set-key [f8] 'neotree-toggle))


;; Rust code completion
;;
;; We use a globally accessible checkout of Rust master for code
;; completion from the stdlib.
(use-package racer
  :ensure t
  :defer 0
  :diminish racer-mode
  :config
  (setq racer-cmd "racer")
  (setq racer-rust-src-path "/usr/local/src/rust/src/"))
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook (diminish 'eldoc-mode))


;; Rust
(use-package rust-mode
  :ensure t
  :defer 0)


;; Mode line
(use-package spaceline-config
  :ensure spaceline
  :defer 0
  :config
  (spaceline-emacs-theme))


;; SASS mode
(use-package sass-mode
  :ensure t
  :defer 0)


;; Toml
(use-package toml-mode
  :ensure t
  :defer 0)


;; Yaml
(use-package yaml-mode
  :ensure t
  :defer 0)


;; Misc other config
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-default-style "java")
(setq backup-inhibited t)
(setq auto-save-default nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'init)
;;; init.el ends here
