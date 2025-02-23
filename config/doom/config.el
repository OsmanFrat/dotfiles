;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ozu-settings
;; Yazı boyutunu arttır
(after! org
  (defun my/org-increase-font-size ()
    "Org Mode açıldığında yazı boyutunu büyütmek için simüle edilmiş zoom işlevi."
    (dotimes (_ 3)  ;; 4 kez çalıştırarak yazıyı büyüt
      (text-scale-increase 1)))

  (add-hook 'org-mode-hook #'my/org-increase-font-size))

;; hiding emphasis markers Altı çizili, kalın vb. işaretleri gizler
(after! org
  (setq org-hide-emphasis-markers t))

;; magit ayarlari - doom emacs git programi
;(defun my/magit-quick-commit ()
;  "Tüm değişiklikleri ekleyip rastgele bir commit mesajı ile push eden fonksiyon."
;  (interactive)
;  (magit-stage-modified)
;  (magit-commit-create `("-m" "Update"))
;  (magit-push-current-to-upstream nil))
;
;(map! :leader
;      :desc "Hızlı Commit & Push" "g q" #'my/magit-quick-commit)

(defun my/magit-quick-commit ()
  "Tüm değişiklikleri ekleyip tarih bazlı bir commit mesajı ile push eden fonksiyon."
  (interactive)
  (let ((commit-message (format-time-string "Update %Y-%m-%d %H:%M:%S")))
    (magit-stage-modified)
    (magit-commit-create `("-m" ,commit-message))
    (magit-push-current-to-upstream nil)))

(map! :leader
      :desc "Hızlı Commit & Push" "g q" #'my/magit-quick-commit)
