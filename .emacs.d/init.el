;; EMACS CONF
;;
;;
;;

(require 'package)
;; Set up package.el to work with MELPA
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/")))
;; (add-to-list 'package-archives '("melpa-tsinghua" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))

(package-initialize)
;; (package-refresh-contents) ;; #1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cl - common lisp extesion
(require 'cl)
;; Add Packages
(defvar my/packages '(
;; --- Auto-completion ---
		      company which-key
;; --- Snippets ---
		      yasnippet yasnippet-snippets
;; --- Better Editor ---
		      evil evil-nerd-commenter smex sr-speedbar
		      swiper counsel
		      ;; smartparens
;; --- Major Mode ---
		      markdown-mode
		      ;; js2-mode
;; --- Minor Mode ---
		      ;; nodejs-repl
		      ;; exec-path-from-shell
;; --- Modeline ---
		      spaceline
;; --- Themes ---
		      monokai-theme
		      solarized-theme
		      atom-dark-theme
) "Default packages")
(setq package-selected-packages my/packages)
(defun my/packages-installed-p ()
  (loop for pkg in my/packages
    when (not (package-installed-p pkg)) do (return nil)
    finally (return t)))
(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents) ;; #1
   (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))
;; Find Executable Path on OS X
; when (memq window-system '(mac ns))
;  (exec-path-from-shell-initialize))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Download Evil
;;(unless (package-installed-p 'evil)
;;   (package-install 'evil))

(defun open-init-file()
  ";; 快速打开配置文件"
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(defun reload-init-file()
  ";; 快速重载配置文件"
  (interactive)
  (load-file "~/.emacs.d/init.el"))
;; 将函数 open-init-file 绑定到 <f2>e 键上
(global-set-key (kbd "<f1>e") 'open-init-file)
(global-set-key (kbd "<f1>r") 'reload-init-file)
;; 不闪烁光标
(setq blink-cursor-mode nil)
;; 关闭备份文件特性
(setq make-backup-files nil)
;; 关闭自动保存文件
(setq auto-save-default nil)
;; 只输入 (y or n)
(fset 'yes-or-no-p 'y-or-n-p)
;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
;; tab 缩进
(setq indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
;; 自动加载外部修改过的文件。
(global-auto-revert-mode 1) 
;; eww default engine
(setq eww-search-prefix "https://www.dogedoge.com/results?q=")

;; 设置为中文简体语言环境
(set-language-environment 'Chinese-GB)
;; language
;; (setq current-language-environment "Chinese-GBK")
;; 设置emacs 使用 utf-8
(setq locale-coding-system 'utf-8)
;; 设置键盘输入时的字符编码
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;; 文件默认保存为 utf-8
(set-buffer-file-coding-system 'utf-8)
(set-default buffer-file-coding-system 'utf8)
(set-default-coding-systems 'utf-8)
;; 解决粘贴中文出现乱码的问题
(set-clipboard-coding-system 'utf-8)
;; 终端中文乱码
(set-terminal-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))
;; 解决文件目录的中文名乱码
(setq-default pathname-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
;; 解决 Shell Mode(cmd) 下中文乱码问题
(defun change-shell-mode-coding ()
  (progn
    (set-terminal-coding-system 'gbk)
    (set-keyboard-coding-system 'gbk)
    (set-selection-coding-system 'gbk)
    (set-buffer-file-coding-system 'gbk)
    (set-file-name-coding-system 'gbk)
    (modify-coding-system-alist 'process "*" 'gbk)
    (set-buffer-process-coding-system 'gbk 'gbk)
    (set-file-name-coding-system 'gbk)))
;; win平台剪贴板需要用utf-16-le
(when (eq system-type 'windows-nt)
  (set-next-selection-coding-system 'utf-16-le)
  (set-selection-coding-system 'utf-16-le)
  (set-clipboard-coding-system 'utf-16-le))

;; c 的设置
(defun my-c-mode-hook ()
  (setq c-basic-offset 4
        c-indent-level 4
	indent-tabs-mode nil
        c-default-style "linux"))
(add-hook 'c-mode-common-hook 'my-c-mode-hook)

;; auto-pair
;; (setq skeleton-pair-alist
;;       '((?\" _ "\"" >)
;;         (?\' _ "'" >)
;;         (?\( _ ")" >)
;;         (?\[ _ "]" >)
;;         (?\{ _ "}" >)))
;; (setq skeleton-pair t)

;; 默认开启全屏
(setq initial-frame-alist (quote ((fullscreen . maximized)))) 
;; 字体
;; (set-default-font "M+ 1mn regular-16")
(defun set-font (english chinese english-size chinese-size)
   (set-face-attribute 'default nil :font
                       (format   "%s:pixelsize=%d"  english english-size))
   (dolist (charset '(kana han symbol cjk-misc bopomofo))
     (set-fontset-font (frame-parameter nil 'font) charset
                       (font-spec :family chinese :size chinese-size))))
(set-font "M+ 1mn regular" "YouYuan" 26 26)
;; 关闭菜单栏
(menu-bar-mode -1)
;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)
;; 关闭文件滑动控件
(scroll-bar-mode -1)
;; 显示行号
(global-linum-mode 1)
;; 高亮当前行
(global-hl-line-mode 1)
;; 显示匹配括号
(show-paren-mode 1)
;; 显示日期 
(setq display-time-day-and-date t)
(setq display-time-string-forms '((propertize (format-time-string "%F %a %R") )))
(display-time)

;; =========================== enable plugin
(evil-mode t)
(which-key-mode t)
(setq which-key-idle-delay 5.0)
(evilnc-default-hotkeys)
(global-company-mode t)
(setq company-idle-delay t)
(yas-global-mode t)
(spaceline-spacemacs-theme)
(spaceline-toggle-buffer-size-off)
(spaceline-toggle-evil-state-on)
(spaceline-toggle-battery-on)
;; (load-theme 'deeper-blue t)
;; (load-theme 'solarized-gruvbox-dark t)
;; (load-theme 'solarized-wombat-dark t)
(load-theme 'atom-dark t)
;; tips: M-x list-colors-display

;; ******************************** keybinding
;; evil 的 leader
(evil-set-leader 'normal "s" )
(evil-define-key 'normal 'global (kbd "<leader>w") 'save-buffer)
;; 快速注释
(define-key evil-normal-state-map (kbd "<SPC>m") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd "<SPC>m") 'evilnc-comment-or-uncomment-lines)
;; 将 insert state map 中的快捷键清空，使其可以回退（Fallback）到 Emacs State 中
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;; yasnippets 设置代码片段路径及快捷键
(setq yas-snippet-dirs 
      '("~/.emacs.d/snippets"
        "~/.emacs.d/elpa/yasnippet-snippets-20200425.1210/snippets" 
      ))
(define-key evil-insert-state-map (kbd "C-\\") 'yas-expand)
(define-key evil-insert-state-map (kbd "C-j") 'yas-next-field)
(define-key evil-insert-state-map (kbd "C-k") 'yas-prev-field)
;; smex 命令
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; sr-speedbar
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 25)
(setq dframe-update-speed t)
(setq speedbar-use-images nil)
(global-set-key (kbd "<f2>") (lambda()
          (interactive)
          (sr-speedbar-toggle)))
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "M+ 1mn regular-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

;; swiper
(ivy-mode t)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; __________________________________ end of conf

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company which-key yasnippet yasnippet-snippets evil evil-nerd-commenter smex sr-speedbar markdown-mode spaceline monokai-theme solarized-theme atom-dark-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
