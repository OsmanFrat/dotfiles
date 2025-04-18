;; -*- lexical-binding: t; -*-

;; Paket yönetimi
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; use-package yükleme
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Temel ayarlar
(setq inhibit-startup-screen t
      initial-scratch-message nil
      ring-bell-function 'ignore
      use-dialog-box nil
      make-backup-files nil)

;; Görsel ayarlar
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq visible-bell t)

;; Font ayarı (Fira Code)
(set-face-attribute 'default nil :font "Fira Code-12")

;; Paketler
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :hook (after-init . doom-modeline-mode))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Emacs"
        dashboard-startup-banner 'official
        dashboard-center-content t
        dashboard-items '((recents  . 5)
                         (bookmarks . 5)
                         (projects . 5)
                         (agenda . 5))))

;; Evil mode ve eklentileri
(use-package undo-fu)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-undo-system 'undo-fu
        evil-want-C-u-scroll t
        evil-search-module 'evil-search
        evil-ex-complete-emacs-commands nil
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-shift-round nil
        evil-want-C-i-jump nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-escape
  :after evil
  :config
  (setq evil-escape-key-sequence "jk"
        evil-escape-delay 0.2)
  (evil-escape-mode 1))


(use-package all-the-icons
  :if (display-graphic-p))


(use-package dired
  :ensure nil
  :config
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))


(insert (all-the-icons-octicon "file-binary"))  ;; GitHub Octicon, binary dosyası ikonu
(insert (all-the-icons-faicon "cogs"))          ;; FontAwesome, cogs ikonu
(insert (all-the-icons-wicon "tornado"))       ;; Weather, tornado ikonu




;; Tuş tanımlamaları
(use-package general
  :after evil
  :config
  (general-create-definer my-leader-def
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC")

  (my-leader-def
    "f" '(:ignore t :which-key "files")
    "f f" '(find-file :which-key "find file")
    "f o" '(counsel-recentf :which-key "recent files")
    "f s" '(save-buffer :which-key "save file")
    "f r" '(rename-file :which-key "rename file")
    "f d" '(delete-file :which-key "delete file")
    
    "b" '(:ignore t :which-key "buffers")
    "b b" '(switch-to-buffer :which-key "switch buffer")
    "b d" '(kill-this-buffer :which-key "kill buffer")
    "b n" '(next-buffer :which-key "next buffer")
    "b p" '(previous-buffer :which-key "previous buffer")
    
    "w" '(:ignore t :which-key "windows")
    "w w" '(other-window :which-key "other window")
    "w d" '(delete-window :which-key "delete window")
    "w s" '(split-window-below :which-key "split horizontal")
    "w v" '(split-window-right :which-key "split vertical")
    
    "p" '(:ignore t :which-key "projects")
    "p p" '(projectile-switch-project :which-key "switch project")
    "p f" '(projectile-find-file :which-key "find file in project")))

;; Otomatik tamamlama
(use-package company
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1))

;; Ivy ve Counsel
(use-package ivy
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        enable-recursive-minibuffers t))

(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)))

;; Projectile
(use-package projectile
  :init (projectile-mode 1)
  :config
  (setq projectile-enable-caching t
        projectile-completion-system 'ivy))

(use-package counsel-projectile
  :after (projectile counsel)
  :config (counsel-projectile-mode 1))

;; Org mode
(use-package org
  :hook (org-mode . visual-line-mode)
  :config
  (setq org-agenda-files '("~/org")
        org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
        org-log-done 'time))

(use-package org-super-agenda
  :after org-agenda
  :config (org-super-agenda-mode 1))

;; Dil desteği
(use-package lsp-mode
  :init (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode . lsp) (c++-mode . lsp))
  :commands lsp)

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode) . (lambda () (require 'ccls) (lsp))))

;; Diğer kullanışlı ayarlar
(electric-pair-mode 1)  ; Otomatik parantez tamamlama
(recentf-mode 1)        ; Son dosyaları hatırla
(setq recentf-max-saved-items 100)

;; Özel tuş tanımlamaları
(define-key evil-insert-state-map "jk" 'evil-normal-state)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-visual-state-map (kbd ";") 'evil-ex)

;; Performans ayarları
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


