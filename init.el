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
;;; `curl -sf https://raw.githubusercontent.com/brson/multirust/master/blastoff.sh | sh`
;;; `multirust update stable`
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


;; Completion
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  :config
  (setq company-tooltip-align-annotations t))


;; Completion backend for Python
(use-package company-jedi
  :ensure t
  :config
  (add-to-list 'company-backends 'company-jedi)
  (setq jedi:complete-on-dot t))


;; Syntax checking
(use-package flycheck :ensure t :config (global-flycheck-mode))


;; Syntax checking for Rust
(use-package flycheck-rust :ensure t)


;; Git added/removed/modified annotation
(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode t)
  (custom-set-variables '(git-gutter:always-show-separator t))
  (custom-set-variables '(git-gutter:separator-sign " "))
  (set-face-foreground 'git-gutter:separator "gray"))


;; Markdown
(use-package markdown-mode :ensure t)


;; Good looking theme
(use-package monokai-theme
  :ensure t
  :config
  (custom-set-variables '(custom-enabled-themes (quote (monokai)))))


;; Rust code completion
;;
;; Since we're making use of multirust, might as well use the stable
;; toolchain to install and use racer.
;;
;; Additionally, we use a globally accessible checkout of Rust master
;; for code completion from the stdlib.
(use-package racer
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  :config
  (setq racer-cmd "~/.multirust/toolchains/stable/cargo/bin/racer")
  (setq racer-rust-src-path "/usr/local/src/rust/src/"))


;; Rust
(use-package rust-mode :ensure t)


;; Toml
(use-package toml-mode :ensure t)


;; Yaml
(use-package yaml-mode :ensure t)


;; Misc other config
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-default-style "java")
(setq backup-inhibited t)
(setq auto-save-default nil)


(provide 'init)
;;; init.el ends here
