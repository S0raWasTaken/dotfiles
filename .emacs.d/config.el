(setq
 globals--banner-path  "etc/banners/megumacs.png" ; Banner image path shown in the dashboard
 globals--font         "Fantasque Sans Mono 11"   ; Font family and font size
 globals--theme        'gruvbox-custom            ; Theme used by Emacs.
 )

(when window-system
  (blink-cursor-mode 0) ; Disable the cursor blinking
  (scroll-bar-mode 0)   ; Disable the scroll bar
  (tool-bar-mode 0)     ; Disable the tool bar
  (tooltip-mode 0))     ; Disable the tooltips

(setq-default
 ad-redefinition-action 'accept                   ; Silence warnings for redefinition
 auto-window-vscroll nil                          ; Lighten vertical scroll
 confirm-kill-emacs 'yes-or-no-p                  ; Confirm before exiting Emacs
 cursor-in-non-selected-windows nil               ; Hide the cursor in inactive windows
 delete-by-moving-to-trash t                      ; Delete files to trash
 display-time-default-load-average nil            ; Don't display load average
 display-time-format "%H:%M"                      ; Format the time string
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 indent-tabs-mode nil                             ; Use tabs to indent
 inhibit-startup-screen t                         ; Disable start-up screen
 initial-scratch-message ""                       ; Empty the initial *scratch* buffer
 mouse-yank-at-point t                            ; Yank at point rather than pointer
 ns-use-srgb-colorspace nil                       ; Don't use sRGB colors
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 sentence-end-double-space nil                    ; End a sentence after a dot and a space
 show-help-function nil                           ; Disable help messages
 show-trailing-whitespace t                       ; Display trailing whitespaces
 split-height-threshold nil                       ; Disable vertical window splitting
 split-width-threshold nil                        ; Disable horizontal window splitting
 tab-width 4                                      ; Set width for tabs
 uniquify-buffer-name-style 'forward              ; Uniquify buffer names
 window-combination-resize t                      ; Resize windows proportionally
 x-stretch-cursor t                               ; Stretch cursor to the glyph width
 delete-old-versions -1                           ; Delete excess backup versions silently
 version-control t                                ; Use version control
 ring-bell-function 'ignore                       ; Silent bell when you make a mistake
 inhibit-compacting-font-caches t                 ; Faster navigation point (costs more memory)
 recentf-mode t                                   ; Keep recent files
 make-backup-files nil                            ; Stop creating backup files
 display-line-numbers-type 'relative              ; Use relative line numbers
 vc-follow-symlinks t
 frame-inhibit-implied-resize nil)                            ; Don't ask for confirmation when opening symlinked file
(cd "~/")                                         ; Move to the user directory
(global-display-line-numbers-mode t)              ; Enable line numbers globally
(delete-selection-mode 1)                         ; Replace region when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(global-auto-revert-mode 1)                       ; Automatically revert a buffer when it changes on disk
(fringe-mode '(8 . 0))                            ; Enable fringe on the left for git-gutter-fringe+
(electric-pair-mode t)                            ; Enable Matching delimeters
(electric-indent-mode t)                          ; Auto indentation
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-subword-mode 1)                           ; Iterate through CamelCase words
(menu-bar-mode 0)                                 ; Disable the menu bar
(mouse-avoidance-mode 'jump)                      ; Avoid collision of mouse with point
(put 'downcase-region 'disabled nil)              ; Enable downcase-region
(put 'upcase-region 'disabled nil)                ; Enable upcase-region
(show-paren-mode 1)                               ; Highlight matching parenthesis

(if (eq window-system 'ns)
	(toggle-frame-maximized)
  (toggle-frame-fullscreen))

(add-hook 'focus-out-hook #'garbage-collect)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(set-default-coding-systems 'utf-8)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

(setq-default custom-file (expand-file-name "etc/.custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'custom-theme-load-path (expand-file-name "etc/themes/" user-emacs-directory))

(use-package auto-package-update
  :defer t
  :ensure t
  :commands update-packages
  :custom
  (auto-package-update-delete-old-versions t)
  :config
  (auto-package-update-maybe))

(use-package quelpa
  :ensure t)

(use-package quelpa-use-package
  :ensure t)

(use-package no-littering
  :ensure t
  :demand t)

(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))

(defun open-config-file ()
  (interactive)
  (find-file (expand-file-name "config.org" user-emacs-directory)))

(set-frame-font globals--font)

(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")

(defconst fira-code-font-lock-keywords-alist
  (mapcar (lambda (regex-char-pair)
			`(,(car regex-char-pair)
			  (0 (prog1 ()
				       (compose-region (match-beginning 1)
								       (match-end 1)
								       ;; The first argument to concat is a string containing a literal tab
								       ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
		  '(("\\(www\\)"                   #Xe100)
			("[^/]\\(\\*\\*\\)[^/]"        #Xe101)
			("\\(\\*\\*\\*\\)"             #Xe102)
			("\\(\\*\\*/\\)"               #Xe103)
			("\\(\\*>\\)"                  #Xe104)
			("[^*]\\(\\*/\\)"              #Xe105)
			("\\(\\\\\\\\\\)"              #Xe106)
			("\\(\\\\\\\\\\\\\\)"          #Xe107)
			("\\({-\\)"                    #Xe108)
			("\\(!!\\)"                    #Xe10d)
			("\\(!=\\)"                    #Xe10e)
			("\\(!==\\)"                   #Xe10f)
			("\\(-}\\)"                    #Xe110)
			("\\(--\\)"                    #Xe111)
			("\\(---\\)"                   #Xe112)
			("\\(-->\\)"                   #Xe113)
			("[^-]\\(->\\)"                #Xe114)
			("\\(->>\\)"                   #Xe115)
			("\\(-<\\)"                    #Xe116)
			("\\(-<<\\)"                   #Xe117)
			("\\(-~\\)"                    #Xe118)
			("\\(#{\\)"                    #Xe119)
			("\\(#\\[\\)"                  #Xe11a)
			("\\(##\\)"                    #Xe11b)
			("\\(###\\)"                   #Xe11c)
			("\\(####\\)"                  #Xe11d)
			("\\(#(\\)"                    #Xe11e)
			("\\(#\\?\\)"                  #Xe11f)
			("\\(#_\\)"                    #Xe120)
			("\\(#_(\\)"                   #Xe121)
			("\\(\\.=\\)"                  #Xe123)
			("\\(\\?=\\)"                  #Xe127)
			("\\(\\?\\?\\)"                #Xe128)
			("\\(;;\\)"                    #Xe129)
			("\\(/\\*\\)"                  #Xe12a)
			("\\(/\\*\\*\\)"               #Xe12b)
			("\\(/=\\)"                    #Xe12c)
			("\\(/==\\)"                   #Xe12d)
			("\\(/>\\)"                    #Xe12e)
			("\\(//\\)"                    #Xe12f)
			("\\(///\\)"                   #Xe130)
			("\\(&&\\)"                    #Xe131)
			("\\(||\\)"                    #Xe132)
			("\\(||=\\)"                   #Xe133)
			("[^|]\\(|=\\)"                #Xe134)
			("\\(|>\\)"                    #Xe135)
			("\\(\\^=\\)"                  #Xe136)
			("\\(\\$>\\)"                  #Xe137)
			("\\(\\+\\+\\)"                #Xe138)
			("\\(\\+\\+\\+\\)"             #Xe139)
			("\\(\\+>\\)"                  #Xe13a)
			("\\(=:=\\)"                   #Xe13b)
			("[^!/]\\(==\\)[^>]"           #Xe13c)
			("\\(===\\)"                   #Xe13d)
			("\\(==>\\)"                   #Xe13e)
			("[^=]\\(=>\\)"                #Xe13f)
			("\\(=>>\\)"                   #Xe140)
			("\\(<=\\)"                    #Xe141)
			("\\(=<<\\)"                   #Xe142)
			("\\(=/=\\)"                   #Xe143)
			("\\(>-\\)"                    #Xe144)
			("\\(>=\\)"                    #Xe145)
			("\\(>=>\\)"                   #Xe146)
			("[^-=]\\(>>\\)"               #Xe147)
			("\\(>>-\\)"                   #Xe148)
			("\\(>>=\\)"                   #Xe149)
			("\\(>>>\\)"                   #Xe14a)
			("\\(<\\*\\)"                  #Xe14b)
			("\\(<\\*>\\)"                 #Xe14c)
			("\\(<|\\)"                    #Xe14d)
			("\\(<|>\\)"                   #Xe14e)
			("\\(<\\$\\)"                  #Xe14f)
			("\\(<\\$>\\)"                 #Xe150)
			("\\(<!--\\)"                  #Xe151)
			("\\(<-\\)"                    #Xe152)
			("\\(<--\\)"                   #Xe153)
			("\\(<->\\)"                   #Xe154)
			("\\(<\\+\\)"                  #Xe155)
			("\\(<\\+>\\)"                 #Xe156)
			("\\(<=\\)"                    #Xe157)
			("\\(<==\\)"                   #Xe158)
			("\\(<=>\\)"                   #Xe159)
			("\\(<=<\\)"                   #Xe15a)
			("\\(<>\\)"                    #Xe15b)
			("[^-=]\\(<<\\)"               #Xe15c)
			("\\(<<-\\)"                   #Xe15d)
			("\\(<<=\\)"                   #Xe15e)
			("\\(<<<\\)"                   #Xe15f)
			("\\(<~\\)"                    #Xe160)
			("\\(<~~\\)"                   #Xe161)
			("\\(</\\)"                    #Xe162)
			("\\(</>\\)"                   #Xe163)
			("\\(~@\\)"                    #Xe164)
			("\\(~-\\)"                    #Xe165)
			("\\(~=\\)"                    #Xe166)
			("\\(~>\\)"                    #Xe167)
			("[^<]\\(~~\\)"                #Xe168)
			("\\(~~>\\)"                   #Xe169)
			("\\(%%\\)"                    #Xe16a)
			("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
			("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))

(add-hook 'prog-mode-hook
		  #'add-fira-code-symbol-keywords)

(use-package autothemer
  :ensure t)

;; (use-package kaolin-themes
;;   :defer t
;;   :ensure t
;;   :custom
;;   (kaolin-themes-bold t)
;;   (kaolin-themes-italic t)
;;   (kaolin-themes-underline t)
;;   (kaolin-themes-distinct-company-scrollbar t)
;;   :config
;;   (load-theme 'doom-gruvbox t))

(use-package doom-themes
  :ensure t
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  (doom-themes-treemacs-enable-variable-pitch nil)
  :config
  (load-theme globals--theme t)
  (doom-themes-treemacs-config))

(use-package nano-theme
  :ensure t
  :defer t)

(set-face-attribute 'font-lock-keyword-face nil :weight 'bold)

(use-package all-the-icons
  :ensure t)

(use-package solaire-mode
  :ensure t
  :hook (after-init . solaire-global-mode))

(use-package rainbow-mode
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; (use-package spaceline
;;   :ensure t
;;   :init
;;   (progn
;; 	(setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
;; 	(setq-default powerline-default-separator 'slant)
;; 	;; (setq spaceline-separator-dir-left '(right . right))
;; 	)
;;   :config
;;   (spaceline-emacs-theme)
;;   (setq spaceline-buffer-encoding-abbrev-p nil
;; 		spaceline-workspace-number-p t
;; 		spaceline-window-numbers-unicode nil
;; 		spaceline-version-control-p nil
;; 		spaceline-minor-modes-p nil
;; 		spaceline-major-mode-p nil
;; 		spaceline-buffer-size-p t
;; 		spaceline-window-number-p t
;; 		spaceline-buffer-id-p t
;; 		spaceline-buffer-size-p t)
;;   (powerline-reset))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-init)
  :custom
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-major-mode-color-icon nil)
  (doom-modeline-icon (display-graphic-p))
  (doom-modeline-buffer-modification-icon nil)
  (doom-modeline-flycheck-icon nil)
  (doom-modeline-checker-simple-format t)
  (doom-modeline-buffer-encoding nil)
  (doom-modeline-height 35))

(use-package dashboard
  :ensure t
  :init
  (add-hook 'dashboard-mode-hook (lambda () (setq show-trailing-whitespace nil)))
  :custom
  (dashboard-banner-logo-title "[M E G U M A C S]")
  (dashboard-startup-banner (expand-file-name globals--banner-path user-emacs-directory))
  (dashboard-footer-messages '("EXPLOOOOOOOOOOSIONNN!"))
  (dashboard-footer-icon (all-the-icons-wicon "meteor" :height 1.1 :v-adjust -0.05 :face 'font-lock-keyword-face))
  (dashboard-center-content t)
  (dashboard-set-heading-icons t)
  ;; (dashboard-page-separator "\n\f\n")
  (dashboard-set-file-icons t)
  (dashboard-set-navigator t)
  (dashboard-navigator-buttons
   `(
     ;; Links
     ((,(all-the-icons-octicon "octoface" :height 1.1 :v-adjust 0.0)
       "Homepage"
       "Browse homepage"
       (lambda (&rest _) (browse-url "https://github.com/b-coimbra/.emacs.d")) nil "" " |")
      (,(all-the-icons-faicon "refresh" :height 1.1 :v-adjust 0.0)
       "Update"
       "Update Megumacs"
       (lambda (&rest _) (update-packages)) warning "" " |")
      (,(all-the-icons-faicon "flag" :height 1.1 :v-adjust 0.0) nil
       "Report a BUG"
       (lambda (&rest _) (browse-url "https://github.com/b-coimbra/.emacs.d/issues/new")) error "" ""))
     ;; Empty line
     (("" "\n" "" nil nil "" ""))
     ;; Keybindings
     ((,(all-the-icons-octicon "file-text" :height 1.1 :v-adjust -0.1)
       " Open file" nil
       (lambda (&rest _) (find-file)) nil "" "            SPC f f"))
     ((,(all-the-icons-octicon "file-directory" :height 1.0 :v-adjust -0.1)
       " Open project" nil
       (lambda (&rest _) (counsel-projectile-switch-project)) nil "" "         SPC p p"))
     ((,(all-the-icons-octicon "three-bars" :height 1.1 :v-adjust -0.1)
       " File explorer" nil
       (lambda (&rest _) (counsel-projectile-switch-project)) nil "" "        SPC t t"))
     ((,(all-the-icons-octicon "settings" :height 0.9 :v-adjust -0.1)
       " Open settings" nil
       (lambda (&rest _) (open-config-file)) nil "" "        SPC f P"))
     ))
  :config
  (dashboard-setup-startup-hook))

(use-package company
  :defer 0.5
  :ensure t
  :delight
  :init (global-company-mode)
  :custom
  (company-begin-commands '(self-insert-command))
  (company-minimum-prefix-length 0)
  (company-idle-delay 0.1)
  (company-show-numbers t)
  (company-tooltip-align-annotations t)
  :config
  (add-to-list 'company-backends
               '(company-yasnippet
                 company-files
                 company-keywords
                 company-capf
                 company-dabbrev
                 company-dabbrev-code
                 company-jedi)))

(use-package company-jedi
      :ensure t
      :config
      (setq jedi:setup-keys t)
      (setq jedi:complete-on-dot t))

(use-package evil
  :ensure t
  :custom
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)
  :init
  (setq evil-want-integration t)
  :config
  (evil-mode 1))

(use-package evil-escape
  :ensure t
  :custom
  (evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-mc
  :ensure t
  :after evil
  :init
  (global-evil-mc-mode 1))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package org
  :init
  (setq org-startup-folded t)
  :ensure t
  :config
  ;; prettify
  (setq org-hide-macro-markers t
        org-hide-emphasis-markers t
        org-adapt-indentation t
        org-hide-leading-stars t
        org-odd-levels-only t)
  ;; org archive
  (setq org-archive-location (concat "archive/"
                                     (format-time-string "%Y-%m" (current-time))
                                     "_%s_archive::"))
  ;; org-todo
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"
           "DOING(d!)"
           "MAYBE(m)"
           "BLOCKED(b@)"
           "DONE(D!)"
           "READ(r)"
           "ARCHIVED(a!)")))
  (setq org-todo-keyword-faces
        '(("TODO"     . (:foreground "HotPink3" :weight bold))
          ("DOING"    . (:foreground "salmon" :weight bold))
          ("BLOCKED"  . (:foreground "DeepPink" :weight bold))
          ("MAYBE"    . (:foreground "LightSteelBlue4" :weight bold))
          ("DONE"     . (:foreground "SeaGreen3" :weight bold))
          ("READ"     . (:foreground "SteelBlue2" :weight bold))
          ("ARCHIVED" . (:foreground "LightSlateGrey" :weight bold)))))

(use-package ox-reveal
  :ensure t
  :defer 3
  :after org
  :custom
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"))

(use-package calfw-org
  :ensure t
  :config
  (setq cfw:org-agenda-schedule-args '(:timestamp :scheduled :deadline)))

(use-package htmlize
  :ensure t)

(use-package calfw
  :ensure t)

(use-package general
  :ensure t
  :config
  (general-evil-setup t)
  (define-key evil-motion-state-map " " nil)
  ;; (general-evil-define-key 'normal 'global
  ;;   :prefix "SPC"
  (general-define-key
    :prefix "SPC"
    :states 'normal
    ;; Misc
    "SPC" 'counsel-M-x
    "TAB" 'mode-line-other-buffer
    "." 'xref-find-definitions
    "," 'xref-pop-marker-stack
    "'" 'eshell
    "qq" 'evil-quit
    "s" 'swiper
    ;; Applications
    "a" '(:ignore t :which-key "applications")
    "au" 'undo-tree-visualize
    "aU" 'update-packages
    "ac" 'cfw:open-org-calendar
    ;; Buffers
    "b" '(:ignore t :which-key "buffers")
    "bb" 'counsel-switch-buffer
    "bd" 'kill-this-buffer
    "bp" 'previous-buffer
    "bn" 'next-buffer
    "bN" 'evil-buffer-new
    "be" 'erase-buffer
    ;; Bookmarks
    "B" '(:ignore t :which-key "bookmarks")
    "BB" 'bookmark-jump
    "Bs" 'bookmark-set
    ;; Compiling
    "c" 'compile
    ;; Errors
    "e" '(:ignore t :which-key "errors")
    ;; Files
    "f" '(:ignore t :which-key "file")
    "ff" 'find-file
    "fr" 'counsel-recentf
    "fs" 'save-buffer
    "fS" 'evil-write-all
    "fR" 'rename-file
    "fb" 'ranger-show-bookmarks
    "fP" 'open-config-file
    ;; Focus
    "F" '(:ignore t :which-key "focus")
    ;; LSP
    "l" '(:ignore t :which-key "language")
    ;; Projects
    "p" '(:ignore t :which-key "project")
    ;; Toggles
    "t" '(:ignore t :which-key "toggles")
    "tn" 'display-line-numbers-mode
    "tL" 'visual-line-mode
    "tu" 'lsp-ui-mode
    "ti" 'highlight-indent-guides-mode
    ;; Themes
    "T" '(:ignore t :which-key "themes")
    "Ts" 'counsel-load-theme
    ;; Windows
    "w" '(:ignore t :which-key "window")
    "wm" 'delete-other-windows
    "wf" 'delete-other-windows
    "wj" 'evil-window-down
    "wk" 'evil-window-up
    "wl" 'evil-window-right
    "wh" 'evil-window-left
    "ws" 'split-and-follow-horizontally
    "wv" 'split-and-follow-vertically
    "wd" 'evil-window-delete
    "wc" 'evil-window-delete
    "wH" 'evil-window-move-far-left
    "wL" 'evil-window-move-far-right
    "wK" 'evil-window-move-very-top
    "wJ" 'evil-window-move-very-bottom
    "w=" 'balance-windows))

(use-package which-key
  :defer 5
  :ensure t
  :config
  (which-key-mode))

(use-package magit
  :ensure t
  :defer 3
  :general
  (nmap
    :prefix "<SPC>"
    "g" '(nil :which-key "magit")
    "gs" 'magit-status
    "gb" 'magit-blame))

(use-package git-gutter+
      :ensure t
      :config
      (global-git-gutter+-mode))

(use-package git-gutter-fringe+
  :ensure t
  :after git-gutter+
  :custom
  (git-gutter-fr+-side 'left-fringe)
  :config
  (git-gutter-fr+-minimal))

(use-package epa-file
  :ensure nil
  :config
  (setq epa-file-encrypt-to '("b-coimbra@hotmail.com"))
  :custom
  (epa-file-select-keys 'silent))

(use-package ranger
  :ensure t
  :defer t
  :general
  (nmap
	:prefix "SPC"
	"ar" 'ranger
	"ad" 'deer)
  :config
  (ranger-override-dired-mode t))

(use-package treemacs
  :ensure t
  :defer t
  :general
  (nmap
    :prefix "<SPC>"
    "tt" 'treemacs)
  :custom
  (treemacs-no-png-images nil)
  (treemacs-width 35))

(use-package treemacs-evil
  :ensure t)

(use-package treemacs-magit
  :ensure t)

(use-package projectile
  :ensure t
  :defer t
  :custom
  (projectile-enable-caching t)
  :config
  (projectile-mode))

(use-package counsel-projectile
  :ensure t
  :general
  (nmap
    :prefix "<SPC>"
    "pp" 'counsel-projectile-switch-project
    "pf" 'counsel-projectile-find-file
    "ps" 'counsel-projectile-git-grep
    "pd" 'counsel-projectile-find-dir
    "pR" 'projectile-replace))

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode)
  :general
  (nmap
	:prefix "<SPC>"
	"en" 'flycheck-next-error
	"ep" 'flycheck-previous-error))

(use-package rust-mode
  :ensure t
  :custom
  (rust-format-on-save t))

(use-package ruby-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :custom
  (js-indent-level 2)
  (js2-basic-offset 2)
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package rjsx-mode
  :ensure t)

(use-package typescript-mode
  :ensure t)

(use-package web-mode
  :ensure t
  :custom
  (web-mode-code-indent-offset 2)
  (web-mode-markup-indent-offset 2))

(use-package csharp-mode
  :ensure t)

(use-package graphql-mode
  :defer t
  :ensure t)

(use-package vue-mode
  :defer t
  :ensure t)

(use-package python-mode
  :ensure t
  :hook (python-mode-hook . jedi:setup))

(use-package lsp-mode
  :ensure t
  :general
  (nmap
	:prefix "<SPC>"
	"lF" 'lsp-format-buffer
	"lR" 'lsp-rename)
  :hook ((js2-mode        . lsp-deferred)
		 (js-mode         . lsp-deferred)
		 (rjsx-mode       . lsp-deferred)
		 (typescript-mode . lsp-deferred)
		 (rust-mode       . lsp-deferred)
		 (python-mode     . lsp-deferred)
		 (ruby-mode       . lsp-deferred))
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-enable-completion-at-point t)
  (setq lsp-rust-analyzer-proc-macro-enable t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-analyzer-display-chaining-hints t))

(use-package lsp-ui
      :ensure t
      :after lsp-mode
      :commands lsp-ui-mode
      :hook (lsp-mode . lsp-ui-mode)
      :general
      (nmap
	:prefix "<SPC>"
	"li" 'lsp-ui-peek-find-implementation
	"lr" 'lsp-ui-peek-find-references
	"ld" 'lsp-ui-peek-find-definitions
	"ll" 'lsp-ui-flycheck-list
	"la" 'lsp-ui-sideline-apply-code-actions)
      :custom
      (lsp-ui-doc-enable t)
      (lsp-ui-sideline-enable nil)
      (lsp-ui-flycheck-enable t)
      (lsp-ui-flycheck-live-reporting t)
      (lsp-ui-sideline-toggle-symbols-info t)
      (lsp-ui-sideline-show-hover t)
      (lsp-ui-peek-enable t))

(use-package winum
  :ensure t
  :custom
  (winum-auto-setup-mode-line nil)
  :config
  (winum-mode))

(use-package eyebrowse
  :ensure t
  :general
  :config
  (eyebrowse-mode)
  (eyebrowse-setup-opinionated-keys))

(use-package windmove
  :ensure t
  :general
  (nmap
    :prefix "<SPC>"
    "wH" 'windmove-swap-states-left
    "wL" 'windmove-swap-states-right
    "wK" 'windmove-swap-states-up
    "wJ" 'windmove-swap-states-down)
  :init
  (windmove-default-keybindings))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(use-package ivy
  :ensure t
  :general
  (nmap
	:prefix "<SPC>"
	";" 'avy-goto-word-1
	":" 'avy-goto-char)
  :custom
  (ivy-count-format "(%d/%d) ")
  (avy-background t)
  :config
  (global-set-key "\C-s" 'swiper)
  (ivy-mode))

(use-package ivy-rich
  :ensure t
  :after ivy
  :init
  (ivy-rich-mode 1)
  :config
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package counsel
  :ensure t)

(use-package highlight-indent-guides
  :defer t
  :ensure t
  ;; :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-method 'character)
  (highlight-indent-guides-character ?\|))

(use-package focus
  :defer t
  :ensure t
  :general
  (nmap
	:prefix "<SPC>"
	"tf" 'focus-mode
	"Fp" 'focus-pin
	"Fu" 'focus-unpin
	"Fc" 'focus-change-thing))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package origami
  :ensure t
  :hook ((js2-mode        . origami-mode)
         (js-mode         . origami-mode)
         (typescript-mode . origami-mode)
         (rust-mode       . origami-mode)))

(use-package yasnippet
  :ensure t
  :general
  (nmap
	:prefix "<SPC>"
	"yt" 'yas-describe-tables)
  :init
  (yas-global-mode 1)
  :custom
  (yas-prompt-functions 'yas-ido-prompt))

(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))

(use-package yasnippet-snippets
  :after yasnippet
  :ensure t)

(use-package elcord
  :ensure t
  :init
  (elcord-mode)
  :config
  (setq elcord-client-id "903078200886853665")
  (setq elcord-editor-icon "megumacs-icon"))
