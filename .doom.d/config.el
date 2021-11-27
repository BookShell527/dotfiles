(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "Fira Code" :size 16)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 16)
      doom-big-font (font-spec :family "Fira Code" :size 24))

(add-hook 'before-save-hook #'+format/buffer nil t)
(setq display-line-numbers-type 'relative)
(setq doom-line-numbers-style 'relative)
(setq tab-width 4)

(setq org-startup-with-inline-images t)
(setq org-image-actual-width (list 400))
(setq org-directory "~/org/")
(setq org-hide-emphasis-markers t)
(defun narrow-to-region-indirect (start end)
  (interactive "r")
  (deactivate-mark)
  (let ((buf (clone-indirect-buffer nil nil)))
    (with-current-buffer buf
      (narrow-to-region start end))
      (switch-to-buffer buf)))

(setq user-full-name "Firsto Kurniaji" user-mail-address "kurniajijagad@gmail.com")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(setq user-mail-address "kurniajijagad@gmail.com"
      user-full-name  "Firsto Kurniaji"
      mu4e-get-mail-command "mbsync -c ~/.mbsyncrc -a"
      mu4e-update-interval 300
      mu4e-main-buffer-hide-personal-addresses t
      message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.google.com" 587 nil nil))
      mu4e-sent-folder "/kurniajijagad/Sent"
      mu4e-drafts-folder "/kurniajijagad/Drafts"
      mu4e-trash-folder "/kurniajijagad/Trash"
      mu4e-maildir-shortcuts
      '(("/kurniajijagad/Inbox"      . ?i)
        ("/kurniajijagad/Sent Items" . ?s)
        ("/kurniajijagad/Drafts"     . ?d)
        ("/kurniajijagad/Trash"      . ?t)))

(setq treemacs-width 25)
(lsp-treemacs-sync-mode 1)

(setq neo-window-width 25)

(map! :leader "l" #'evil-window-right)
(map! :leader "k" #'evil-window-up)
(map! :leader "j" #'evil-window-down)
(map! :leader "h" #'evil-window-left)
(map! :leader "e" #'+treemacs/toggle)
(map! "C-<prior>" #'+tabs:next-or-goto)
(map! "C-<next>" #'+tabs:previous-or-goto)
(map! "C-S-w" #'kill-this-buffer)

(setq lsp-tailwindcss-add-on-mode 1)
(use-package! lsp-tailwindcss)
(add-hook 'js2-mode-hook 'web-mode-hook)

(setq lsp-dart-line-length 200)
(setq lsp-dart-flutter-widget-guides nil)
(setq lsp-dart-flutter-sdk-dir "/home/tempp/Application/dart-sdk")
(setq lsp-dart-sdk-dir "/home/tempp/Application/flutter")
