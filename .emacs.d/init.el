;; -*- lexical-binding: t; -*-

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(require 'use-package);; Temel ayarlar


(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq ring-bell-function 'ignore
      visible-bell nil)
(add-hook 'server-after-make-frame-hook
          (lambda ()
            (when (display-graphic-p)
              (scroll-bar-mode -1))))

;; Tamamen mode-line'ı devre dışı bırak
(setq-default mode-line-format nil)

;; (dolist (buffer (buffer-list))
;;   (with-current-buffer buffer
;;     (setq mode-line-format nil)))

;; (add-hook 'after-change-major-mode-hook
;;           (lambda ()
;;             (setq mode-line-format nil)))



(setq default-frame-alist '((font . "JetBrainsMono Nerd Font-15")))
; (setq default-frame-alist '((font . "Fira code-15")))

;; Sadece programlama modlarında aç
(add-hook 'prog-mode-hook (lambda ()
                            (display-line-numbers-mode 1)
                            (setq display-line-numbers-type 'relative)))



;; Vim kısayolları
;; (use-package evil
;;   :init (evil-mode 1))

;; Vim emülasyonu ve katlama özellikleri
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil) ; evil-collection ile uyumluluk
  :config
  (evil-mode 1))


(evil-define-key 'normal dired-mode-map
  "h" 'dired-up-directory
  "l" 'dired-find-file
  "j" 'dired-next-line
  "k" 'dired-previous-line
  "y" 'dired-copy-filename
  "d" 'dired-flag-file-deletion
  "D" 'dired-do-delete
  "n" 'dired-create-directory
  "a" 'dired-create-empty-file
  "r" 'dired-do-rename  ;; taşı/kes
  "c" 'dired-do-copy    ;; kopyala
  "m" 'dired-mark       ;; işaretle
  "u" 'dired-unmark     ;; işareti kaldır
  "q" 'kill-buffer-and-window)


(use-package vimish-fold
  :ensure t
  :config
  (vimish-fold-global-mode 1) ; Global olarak etkinleştir
  ;; İsteğe bağlı: Katlama görünümünü özelleştirme
  (setq vimish-fold-indication-mode 'right-fringe))

(use-package evil-vimish-fold
  :ensure t
  :after (evil vimish-fold)
  :config
  (evil-vimish-fold-mode 1))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))


;; Tema
(use-package doom-themes
  :config (load-theme 'doom-monokai-pro t))

(use-package all-the-icons)

;; Magit
(use-package magit :ensure t)
;; (use-package diff-hl :ensure t)
(use-package diff-hl
  :ensure t
  :hook ((prog-mode . diff-hl-mode))
  :config
  ;; Yüz (face) renk tanımlamaları
  (custom-set-faces
   '(diff-hl-change ((t (:foreground "orange" :background "orange"))))
   '(diff-hl-insert ((t (:foreground "green" :background "green"))))
   '(diff-hl-delete ((t (:foreground "red" :background "red")))))
(add-hook 'after-init-hook 'global-diff-hl-mode)


;; Which Key (tuş kombinasyonları gösterimi)
(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))

;; Dashboard Yapılandırması
(use-package dashboard
  :init
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-startup-banner "~/.emacs.d/logo.txt") ;; logo.txt dosyasını göster
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 3)
                          (agenda . 5)))
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-set-file-icons t)
(setq dashboard-set-heading-icons t)


;; Ivy/Counsel (Telescope benzeri dosya arama)
(use-package ivy
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        enable-recursive-minibuffers t))

(use-package counsel
  :after ivy
  :bind (("C-x C-f" . counsel-find-file)
         ("M-x" . counsel-M-x)))


(use-package vterm
  :ensure t
  :commands (vterm)
  :config
  (setq vterm-max-scrollback 10000))
  ;; (setq buffer-read-only t)


;; (defun my/toggle-vterm ()
;;   "Toggle a vterm buffer."
;;   (interactive)
;;   (if (get-buffer "*vterm*")
;;       (if (eq (current-buffer) (get-buffer "*vterm*"))
;;           (previous-buffer)
;;         (switch-to-buffer "*vterm*"))
;;     (vterm)))

(defun my/toggle-vterm ()
  "Toggle a vterm buffer."
  (interactive)
  (if (get-buffer "*vterm*")
      (if (eq (current-buffer) (get-buffer "*vterm*"))
          (previous-buffer)
        (progn
          (switch-to-buffer "*vterm*")
          (read-only-mode -1))) ;; bu satırı ekle
    (vterm)))




(defun my/open-or-create-notes-org ()
  "Open notes.org in current directory, creating it if necessary."
  (interactive)
  (let ((notes-path (expand-file-name "notes.org" default-directory)))
    ;; Dosya yoksa oluştur
    (unless (file-exists-p notes-path)
      (with-temp-buffer (write-file notes-path)))
    ;; Dosyayı aç
    (find-file notes-path)))

(defadvice counsel-find-file (after protect-buffers activate)
  "Yeni dosya açarken eski buffer'ları korur."
  (unless (file-exists-p (ad-get-arg 0))
    (find-file (ad-get-arg 0))))


(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt) ;; parser eksikse sorar
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(defun my/toggle-comment ()
  "Toggle comment on line or region."
  (interactive)
  (if (use-region-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-line 1)))

(defun my/run-fast-commit ()
  (interactive)
  (let ((script-path (expand-file-name "~/dotfiles/scripts/fast-commit.sh")))
    (call-process script-path nil 0)))

(use-package general
  :after evil
  :config
  (general-create-definer my-leader-def
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (my-leader-def
    "n" '(switch-to-buffer :wk "Next buffer")
    "/" '(my/toggle-comment :wk "Toggle comment")
    "i" '(my/toggle-vterm :wk "Toggle vterm")
    "w" '(save-buffer :wk "Save")
    "q" '(evil-save-and-quit :wk "Save & Quit")
    "Q" '(evil-quit-without-save :wk "Quit without saving")
    "r" '(restart-emacs :wk "Restart emacs")
    "g" '(:wk "git")
    "gg" '(my/run-fast-commit :wk "Commit project")
    "f" '(:wk "Find")
    "ff" '(counsel-find-file :wk "Find file")
    "fo" '(counsel-recentf :wk "Recent files")
    "o" '(:wk "Org")
    "oo" '(org-capture-goto-last-stored :wk "open last capture-note")
    "op" '(my/open-or-create-notes-org :wk "Create notes/open notes")
    "a" '(:wk "Agenda")  ;; Agenda için bir prefix
    "aa" '(org-agenda :wk "Open agenda")  ;; Agenda'yı aç
    "ad" '(org-agenda-list :wk "Daily agenda")  ;; Günlük agenda
    "aw" '(org-agenda-list-week :wk "Weekly agenda")  ;; Haftalık agenda
    "l" '(:wk "Lsp")
    "ll" '(lsp :wk "Activate lsp")
    "zA" '(vimish-fold :wk "Create fold")
    "t" '(:wk "Toggle")
    "tn" '(display-line-numbers-mode :wk "Toggle line numbers")
    "tm" '(hide-mode-line-mode :wk "Toggle mode-line")))



;; Recentf (son açılan dosyalar)
(use-package recentf
  :config
  (recentf-mode 1)
  (setq recentf-max-menu-items 50
        recentf-max-saved-items 50))

;; Org mode
(use-package org
  :hook (org-mode . org-indent-mode)
  :config
  (setq org-hide-emphasis-markers t
        org-startup-indented t
        org-tempo t
        org-pretty-entities t
        org-agenda-files '("~/github/notes/agenda/")  ;; Org dosyalarınızın bulunduğu dizin
        org-refile-targets '((nil :maxlevel . 3)
                             (org-agenda-files :maxlevel . 3))
	org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "|" "DONE(d)" "CANCELED(c)"))
        org-log-done 'time
        org-agenda-start-with-log-mode t
        org-agenda-span 'week
        org-agenda-start-on-weekday 1))  ;; Pazartesi ile başla

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :config
  (setq org-bullets-bullet-list
        '("◉" "○" "✿" "◇" "✸")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (C . t)
   (shell . t))) ;; örnek diller, istediğini ekle

(setq org-confirm-babel-evaluate nil)  ;; Her seferinde "emin misin?" demesin

;; Org-mode Görsel Ayarları
(setq org-fontify-done-headers t)                ;; Tamamlananları soluk göster
(setq org-auto-formatting t)                    ;; Otomatik formatlama
(setq org-list-demote-modify-bullet t)           ;; Madde işaretlerini güncelle

(setq org-checkbox-hierarchical-statistics nil) ;; alt başlıklardan etkilenmesin istersen
(setq org-log-done 'time) ;; DONE olduğunda zaman eklesin

;; Alt kutucuklar güncellendikçe üst başlıktaki [/], [%] güncellensin
(add-hook 'org-checkbox-statistics-hook #'org-update-statistics-cookies)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-checkbox-statistics-done ((t (:foreground "gray50" :strike-through t))))
 '(org-done ((t (:foreground "gray60" :strike-through t)))))

;; Org-agenda görünümü
(setq org-agenda-custom-commands
      '(("d" "Günlük agenda"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-overriding-header "Günlük Görevler"))))
         ((org-agenda-compact-blocks t)))
        ("w" "Haftalık agenda"
         ((agenda "" ((org-agenda-span 7)
                      (org-agenda-overriding-header "Haftalık Görevler"))))
         ((org-agenda-compact-blocks t)))))

(setq org-agenda-files '("~/github/notes/agenda/task.org"))
;; (setq org-default-notes-file "~/github/notes/agenda/task.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/github/notes/agenda/task.org")
         "* TODO %?\n  %u\n  %a")))

(setq org-default-notes-file (concat org-directory "~/github/notes/agenda/notes.org"))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)


(use-package autoinsert
  :ensure nil
  :hook (find-file . auto-insert)
  :custom
  (auto-insert-query nil) ; otomatik olsun, sormasın
  :config
  (define-auto-insert
    "\\.org\\'"
    (lambda ()
      (let ((filename (file-name-base (buffer-file-name))))
        (insert (format "#+title: %s\n" filename))
        (insert (format "#+date: %s\n\n" (format-time-string "%Y-%m-%d")))))))



(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package company
  :ensure t
  :hook (prog-mode  . company-mode)
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1)
  (global-company-mode))




(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")  ; LSP komutları için önek
  :hook (
         (c-mode . lsp)
         (c++-mode . lsp)
         (python-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-completion-provider :capf)
  ;; LSP otomatik başlatma için ek ayar
  (setq lsp-auto-guess-root t)  ; Proje kökünü otomatik tahmin et
  (setq lsp-restart 'auto-restart))  ; Gerekirse otomatik yeniden başlat

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-position 'bottom
        lsp-ui-sideline-enable t))

;; Python geliştirme ortamı
(use-package python
  :ensure nil ; Built-in paketi kullan
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  :config
  (require 'flymake)
  (require 'python)
  (use-package lsp-pyright
    :after lsp-mode
    :hook (python-mode . (lambda () (require 'lsp-pyright)))))

;; C/C++ geliştirme
(use-package cc-mode
  :ensure nil ; Built-in paketi kullan
  :hook ((c-mode c++-mode) . lsp))

;; clangd ayarları (lsp-mode ile entegre)
(setq lsp-clients-clangd-executable "clangd"
      lsp-clients-clangd-args '("--background-index"
                               "--clang-tidy"
                               "--completion-style=detailed"
                               "--header-insertion=never"))


;; C/C++ için lsp-clangd otomatik başlatma
(add-hook 'c-mode-hook 'lsp-deferred)
(add-hook 'c++-mode-hook 'lsp-deferred)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66"
     default))
 '(package-selected-packages
   '(all-the-icons annalist company counsel dashboard diff-hl doom-themes
		   evil-vimish-fold general key-chord lsp-pyright
		   lsp-ui lua-mode magit org-bullets treesit-auto
		   vterm yasnippet))
 '(warning-suppress-log-types '((native-compiler))))
