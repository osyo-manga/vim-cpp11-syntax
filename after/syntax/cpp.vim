" Vim syntax file
" Language:	C++
" Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2002 Jul 15

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/c.vim
else
  runtime! syntax/c.vim
  unlet b:current_syntax
endif

" C++ extentions
syn keyword cppStatement	new delete this friend using
syn keyword cppAccess		public protected private
syn keyword cppType		inline virtual explicit export bool wchar_t
syn keyword cppExceptions	throw try catch
syn keyword cppOperator		operator typeid
syn keyword cppOperator		and bitor or xor compl bitand and_eq or_eq xor_eq not not_eq
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*<"me=e-1
syn match cppCast		"\<\(const\|static\|dynamic\|reinterpret\)_cast\s*$"
syn keyword cppStorageClass	mutable
syn keyword cppStructure	class typename template namespace
syn keyword cppNumber		NPOS
syn keyword cppBoolean		true false

if !exists("cpp_no_cpp0x") " ISO C++11
  syn keyword cppOperator      alignof alignas
  syn keyword cppType          char16_t char32_t decltype
  syn keyword cppStorageClass  constexpr thread_local
  syn keyword cppConstant      nullptr
  syn keyword cppStatement     static_assert noexcept

  syn keyword cppVirtual       override final contained containedin=cppVirtualContext
  syn match   cppVirtualContext	/\<final\_s*[:{]/
  syn match   cppVirtualContext   /\<\(override\|final\|override\_s\+final\|final\_s\+override\)\ze\(\(\_s*=\_s*0\)\=\_s*[,;]\|\_s*\({\|\<try\_s*{\|=\_s*\(default\|delete\)\_s*;\)\)/

  syn region  cppString           start=/\(u8\|u\|U\|L\)\="/ skip=/\\\\\|\\"/ end=/"/ contains=cSpecial,cFormat,@Spell
  syn match   cppRawString        /\%(u8\|u\|U\|L\)\=R"\([[:alnum:]_{}[\]#<>%:;.?*+\-/\^&|~!=,"']\{,16}\)(\_.\{-})\1"/ contains=cSpecial,cFormat,@Spell
  
endif

" The minimum and maximum operators in GNU C++
syn match cppMinMax "[<>]?"

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppAccess		cppStatement
  HiLink cppCast		cppStatement
  HiLink cppExceptions		Exception
  HiLink cppOperator		Operator
  HiLink cppStatement		Statement
  HiLink cppType		Type
  HiLink cppStorageClass	StorageClass
  HiLink cppStructure		Structure
  HiLink cppNumber		Number
  HiLink cppBoolean		Boolean
  HiLink cppConstant		Constant
  HiLink cppVirtual		Statement
  HiLink cppString		String
  HiLink cppRawString		String
  
  delcommand HiLink
endif

let b:current_syntax = "cpp"

" vim: ts=8
