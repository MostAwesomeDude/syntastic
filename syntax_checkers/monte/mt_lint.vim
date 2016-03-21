"============================================================================
"File:        mt_lint.vim
"Description: Syntax checking plugin for syntastic.vim
"Authors:     Corbin Simpson <cds at corbinsimpson dot com>
"
"============================================================================

if exists('g:loaded_syntastic_monte_mt_lint_checker')
    finish
endif
let g:loaded_syntastic_monte_mt_lint_checker = 1

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_monte_mt_lint_IsAvailable() dict
    return 1 "return executable(self.getExec())
endfunction

function! SyntaxCheckers_monte_mt_lint_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'exe': 'mt',
        \ 'args': 'lint' })

    " Irritating, but we must drop some stuff on the floor here.
    let errorformat =
        \ '%f:%l.%v-%\\d%\\+.%\\d%\\+: %m'

    let env = syntastic#util#isRunningWindows() ? {} : { 'TERM': 'dumb' }

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'env': env })

    return loclist
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'monte',
    \ 'name': 'mt_lint' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
