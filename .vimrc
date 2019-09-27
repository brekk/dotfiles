" pathogen = git x vim = plugins
execute pathogen#infect()
" oh syntax, oh yes
syntax on

" add haskell?
let $PATH = $PATH . ':' . expand('~/.cabal/bin')

" nnoremap <c-z> <nop>
" map <C-z> :NERDTreeToggle<CR>

" show line numbers
set nu
" 2 spaces over tabs
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set nosmartindent
" ignore case
set ic
" show a highlight under the cursor line
set cursorline
" we use lightline
set noshowmode
" set undofile

" FZF
set rtp+=/usr/local/opt/fzf

" turn off dumb typescript errors in valid JS files
let g:ale_linters = {'javascript': ['eslint']}

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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.scss,*.json,*.graphql,*.vue PrettierAsync

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
" filetype plugin indent on

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
set foldcolumn=1
let javaScript_fold=1
set foldlevelstart=99

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)

" <Leader>f{char} to move to {char}
map  <Leader>w <Plug>(easymotion-bd-w)

" learn you some haskell
let g:brittany_on_save = 1
" autocmd BufWritePre *.hs Brittany
" map <silent> tw :GhcModTypeInsert<CR>
" map <silent> ts :GhcModSplitFunCase<CR>
" map <silent> tq :GhcModType<CR>
" map <silent> te :GhcModTypeClear<CR>

set backspace=indent,eol,start

" RAINBOW LEVELS

" this setting means if everything is a tacit function,
" only closured stuff is darkened!
hi! RainbowLevel0 ctermbg=none guibg=#444444
hi! RainbowLevel1 ctermbg=232 guibg=#383838
hi! RainbowLevel2 ctermbg=233 guibg=#333333
hi! RainbowLevel3 ctermbg=234 guibg=#282828
hi! RainbowLevel4 ctermbg=235 guibg=#222222
hi! RainbowLevel5 ctermbg=236 guibg=#181818
hi! RainbowLevel6 ctermbg=237 guibg=#111111
hi! RainbowLevel7 ctermbg=238 guibg=#080808
hi! RainbowLevel8 ctermbg=239 guibg=#000000

" Creating a mapping to turn it on and off:
map <leader>l :RainbowLevelsToggle<cr>

" Or automatically turning it on for certain file types:
au FileType javascript,json,yaml :RainbowLevelsOn

" ###### CoC is a terrible name but it's dope af

" better display for messages
set cmdheight=2
" ?
" set updatetime=300
" don't give |ins-completion-menu| messages
set shortmess+=c
" always show sign columns
set signcolumn=yes

" keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup cocstuff 
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocActionAsync('fold', <f-args>)

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
command! -nargs=0 Jest :call  CocActionAsync('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocActionAsync('runCommand', 'jest.fileTest', ['%'])

" Run jest for current test
nnoremap <leader>te :call CocActionAsync('runCommand', 'jest.singleTest')<CR>

" Init jest in current cwd, require global jest command exists
command! JestInit :call CocActionAsync('runCommand', 'jest.init')

" ###### lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \ },
      \ }
set laststatus=2

" QUICK FIX
au FileType qf call AdjustWindowHeight(2, 20)
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$') && line('$') >= a:maxheight && n_lines is >= a:maxheight
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

