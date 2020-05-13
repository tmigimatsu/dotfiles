if exists("b:current_syntax")
  finish
endif

syn match pddlVariable '?\(\w\|[0-9]\|_\|-\)\+'

syn region pddlComment start=/\s*;/ end=/$/

syn keyword pddlBuiltin define and or not problem domain either exists forall
syn keyword pddlBuiltin when assign scale-up scale-down increase decrease start
syn keyword pddlBuiltin end all over minimize maximize total-time

syn match pddlKeyword ':\(requirements\|types\|constants\|predicates\|action\|durative-action\|domain\|parameters\|effect\|precondition\|objects\|init\|goal\|functions\|duration\|condition\|derived\|metric\|axiom\|context\|vars\|implies\)'

syn match pddlUses ':\(strips\|typing\|equality\|adl\|fluents\)'
syn match pddlUses ':\(disjunctive\|negative\|existential\|universal\|quantified\)\-preconditions'
syn match pddlUses ':\(durative\-actions\|derived\-predicates\|domain-axioms\|conditional-effects\|timed\-initial\-literals\)'

syn match pddlType ' - '

" syn match pddlKeyword ':\(requirements\|types\|constants\|predicates\|action\|durative-action\|domain\|parameters\|effect\|precondition\|objects\|init\|goal\|functions\|duration\|condition\|derived\|metric\)'

let b:current_syntax = "pddl"
highlight def link pddlBuiltin Function
highlight def link pddlKeyword Keyword
highlight def link pddlUses Constant 
highlight def link pddlVariable Type
highlight def link pddlComment Comment 
highlight def link pddlType Operator
