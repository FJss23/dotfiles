" fjss23 <fjriedemann@gmail.com>
"
" Modifications for the current colorscheme

" todo: change the color for comments
" todo: add a special color for todo's
hi DiagnosticUnderlineError cterm=undercurl gui=undercurl
hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl
hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl

hi! link netrwMarkFile Search
hi! link Todo diffFileId

hi! link DiagnosticLineNrError DiagnosticError
hi! link DiagnosticLineNrWarn DiagnosticWarn
hi! link DiagnosticLineNrInfo DiagnosticInfo
hi! link DiagnosticLineNrHint DiagnosticHint

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
