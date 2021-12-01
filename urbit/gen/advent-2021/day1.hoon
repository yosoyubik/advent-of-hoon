:: --- Day 1: Sonar Sweep ---
::
/*  puzzle-input  %txt   /lib/advent-2021/day1/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  part-one
  %+  roll  puzzle-input
  |=  [line=@t current=@ incs=@]
  =+  parsed=(rash line dem)
  :-  parsed
  ?:  =(current 0)  incs
  ?.((gth parsed current) incs +(incs))
::
++  part-two
  %+  roll  puzzle-input
  |=  [line=@t i=@ window=[a=@ b=@ c=@] prev-sum=@ incs=@]
  =+  parsed=(rash line dem)
  =+  window-i=(mod i 3)
  =?  a.window  =(0 window-i)  parsed
  =?  b.window  =(1 window-i)  parsed
  =?  c.window  =(2 window-i)  parsed
  ?:  (lth i 3)  [+(i) window prev-sum incs]
  =,  window
  =/  sum   :(add a b c)
  =?  incs  (gth sum prev-sum)  +(incs)
  [+(i) window sum incs]
--
