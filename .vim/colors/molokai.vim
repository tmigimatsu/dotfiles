  
" Vim color file
"
" Author: Tomas Restrepo <tomas@winterdom.com>
"
" Note: Based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant 
" by Hamish Stuart Macpherson
"

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="molokai"

if exists("g:molokai_original")
    let s:molokai_original = g:molokai_original
else
    let s:molokai_original = 0
endif

	" *Comment	any comment

	" *Constant	any constant
	"  String		a string constant: "this is a string"
	"  Character	a character constant: 'c', '\n'
	"  Number		a number constant: 234, 0xff
	"  Boolean	a boolean constant: TRUE, false
	"  Float		a floating point constant: 2.3e10

	" *Identifier	any variable name
	"  Function	function name (also: methods for classes)

	" *Statement	any statement
	"  Conditional	if, then, else, endif, switch, etc.
	"  Repeat		for, do, while, etc.
	"  Label		case, default, etc.
	"  Operator	"sizeof", "+", "*", etc.
	"  Keyword	any other keyword
	"  Exception	try, catch, throw

	" *PreProc	generic Preprocessor
	"  Include	preprocessor #include
	"  Define		preprocessor #define
	"  Macro		same as Define
	"  PreCondit	preprocessor #if, #else, #endif, etc.

	" *Type		int, long, char, etc.
	"  StorageClass	static, register, volatile, etc.
	"  Structure	struct, union, enum, etc.
	"  Typedef	A typedef

	" *Special	any special symbol
	"  SpecialChar	special character in a constant
	"  Tag		you can use CTRL-] on this
	"  Delimiter	character that needs attention
	"  SpecialComment	special things inside a comment
	"  Debug		debugging statements

	" *Underlined	text that stands out, HTML links

	" *Ignore		left blank, hidden  |hl-Ignore|

	" *Error		any erroneous construct

	" *Todo		anything that needs extra attention; mostly the
	"         keywords TODO FIXME and XXX


hi Cursor          guifg=#ffffff guibg=#455354
hi iCursor         guifg=#ffffff guibg=#455354
hi Search          guifg=#ffffff guibg=#455354

hi Debug           guifg=#BCA3A3               gui=bold cterm=bold
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange                    guibg=#1c1c1c
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4c4745 gui=italic,bold,underline cterm=italic,bold,underline

"red":"#fc618d",
" Red #F92672
hi Conditional     guifg=#f92672
hi Keyword         guifg=#f92672               gui=bold cterm=bold
hi Operator        guifg=#f92672
hi Repeat          guifg=#f92672
hi SpecialChar     guifg=#f92672               gui=bold cterm=bold
hi Statement       guifg=#f92672
hi StorageClass    guifg=#f92672
hi Tag             guifg=#f92672               gui=italic cterm=italic
hi GitGutterDelete guifg=#f92672 guibg=#080808
hi ErrorMsg        guifg=#f92672 guibg=#000000 gui=bold cterm=bold
hi Error           guifg=#f92672 guibg=#000000 gui=italic,bold,undercurl cterm=italic,bold,underline

"orange":"#fd9353",
" Orange #FD971F
hi Self            guifg=#fd971f               gui=italic cterm=italic
hi MatchParen      guifg=#000000 guibg=#fd971f gui=bold cterm=bold
hi Parameter       guifg=#fd971f               gui=italic cterm=italic
hi CursorLineNr    guifg=#fd971f               gui=none cterm=none

"yellow":"#fce566","#e6eb74"
" Yellow #E6DB74
hi Character       guifg=#e6eb74
hi Label           guifg=#e6eb74               gui=bold cterm=bold
hi ModeMsg         guifg=#e6eb74
hi MoreMsg         guifg=#e6eb74
hi String          guifg=#e6eb74

"green":"#7bd88f",
" Green #A6E22E
hi Directory       guifg=#a6e22e               gui=bold cterm=bold
hi Exception       guifg=#a6e22e               gui=bold cterm=bold
hi Function        guifg=#a6e22e
hi Object          guifg=#a6e22e               gui=italic cterm=italic
hi Include         guifg=#a6e22e
hi PreCondit       guifg=#a6e22e               gui=bold cterm=bold
hi PreProc         guifg=#a6e22e
hi Macro           guifg=#a6e22e               gui=bold cterm=bold
hi GitGutterAdd    guifg=#a6e22e guibg=#080808

"blue":"#5ad4e6",
" Blue #66D9EF
hi Define          guifg=#66d9ef
hi Identifier      guifg=#66d9ef               gui=italic cterm=italic
hi FunctionCall    guifg=#66d9ef
hi SpecialKey      guifg=#66d9ef               gui=italic
hi Structure       guifg=#66d9ef
hi Typedef         guifg=#66d9ef
hi Type            guifg=#66d9ef               gui=italic cterm=italic
hi Pmenu           guifg=#66d9ef guibg=#080808
hi PmenuThumb      guifg=#66d9ef

"purple":"#948ae3",
" Purple #AE81FF
hi Boolean         guifg=#ae81ff
hi Constant        guifg=#ae81ff
hi Float           guifg=#ae81ff
hi Number          guifg=#ae81ff

hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

" Gray
hi ColorColumn                   guibg=#080808 ctermbg=none
" hi ColorColumn                   guibg=NONE ctermbg=none
hi Comment         guifg=#808080
hi LineNr          guifg=#808080 guibg=#080808
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi VertSplit       guifg=#404040 guibg=#080808 gui=none cterm=none
hi SignColumn      guifg=#A6E22E guibg=#000000
hi GitGutterChange       guifg=#808080 guibg=#080808 gui=bold cterm=bold
hi GitGutterChangeDelete guifg=#808080 guibg=#080808 gui=bold cterm=bold

"black":"#222222",
"white":"#f7f1ff",
" White
hi Normal          guifg=#f7f1ff guibg=#000000 ctermbg=none
" hi Normal          guifg=#f7f1ff guibg=NONE ctermbg=none

hi Question        guifg=#66D9EF
" marks
hi SpecialComment  guifg=#7E8E91               gui=bold cterm=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic cterm=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold cterm=bold

hi Underlined      guifg=#808080               gui=underline

hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold cterm=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none

if s:molokai_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E
   hi CursorLine                    guibg=#3E3D32 cterm=none
   hi CursorColumn                  guibg=#3E3D32
   hi ColorColumn                   guibg=#3B3A32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#75715E
   hi SpecialKey      guifg=#75715E
   hi String          guifg=#E6DB74
else
   " hi Comment         guifg=#7E8E91
   hi CursorLine                    guibg=#1c1c1c cterm=none
   hi CursorColumn                  guibg=#1c1c1c
   " hi LineNr          guifg=#bcbcbc guibg=#1c1c1c
   hi NonText         guifg=#465457
   hi SpecialKey      guifg=#465457
   " hi String          guifg=#FFFF87
end

"
" Support for 256-color terminal
"
" if &t_Co > 255
"    if s:molokai_original == 1
"       hi Normal                   ctermbg=234
"       hi CursorLine               ctermbg=235   cterm=none
"       hi CursorLineNr ctermfg=208               cterm=none
"    else
"       hi Normal       ctermfg=252 ctermbg=none
"       hi CursorLine               ctermbg=234   cterm=none
"       hi CursorLineNr ctermfg=208               cterm=none
"    endif
"    hi Boolean         ctermfg=135
"    hi Character       ctermfg=144
"    hi Number          ctermfg=135
"    hi String          ctermfg=228
"    hi Conditional     ctermfg=161
"    hi Constant        ctermfg=135               cterm=bold
"    hi Cursor          ctermfg=16  ctermbg=253
"    hi Debug           ctermfg=225               cterm=bold
"    hi Define          ctermfg=81
"    hi Delimiter       ctermfg=241

"    hi DiffAdd                     ctermbg=24
"    hi DiffChange      ctermfg=181 ctermbg=239
"    hi DiffDelete      ctermfg=162 ctermbg=53
"    hi DiffText                    ctermbg=102   cterm=bold

"    hi Directory       ctermfg=118               cterm=bold
"    hi Error           ctermfg=219 ctermbg=89
"    hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
"    hi Exception       ctermfg=118               cterm=bold
"    hi Float           ctermfg=135
"    hi FoldColumn      ctermfg=67  ctermbg=16
"    hi Folded          ctermfg=67  ctermbg=16
"    hi Function        ctermfg=118
"    hi Identifier      ctermfg=81                cterm=italic
"    hi Ignore          ctermfg=244 ctermbg=232
"    hi IncSearch       ctermfg=193 ctermbg=16	cterm=bold

"    hi Keyword         ctermfg=161               cterm=bold
"    hi Label           ctermfg=229               cterm=none
"    hi Macro           ctermfg=193
"    hi SpecialKey      ctermfg=81

"    hi MatchParen      ctermfg=208 ctermbg=NONE  cterm=underline
"    hi ModeMsg         ctermfg=229
"    hi MoreMsg         ctermfg=229
"    hi Operator        ctermfg=161               cterm=bold

"    " complete menu
"    hi Pmenu           ctermfg=81  ctermbg=16
"    hi PmenuSel        ctermfg=81  ctermbg=244
"    hi PmenuSbar                   ctermbg=232
"    hi PmenuThumb      ctermfg=81

"    hi PreCondit       ctermfg=118               cterm=bold
"    hi PreProc         ctermfg=118
"    hi Question        ctermfg=81
"    hi Repeat          ctermfg=161               cterm=bold
"    hi Search          ctermfg=15  ctermbg=66	cterm=bold

"    " marks column
"    hi SignColumn      ctermfg=118 ctermbg=235
"    hi SpecialChar     ctermfg=161               cterm=bold
"    hi SpecialComment  ctermfg=245               cterm=bold
"    hi Special         ctermfg=81
"    if has("spell")
"        hi SpellBad                ctermbg=52
"        hi SpellCap                ctermbg=17
"        hi SpellLocal              ctermbg=17
"        hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
"    endif
"    hi Statement       ctermfg=161
"    hi StatusLine      ctermfg=238 ctermbg=253
"    hi StatusLineNC    ctermfg=244 ctermbg=232
"    hi StorageClass    ctermfg=208
"    hi Structure       ctermfg=81
"    hi Tag             ctermfg=161
"    hi Title           ctermfg=166
"    hi Todo            ctermfg=231 ctermbg=232   cterm=bold

"    hi Typedef         ctermfg=81
"    hi Type            ctermfg=81                cterm=none
"    hi Underlined      ctermfg=244               cterm=underline

"    hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
"    hi VisualNOS                   ctermbg=238
"    hi Visual                      ctermbg=235
"    hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
"    hi WildMenu        ctermfg=81  ctermbg=16

"    hi Comment         ctermfg=59
"    hi CursorColumn                ctermbg=234
"    hi ColorColumn                 ctermbg=232
"    hi LineNr          ctermfg=250 ctermbg=234
"    hi NonText         ctermfg=59

"    hi SpecialKey      ctermfg=234

"    hi Parameter       ctermfg=208

"    if exists("g:rehash256") && g:rehash256 == 1
"        hi Normal       ctermfg=252 ctermbg=234
"        hi CursorLine               ctermbg=236   cterm=none
"        hi CursorLineNr ctermfg=208               cterm=none

"        hi Boolean         ctermfg=141
"        hi Character       ctermfg=222
"        hi Number          ctermfg=141
"        hi String          ctermfg=222
"        hi Conditional     ctermfg=197               cterm=bold
"        hi Constant        ctermfg=141               cterm=bold

"        hi DiffDelete      ctermfg=125 ctermbg=233

"        hi Directory       ctermfg=154               cterm=bold
"        hi Error           ctermfg=125 ctermbg=233
"        hi Exception       ctermfg=154               cterm=bold
"        hi Float           ctermfg=141
"        hi Function        ctermfg=154
"        hi Identifier      ctermfg=208

"        hi Keyword         ctermfg=197               cterm=bold
"        hi Operator        ctermfg=197
"        hi PreCondit       ctermfg=154               cterm=bold
"        hi PreProc         ctermfg=154
"        hi Repeat          ctermfg=197               cterm=bold

"        hi Statement       ctermfg=197               cterm=bold
"        hi Tag             ctermfg=197
"        hi Title           ctermfg=203
"        hi Visual                      ctermbg=238

"        hi Comment         ctermfg=244
"        hi LineNr          ctermfg=239 ctermbg=235
"        hi NonText         ctermfg=239
"        hi SpecialKey      ctermfg=239
"    endif
" end
