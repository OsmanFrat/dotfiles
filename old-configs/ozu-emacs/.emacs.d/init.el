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
(global-hl-line-mode 1)
(setq ring-bell-function 'ignore
      visible-bell nil)
(add-hook 'server-after-make-frame-hook
          (lambda ()
            (when (display-graphic-p)
              (scroll-bar-mode -1))))



;; Tamamen mode-line'ı devre dışı bırak
(setq-default mode-line-format nil)

(dolist (buffer (buffer-list))
  (with-current-buffer buffer
    (setq mode-line-format nil)))

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (setq mode-line-format nil)))



(setq default-frame-alist '((font . "JetBrainsMono Nerd Font-15")))
; (setq default-frame-alist '((font . "Fira code-15")))

;; Vim kısayolları
(use-package evil
  :init (evil-mode 1))

(use-package key-chord
  :ensure t
  :config
  (setq key-chord-delay 200) ; 100 milisaniye (0.1 saniye)
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))


;; Tema
(use-package doom-themes
  :config (load-theme 'doom-monokai-pro t))

(use-package all-the-icons)

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

(add-hook 'term-mode-hook (lambda () (read-only-mode -1)))
(add-hook 'vterm-mode-hook (lambda () (read-only-mode -1)))


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

(defvar my/cycle-buffer-index 0
  "Current index in the cycling buffer list.")

(defun my/valid-buffer-extension-p (filename)
  "Check if FILENAME has a desired extension."
  (let ((exts '("org" "c" "cpp" "py" "txt" "md" "json" "jsonc" "css" "html" "conf" "sh" "zsh")))
    (when filename
      (member (file-name-extension filename) exts))))

(defun my/update-cycle-buffer-list ()
  "Update the list of buffers with desired file extensions."
  (setq my/cycle-buffers-list
        (seq-filter
         (lambda (buf)
           (let ((name (buffer-file-name buf)))
             (and name (my/valid-buffer-extension-p name))))
         (buffer-list)))
  (setq my/cycle-buffer-index 0))

(defun my/cycle-through-buffers ()
  "Cycle through buffers with desired file extensions."
  (interactive)
  (unless (and my/cycle-buffers-list (not (equal my/cycle-buffers-list '())))
    (my/update-cycle-buffer-list))
  (when my/cycle-buffers-list
    (setq my/cycle-buffer-index (% my/cycle-buffer-index (length my/cycle-buffers-list)))
    (let ((buf (nth my/cycle-buffer-index my/cycle-buffers-list)))
      (when (buffer-live-p buf)
        (switch-to-buffer buf)
        (setq my/cycle-buffer-index (1+ my/cycle-buffer-index))))))



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


;; Leader key ayarları (SPC = boşluk tuşu
(use-package general
  :after evil
  :config
  (general-create-definer my-leader-def
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (my-leader-def
    "n" '(my/cycle-through-buffers :wk "Next buffer")
    "/" '(my/toggle-comment :wk "Toggle comment")
    "i" '(my/toggle-vterm :wk "Toggle vterm")
    "w" '(save-buffer :wk "Save")
    "q" '(evil-save-and-quit :wk "Save & Quit")
    "Q" '(evil-quit-without-save :wk "Quit without saving")
    "r" '(restart-emacs :wk "Restart emacs")
    "f" '(:wk "Find")
    "ff" '(counsel-find-file :wk "Find file")
    "fo" '(counsel-recentf :wk "Recent files")
    "o" '(:wk "Org")
    "oo" '(my/open-or-create-notes-org :wk "Create notes/open notes")
    "x" '(kill-buffer :wk "kill-buffer")
    "b" '(switch-to-buffer :wk "new buffer")
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
        org-pretty-entities t))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

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


;; LSP ve tamamlama
(use-package company
  :hook (prog-mode . company-mode)
  :ensure t
  :config
  (global-company-mode))


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

; (use-package lsp-clangd
;   :after lsp-mode)
;


;; Genel programlama ayarları
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)  






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f5f80dd6588e59cfc3ce2f11568ff8296717a938edd448a947f9823a4e282b66"
     default))
 '(package-selected-packages nil)
 '(warning-suppress-log-types '((native-compiler))))




