" Vim syntax file
" Language:	Python
" Maintainer:	Zvezdan Petkovic <zpetkovic@acm.org>
" Last Change:	2016 Oct 29
" Credits:	Neil Schemenauer <nas@python.ca>
"		Dmitry Vasiliev
"
"		This version is a major rewrite by Zvezdan Petkovic.
"
"		- introduced highlighting of doctests
"		- updated keywords, built-ins, and exceptions
"		- corrected regular expressions for
"
"		  * functions
"		  * decorators
"		  * strings
"		  * escapes
"		  * numbers
"		  * space error
"
"		- corrected synchronization
"		- more highlighting is ON by default, except
"		- space error highlighting is OFF by default
"
" Optional highlighting can be controlled using these variables.
"
"   let python_no_builtin_highlight = 1
"   let python_no_doctest_code_highlight = 1
"   let python_no_doctest_highlight = 1
"   let python_no_exception_highlight = 1
"   let python_no_number_highlight = 1
"   let python_space_error_highlight = 1
"
" All the options above can be switched on together.
"
"   let python_highlight_all = 1
"

" quit when a syntax file was already loaded.
if exists("b:current_syntax")
  finish
endif

" We need nocompatible mode in order to continue lines with backslashes.
" Original setting will be restored.
let s:cpo_save = &cpo
set cpo&vim

if exists("python_no_doctest_highlight")
  let python_no_doctest_code_highlight = 1
endif

if exists("python_highlight_all")
  if exists("python_no_builtin_highlight")
    unlet python_no_builtin_highlight
  endif
  if exists("python_no_doctest_code_highlight")
    unlet python_no_doctest_code_highlight
  endif
  if exists("python_no_doctest_highlight")
    unlet python_no_doctest_highlight
  endif
  if exists("python_no_exception_highlight")
    unlet python_no_exception_highlight
  endif
  if exists("python_no_number_highlight")
    unlet python_no_number_highlight
  endif
  let python_space_error_highlight = 1
endif

" Keep Python keywords in alphabetical order inside groups for easy
" comparison with the table in the 'Python Language Reference'
" http://docs.python.org/reference/lexical_analysis.html#keywords.
" Groups are in the order presented in NAMING CONVENTIONS in syntax.txt.
" Exceptions come last at the end of each group (class and def below).
"
" Keywords 'with' and 'as' are new in Python 2.6
" (use 'from __future__ import with_statement' in Python 2.5).
"
" Some compromises had to be made to support both Python 3.0 and 2.6.
" We include Python 3.0 features, but when a definition is duplicated,
" the last definition takes precedence.
"
" - 'False', 'None', and 'True' are keywords in Python 3.0 but they are
"   built-ins in 2.6 and will be highlighted as built-ins below.
" - 'exec' is a built-in in Python 3.0 and will be highlighted as
"   built-in below.
" - 'nonlocal' is a keyword in Python 3.0 and will be highlighted.
" - 'print' is a built-in in Python 3.0 and will be highlighted as
"   built-in below (use 'from __future__ import print_function' in 2.6)
"
syn keyword pythonBoolean	False None True
syn keyword pythonStatement	as assert break continue del exec global
syn keyword pythonStatement	lambda nonlocal pass print return with yield async await
syn keyword pythonConditional	elif else if
syn keyword pythonRepeat	for while
syn keyword pythonOperator	and in is not or
syn keyword pythonException	except finally raise try
syn keyword pythonInclude	from import

syn match   pythonOperator	"[\-\+\*\/\=\<\>\!\|\&]"
syn match   pythonNumber	"-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"

syn match pythonFuncCall "\<\I\i*\((\)\@="
syn match PythonFuncCallKwarg "[(,]\s*\I\i*\s*=" contains=PythonKwarg,pythonOperator
syn match PythonKwarg "\I\i*" contained
syn match PythonConstant "\<[A-Z_][A-Z0-9_]*\>"

" Classes
syn region  pythonClass start="^\s*class\s" end=":" contains=pythonClassDef,pythonClassName,pythonSuperclasses
syn keyword pythonClassDef class contained nextgroup=pythonClassName
syn match   pythonClassName	"[a-zA-Z_][a-zA-Z0-9_]*" display contained nextgroup=pythonSuperclasses skipwhite
syn region  pythonSuperclasses start="("ms=e+1 end=")"me=s-1 keepend contained contains=pythonSuperclass transparent
syn match   pythonSuperclass "[a-zA-Z_][a-zA-Z_0-9]*" contained

" Decorators (new in Python 2.4)
" syn match   pythonDecorator	"@" display nextgroup=pythonFunction skipwhite
syn match   pythonDecorator	"@" display contained
syn match   pythonDecoratorName	"@\s*\h\%(\w\|\.\)*" display contains=pythonDecorator

" Functions
syn region  pythonFunc              start="\<def\>" end=")\s*:" keepend contains=pythonFuncDef,pythonFuncParams
syn keyword pythonFuncDef           def contained nextgroup=pythonObjectMethod,pythonFuncName skipwhite
syn match   pythonFuncName          "[a-zA-Z_][a-zA-Z0-9_]*" display contained nextgroup=pythonFuncParams skipwhite
syn region  pythonFuncParams        start="("ms=e+1 end=")\s*:"me=s-1 contained transparent contains=pythonParam
syn region  pythonParam             start="[a-zA-Z_]" end="\(,\|)\s*:\)"me=s-1 contained contains=pythonParamName,pythonDefaultAssignment transparent nextgroup=pythonParam
syn match   pythonParamName         "[a-zA-Z_][a-zA-Z0-9_]*" contained nextgroup=pythonDefaultAssignment skipwhite skipnl
syn region  pythonDefaultAssignment start="=" end="\(,\_s\+\|)\s*:\)"me=s-1 contained contains=pythonBoolean,pythonNumber,pythonOperator,pythonBuiltin,pythonString skipwhite contained skipnl
" syn match   pythonParamEquals       "=" contained skipwhite skipnl

syn keyword pythonIdentifier    self
syn match   pythonComment       "#.*$" contains=pythonTodo,@Spell
syn keyword pythonTodo          FIXME NOTE NOTES TODO XXX contained

" Triple-quoted strings can contain doctests.
syn region  pythonString
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=pythonEscape,@Spell
syn region  pythonString
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonEscape,pythonSpaceError,pythonDoctest,@Spell
syn region  pythonRawString
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@Spell
syn region  pythonRawString
      \ start=+[uU]\=[rR]\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonSpaceError,pythonDoctest,@Spell

syn match   pythonEscape	+\\[abfnrtv'"\\]+ contained
syn match   pythonEscape	"\\\o\{1,3}" contained
syn match   pythonEscape	"\\x\x\{2}" contained
syn match   pythonEscape	"\%(\\u\x\{4}\|\\U\x\{8}\)" contained
" Python allows case-insensitive Unicode IDs: http://www.unicode.org/charts/
syn match   pythonEscape	"\\N{\a\+\%(\s\a\+\)*}" contained
syn match   pythonEscape	"\\$"

" It is very important to understand all details before changing the
" regular expressions below or their order.
" The word boundaries are *not* the floating-point number boundaries
" because of a possible leading or trailing decimal point.
" The expressions below ensure that all valid number literals are
" highlighted, and invalid number literals are not.  For example,
"
" - a decimal point in '4.' at the end of a line is highlighted,
" - a second dot in 1.0.0 is not highlighted,
" - 08 is not highlighted,
" - 08e0 or 08j are highlighted,
"
" and so on, as specified in the 'Python Language Reference'.
" http://docs.python.org/reference/lexical_analysis.html#numeric-literals
if !exists("python_no_number_highlight")
  " numbers (including longs and complex)
  syn match   pythonNumber	"\<0[oO]\=\o\+[Ll]\=\>"
  syn match   pythonNumber	"\<0[xX]\x\+[Ll]\=\>"
  syn match   pythonNumber	"\<0[bB][01]\+[Ll]\=\>"
  syn match   pythonNumber	"\<\%([1-9]\d*\|0\)[Ll]\=\>"
  syn match   pythonNumber	"\<\d\+[jJ]\>"
  syn match   pythonNumber	"\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
  syn match   pythonNumber
	\ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
  syn match   pythonNumber
	\ "\%(^\|\W\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"
endif

" Group the built-ins in the order in the 'Python Library Reference' for
" easier comparison.
" http://docs.python.org/library/constants.html
" http://docs.python.org/library/functions.html
" http://docs.python.org/library/functions.html#non-essential-built-in-functions
" Python built-in functions are in alphabetical order.
if !exists("python_no_builtin_highlight")
  " built-in constants
  " 'False', 'True', and 'None' are also reserved words in Python 3.0
  " syn keyword pythonBuiltin	False True None
  syn keyword pythonBuiltin	NotImplemented Ellipsis
  syn keyword pythonObjectMethod     __debug__ __doc__ __file__ __name__ __package__
  syn keyword pythonObjectMethod     __loader__ __spec__ __path__ __cached__
  syn keyword pythonObjectMethod     __new__ __init__ __del__ __repr__ __str__ __bytes__ __format__
  syn keyword pythonObjectMethod     __lt__ __le__ __eq__ __ne__ __gt__ __ge__
  syn keyword pythonObjectMethod     __hash__ __bool__
  syn keyword pythonObjectMethod     __getattr__ __getattribute__ __setattr__ __delattr__ __dir__
  syn keyword pythonObjectMethod     __get__ __set__ __delete__ __set_name__
  syn keyword pythonObjectMethod     __slots__
  syn keyword pythonObjectMethod     __init_subclass__
  syn keyword pythonObjectMethod     __instancecheck__ __subclasscheck__
  syn keyword pythonObjectMethod     __class_getitem__
  syn keyword pythonObjectMethod     __call__
  syn keyword pythonObjectMethod     __len__ __length_hint__ __getitem__ __setitem__ __delitem__
  syn keyword pythonObjectMethod     __missing__ __iter__ __reversed__ __contains__
  syn keyword pythonObjectMethod     __add__ __sub__ __mul__ __matmul__ __truediv__
  syn keyword pythonObjectMethod     __floordiv__ __mod__ __divmod__ __pow__ __lshift__ __rshift__
  syn keyword pythonObjectMethod     __and__ __xor__ __or__
  syn keyword pythonObjectMethod     __radd__ __rsub__ __rmul__ __rmatmul__ __rtruediv__
  syn keyword pythonObjectMethod     __rfloordiv__ __rmod__ __rdivmod__ __rpow__ __rlshift__ __rrshift__
  syn keyword pythonObjectMethod     __rand__ __rxor__ __ror__
  syn keyword pythonObjectMethod     __iadd__ __isub__ __imul__ __imatmul__ __itruediv__
  syn keyword pythonObjectMethod     __ifloordiv__ __imod__ __idivmod__ __ipow__ __ilshift__ __irshift__
  syn keyword pythonObjectMethod     __iand__ __ixor__ __ior__
  syn keyword pythonObjectMethod     __neg__ __pos__ __abs__ __invert__ __complex__ __int__ __float__
  syn keyword pythonObjectMethod     __index__ __round__ __trunc__ __floor__ __ceil__
  syn keyword pythonObjectMethod     __enter__ __exit__
  syn keyword pythonObjectMethod     __await__
  syn keyword pythonObjectMethod     __aiter__ __anext__ __aenter__ __aexit__

  " built-in functions
  syn keyword pythonBuiltin	abs all any bin bool callable chr classmethod
  syn keyword pythonBuiltin	compile complex delattr dir divmod
  syn keyword pythonBuiltin	enumerate eval filter format
  syn keyword pythonBuiltin	getattr globals hasattr hash
  syn keyword pythonBuiltin	help hex id input isinstance
  syn keyword pythonBuiltin	issubclass iter len locals map max
  syn keyword pythonBuiltin	min next oct open ord pow print
  syn keyword pythonBuiltin	range repr reversed round
  syn keyword pythonBuiltin	setattr sorted staticmethod
  syn keyword pythonBuiltin	sum super tuple vars zip __import__
  syn keyword pythonBuiltinClass dict float frozenset int list object property set slice str type
  " Python 2.6 only
  syn keyword pythonBuiltin	basestring cmp execfile file
  syn keyword pythonBuiltin	long raw_input reduce reload unichr
  syn keyword pythonBuiltin	unicode xrange
  " Python 3.0 only
  syn keyword pythonBuiltin	ascii exec memoryview
  syn keyword pythonBuiltinClass bytearray bytes 
  " non-essential built-in functions; Python 2.6 only
  syn keyword pythonBuiltin	apply buffer coerce intern
endif

" From the 'Python Library Reference' class hierarchy at the bottom.
" http://docs.python.org/library/exceptions.html
if !exists("python_no_exception_highlight")
  " builtin base exceptions (used mostly as base classes for other exceptions)
  syn keyword pythonExceptions	BaseException Exception
  syn keyword pythonExceptions	ArithmeticError BufferError
  syn keyword pythonExceptions	LookupError
  " builtin base exceptions removed in Python 3
  syn keyword pythonExceptions	EnvironmentError StandardError
  " builtin exceptions (actually raised)
  syn keyword pythonExceptions	AssertionError AttributeError
  syn keyword pythonExceptions	EOFError FloatingPointError GeneratorExit
  syn keyword pythonExceptions	ImportError IndentationError
  syn keyword pythonExceptions	IndexError KeyError KeyboardInterrupt
  syn keyword pythonExceptions	MemoryError NameError NotImplementedError
  syn keyword pythonExceptions	OSError OverflowError ReferenceError
  syn keyword pythonExceptions	RuntimeError StopIteration SyntaxError
  syn keyword pythonExceptions	SystemError SystemExit TabError TypeError
  syn keyword pythonExceptions	UnboundLocalError UnicodeError
  syn keyword pythonExceptions	UnicodeDecodeError UnicodeEncodeError
  syn keyword pythonExceptions	UnicodeTranslateError ValueError
  syn keyword pythonExceptions	ZeroDivisionError
  " builtin OS exceptions in Python 3
  syn keyword pythonExceptions	BlockingIOError BrokenPipeError
  syn keyword pythonExceptions	ChildProcessError ConnectionAbortedError
  syn keyword pythonExceptions	ConnectionError ConnectionRefusedError
  syn keyword pythonExceptions	ConnectionResetError FileExistsError
  syn keyword pythonExceptions	FileNotFoundError InterruptedError
  syn keyword pythonExceptions	IsADirectoryError NotADirectoryError
  syn keyword pythonExceptions	PermissionError ProcessLookupError
  syn keyword pythonExceptions	RecursionError StopAsyncIteration
  syn keyword pythonExceptions	TimeoutError
  " builtin exceptions deprecated/removed in Python 3
  syn keyword pythonExceptions	IOError VMSError WindowsError
  " builtin warnings
  syn keyword pythonExceptions	BytesWarning DeprecationWarning FutureWarning
  syn keyword pythonExceptions	ImportWarning PendingDeprecationWarning
  syn keyword pythonExceptions	RuntimeWarning SyntaxWarning UnicodeWarning
  syn keyword pythonExceptions	UserWarning Warning
  " builtin warnings in Python 3
  syn keyword pythonExceptions	ResourceWarning
endif

if exists("python_space_error_highlight")
  " trailing whitespace
  syn match   pythonSpaceError	display excludenl "\s\+$"
  " mixed tabs and spaces
  syn match   pythonSpaceError	display " \+\t"
  syn match   pythonSpaceError	display "\t\+ "
endif

" Do not spell doctests inside strings.
" Notice that the end of a string, either ''', or """, will end the contained
" doctest too.  Thus, we do *not* need to have it as an end pattern.
if !exists("python_no_doctest_highlight")
  if !exists("python_no_doctest_code_higlight")
    syn region pythonDoctest
	  \ start="^\s*>>>\s" end="^\s*$"
	  \ contained contains=ALLBUT,pythonDoctest,@Spell
    syn region pythonDoctestValue
	  \ start=+^\s*\%(>>>\s\|\.\.\.\s\|"""\|'''\)\@!\S\++ end="$"
	  \ contained
  else
    syn region pythonDoctest
	  \ start="^\s*>>>" end="^\s*$"
	  \ contained contains=@NoSpell
  endif
endif

" Sync at the beginning of class, function, or method definition.
syn sync match pythonSync grouphere NONE "^\s*\%(def\|class\)\s\+\h\w*\s*("

if version >= 508 || !exists("did_python_syn_inits")
  if version <= 508
    let did_python_syn_inits = 1
    command! -nargs=+ HiLink hi link <args>
  else
    command! -nargs=+ HiLink hi def link <args>
  endif

  " The default highlight links.  Can be overridden later.
  HiLink pythonBoolean          Boolean
  HiLink pythonStatement	Statement
  HiLink pythonConditional	Conditional
  HiLink pythonRepeat		Repeat
  HiLink pythonOperator		Operator
  HiLink pythonException	Exception
  HiLink pythonInclude		Include
  HiLink pythonDecorator	Statement
  HiLink pythonDecoratorName	Define
  HiLink pythonClassName	Function
  HiLink pythonSuperclass	Function
  HiLink pythonFuncName		Function
  HiLink pythonComment		Comment
  HiLink pythonTodo		Todo
  HiLink pythonString		String
  HiLink pythonRawString	String
  HiLink pythonEscape		Special
  HiLink pythonConstant         Constant
  HiLink pythonFuncCall         FunctionCall
  HiLink pythonKwarg            Parameter
  
  HiLink pythonClassDef		Identifier
  HiLink pythonFuncDef		Identifier
  HiLink pythonIdentifier	Self
  HiLink pythonParamName	Parameter
  HiLink pythonNumber		Number
  if !exists("python_no_number_highlight")
    HiLink pythonNumber		Number
  endif
  if !exists("python_no_builtin_highlight")
    HiLink pythonBuiltin	Function
    HiLink pythonBuiltinClass   Object
    HiLink pythonObjectMethod	FunctionCall
  endif
  if !exists("python_no_exception_highlight")
    HiLink pythonExceptions	Object
  endif
  if exists("python_space_error_highlight")
    HiLink pythonSpaceError	Error
  endif
  if !exists("python_no_doctest_highlight")
    HiLink pythonDoctest	Special
    HiLink pythonDoctestValue	Define
  endif

  delcommand HiLink
endif

let b:current_syntax = "python"

" vim:set sw=2 sts=2 ts=8 noet:
