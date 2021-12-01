:: --- Day 8: Handheld Halting ---
::
/*  puzzle-input  %txt  /lib/advent-2020/day8/txt
=/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  parse-program
  ^-  (list [tape @s])
  %-  flop
  %+  roll  puzzle-input
  |=  [entry=cord program=(list [tape @s])]
  =+  int=(trip entry)
  :_  program
  :-  (scag 3 int)
  %+  new:si
    =('-' (snag 4 int))
  (rash (crip (slag 5 int)) dem)
::
++  execute-program
  |=  prog=(list [op=tape num=@s])
  ^-  [loops=? acc=@]
  =/  full-prog  prog
  =|  i=@s
  =|  acc=@s
  =|  seen=(set @s)
  =;  [loops=? acc=@s]
    [loops (abs:si acc)]
  |-
  ?:  (~(has in seen) i)  [& acc]
  ?~  prog  [| acc]
  =*  int  i.prog
  =/  jump-int=@s
    %+  sum:si  i
    ?.(=(op.int "jmp") -1 num.int)
  %_  $
    i     jump-int
    seen  (~(put in seen) i)
    acc   ?:(=(op.int "acc") (sum:si acc num.int) acc)
    prog  ?.  =(op.int "jmp")
            t.prog
          (slag (abs:si jump-int) full-prog)
  ==
::
++  switch
  |=  =tape
  ?:(=(tape "jmp") "nop" "jmp")
::
++  part-one
  (execute-program parse-program)
::
++  part-two
  =/  prog=(list [op=tape num=@s])
    parse-program
  =|  terminates=?
  =|  i=@
  =|  acc=@
  |-  ^-  @
  ?~  prog  acc
  =*  int  i.prog
  ?.  |(=(op.int "jmp") =(op.int "nop"))
    $(prog t.prog, i +(i))
  =;  [loops=? acc=@s]
    ?.  loops
        acc
    $(prog t.prog, i +(i))
  %-  execute-program
  %+  weld
    (scag i parse-program)
  [[(switch op.int) num.int] (slag +(i) parse-program)]
--
