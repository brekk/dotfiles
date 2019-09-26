execute pathogen#infect()

syntax on

let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" nnoremap <c-z> <nop>
map <C-z> :NERDTreeToggle<CR>

set nu
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set nosmartindent
set ic
set cursorline
set undofile

" FZF
set rtp+=/usr/local/opt/fzf

" turn off dumb typescript errors in valid JS files
let g:ale_linters = {'javascript': ['eslint']}

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('js', 'red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('spec.js', 'green', 'none', 'green', '#151515')

" map ,ic :s/^////g<CR>:let @/ = ""<CR>
" ,rc doesn't work reliably here:
" map ,rc :s/^////g<CR>:let @/ = ""<CR>
" so we use vim-commentary

" for vim-commentary
autocmd FileType js setlocal commentstring=//\ %s
" for .md as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" for syntax highlighting in fenced markdown
let g:markdown_fenced_languages = ['html', 'bash=sh', 'js=javascript']

" for vim-prettier
" let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.scss,*.json,*.graphql,*.vue Prettier
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.ts PrettierAsync

" how annoying
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'
" always|never|preserve
" let g:prettier#config#prose_wrap = 'preserve'
filetype plugin indent on

function! PeelRange(file) range
  let peel = a:firstline.",".a:lastline."w ".a:file
  let core = a:firstline.",".a:lastline."d"
  exec peel
  exec core
  echo "peeling and coring"
endfunction

command! -nargs=1 -range=% Peel :<line1>,<line2>call PeelRange(<f-args>)
":1,100Peel src/newfile.js

function! GraftRange(file) range
  let graft = a:firstline.",".a:lastline."w>> ".a:file
  let extortion = a:firstline.",".a:lastline."d"
  exec graft
  exec extortion
  echo "grafting and extorting"
endfunction

command! -nargs=1 -range=% Graft :<line1>,<line2>call GraftRange(<f-args>)
":1,100Graft src/existingfile.js

"function! PeelRange(file) range
"  exec a:firstline . ',' . a:lastline . 'w ' . a:file 
"  exec a:firstline . ',' . a:lastline . 'd'
"endfunction

"command -nargs=1 -range=% Peel :<line1>,<line2>call PeelRange(<f-args>)
"":1,100Peel src/newfile.js

"function! GraftRange(file) range
"  exec a:firstline . ',' . a:lastline . 'w>> ' . a:file 
"  exec a:firstline . ',' . a:lastline . 'd'
"endfunction


"command -nargs=1 -range=% Graft :<line1>,<line2>call GraftRange(<f-args>)
"":1,100Graft src/existingfile.js

function! Log(text)
  call append('.', "console.log(" . a:text . ");")
  call append('.', "// tslint:disable-next-line")
  " :.-1s/\v^((\s*).*$\n)/\1\2a:text\r/
endfunction

" log hook
" nnoremap log :<C-u>call Log()<CR>


" " vim-javascript
" augroup javascript_folding
"     au!
"     au FileType javascript setlocal foldmethod=syntax
" augroup END

" add JSDoc generation support
nnoremap jsd :<C-u>call JSDocAdd()<CR>

" set foldmethod=syntax
" set foldcolumn=1
" let javaScript_fold=1
" set foldlevelstart=99

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)

" <Leader>f{char} to move to {char}
map  <Leader>w <Plug>(easymotion-bd-w)

" tsuquoyomi => TS support
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
" learn you some haskell
let g:brittany_on_save = 1
" autocmd BufWritePre *.hs Brittany
" map <silent> tw :GhcModTypeInsert<CR>
" map <silent> ts :GhcModSplitFunCase<CR>
" map <silent> tq :GhcModType<CR>
" map <silent> te :GhcModTypeClear<CR>

autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)

set backspace=indent,eol,start

hi! RainbowLevel0 ctermbg=none guibg=#444444
hi! RainbowLevel1 ctermbg=239 guibg=#383838
hi! RainbowLevel2 ctermbg=238 guibg=#333333
hi! RainbowLevel3 ctermbg=237 guibg=#282828
hi! RainbowLevel4 ctermbg=236 guibg=#222222
hi! RainbowLevel5 ctermbg=235 guibg=#181818
hi! RainbowLevel6 ctermbg=234 guibg=#111111
hi! RainbowLevel7 ctermbg=233 guibg=#080808
hi! RainbowLevel8 ctermbg=232 guibg=#000000

" Creating a mapping to turn it on and off:
map <leader>l :RainbowLevelsToggle<cr>

" Or automatically turning it on for certain file types:
au FileType javascript,json,yaml :RainbowLevelsOn

" ###### CoC is a terrible name but it's dope af

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" cock-yankers
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>

" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

" Init jest in current cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')

" ###### lightline
function! LightlineFilename()
  " let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let root = fnamemodify(get(b:, 'gitbranch_path'), ':h:h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'fugitive#head',
      \   'filename': 'LightlineFilename'
      \ },
      \ }
set laststatus=2


