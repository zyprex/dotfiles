" Move me to your own fptlugin/_common and config your personal information.
"
" Here is the place to set personal preferences; "priority=personal" is the
" highest which overrides any other XPTvar setting.
"
" You can also set personal variables with 'g:xptemplate_vars' in your .vimrc.
XPTemplate priority=personal

XPTvar $author zhouyu
XPTvar $email  ...

XPT c) " all right reserved
(c) Copyright `strftime("%Y")^ `$author^. All Rights Reserved.

XPT time " time
`strftime("%Y %b.%d %a %T")^
