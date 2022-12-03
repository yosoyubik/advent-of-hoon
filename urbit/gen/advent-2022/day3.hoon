:: --- Day 3: Rucksack Reorganization ---
::
/*  puzzle-input  %txt  /lib/advent-2022/day3/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  to-set  ~(gas in *(set @t))
::
++  part-one
  %+  roll  puzzle-input
  |=  [line=@t prior=@]
  =+  line=(trip line)
  =+  len=(lent line)
  =/  [a=(set @t) b=(set @t)]
    :-  (to-set (scag (div len 2) line))
    (to-set (slag (div len 2) line))
  (totals (~(int in a) b) prior)
::
++  totals
  |=  [s=(set @t) prior=@]
  %+  roll  ~(tap in s)
  |=([c=@t p=_prior] (add p (convert c)))
::
++  convert
  |=  a=@t
  ^-  @
  %-  add
  ?:  &((gte a 'a') (lte a 'z'))
    1^(sub a 'a')
  ?.  &((gte a 'A') (lte a 'Z'))  !!
  27^(sub a 'A')
::
++  part-two
  =<  prior
  %+  roll  puzzle-input
  |=  [line=@t l=@ c=@ sets=(set @t) prior=@]
  =?  prior  =(c 3)  (totals sets prior)
  =?  sets   =(c 3)  ~
  =?     c   =(c 3)  0
  ::
  =+  set=(to-set (trip line))
  =.  sets  ?:(=(sets ~) set (~(int in sets) set))
  :^  +(l)  +(c)  sets
  ?.  =(l (dec (lent puzzle-input)))
    prior
  (totals sets prior)  :: last line
--
