;;; init.el --- My emacs init file
;;;
;;; Commentary:
;;;
;;; Initial bootstrap to install `use-package` then a bunch of calls to it to
;;; install all the various modules we make use of.  Some random configuration
;;; at the end that doesn't really fit anywhere else.
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
  :defer 0
  :diminish company-mode
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-tooltip-align-annotations t)
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  :bind ([?\t] . company-indent-or-complete-common))


;; Completion backend for Go
(use-package company-go
  :ensure t
  :defer 0
  :config
  (add-to-list 'company-backends 'company-go))


;; Completion backend for Python
(use-package company-jedi
  :ensure t
  :defer 0
  :config
  (add-to-list 'company-backends 'company-jedi)
  (setq jedi:complete-on-dot t))


;; Completion for Terraform config
(use-package company-terraform
  :ensure t
  :defer 0)


;; Required for the diminish keyword
(use-package diminish
  :ensure t
  :defer 0)


;; Dockerfile mode
(use-package dockerfile-mode
  :ensure t
  :defer 0
  :config
  (add-to-list 'auto-mode-alist '("\\.dockerfile\\'" . dockerfile-mode)))


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


;; Syntax checking for Pony
(use-package flycheck-pony
  :ensure t
  :defer 0)


;; Syntax checking for Rust
(use-package flycheck-rust
  :ensure t
  :defer 0)


;; Git added/removed/modified annotation
(use-package git-gutter
  :ensure t
  :defer 0
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode t)
  (custom-set-variables '(git-gutter:always-show-separator t))
  (custom-set-variables '(git-gutter:separator-sign " "))
  (custom-set-variables '(git-gutter:modified-sign "~")))


;; Go language
(use-package go-mode
  :ensure t
  :defer 0)

;; Handlebars templates
(use-package handlebars-mode
  :ensure t
  :defer 0)


;; M-x command completion
(use-package helm
  :ensure t
  :defer 0
  :bind ("M-x" . helm-M-x))


;; Jsonnet templates
(use-package jsonnet-mode
  :ensure t
  :defer 0)


;; Use the language server protocol
(use-package lsp-mode
  :ensure t
  :defer 0
  :config
  (add-hook 'rust-mode #'lsp-mode)
  (add-hook 'python-mode #'lsp-mode))


;; Language server UI niceties
(use-package lsp-ui
  :ensure t
  :defer 0)


;; Lua language
(use-package lua-mode
  :ensure t
  :defer 0)


;; Markdown
(use-package markdown-mode
  :ensure t
  :defer 0)


;; Good looking theme
(use-package monokai-theme
  :ensure t
  :defer 0
  :init
  (load-theme 'monokai t))


;; File browser
(use-package neotree
  :ensure t
  :defer 0
  :config
  (global-set-key [f8] 'neotree-toggle))


;; Pony support
(use-package ponylang-mode
  :ensure t
  :defer 0
  :bind
  ([f6] . ponylang-menu))


;; Protobuf support
(use-package protobuf-mode
  :ensure t
  :defer 0)


;; Puppet support
(use-package puppet-mode
  :ensure t
  :defer 0)


;; Rust code completion
(use-package racer
  :ensure t
  :defer 0
  :diminish racer-mode
  :config
  (setq racer-cmd "racer")
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook (diminish 'eldoc-mode)))


;; RPM spec files
(use-package rpm-spec-mode
  :ensure t
  :defer 0
  :config
  (add-to-list 'auto-mode-alist '("\\.spectemplate\\'" . rpm-spec-mode)))


;; Rust
(use-package rust-mode
  :ensure t
  :defer 0)


;;Configure spaceline / powerline
(use-package spaceline-config
  :ensure spaceline
  :defer 0
  :config
  (powerline-default-theme))


;; SASS mode
(use-package sass-mode
  :ensure t
  :defer 0)


;; Terraform
(use-package terraform-mode
  :ensure t
  :defer 0)


;; Toml
(use-package toml-mode
  :ensure t
  :defer 0)


;; Ocaml
(use-package tuareg
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
(setq-default truncate-lines t)
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq save-abbrevs nil)

(provide 'init)
;;; init.el ends here
