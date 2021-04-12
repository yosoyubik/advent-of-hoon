/*  puzzle-input  %txt  /lib/advent/day6/txt
=/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  %+  roll  puzzle-input
  |=  [entry=cord i=@ group-yes=(set @t) total-yes=@]
  ^-  [@ (set @t) @]
  =/  reduced=(set @t)
    %-  ~(gas in group-yes)
    (scan (trip entry) (star aln))
  :+  +(i)
    ?:(=('' entry) ~ reduced)
  ?.  |(=(max i) =('' entry))
    total-yes
  (add total-yes ~(wyt in reduced))
::
++  part-two
  %+  roll  puzzle-input
  |=  [entry=cord i=@ group-yes=(list (set @t)) total-yes=@]
  =/  reduced=(set @t)
    %-  ~(gas in *(set @t))
    (scan (trip entry) (star aln))
  :+  +(i)
    ?:(=('' entry) ~ [reduced group-yes])
  ?.  |(=(max i) =('' entry))
    total-yes
  =;  intersect=[@ set=(set @t)]
    (add total-yes ~(wyt in set.intersect))
  %+  roll  ?.(=(max i) group-yes [reduced group-yes])
  |=  [s=(set @t) [i=@ t=(set @t)]]
  :-   +(i)
  ?:  =(i 0)  s
  (~(int in s) ^-((set @t) t))
--
