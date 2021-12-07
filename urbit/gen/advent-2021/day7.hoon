:: --- Day 7: The Treachery of Whales ---
::
/*  puzzle-input   %txt  /lib/advent-2021/day7/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  parse-input
  (rash (head puzzle-input) (more com dem))
::
++  begin
  |=  increment=$-([@ @] @)
  =/  crabs=(list @)  (sort parse-input gth)
  =+  min=(rear crabs)
  =+  max=(head crabs)
  =|  outcomes=(list @)
  =;  outcomes=(map crab=@ count=@)
    %-  head
    (sort ~(val by outcomes) lth)
  %+  roll  (gulf min max)
  |=  [goal=@ outcomes=(map goal=@ count=@)]
  %+  ~(put by outcomes)
    goal
  (count goal crabs increment)
  ::
++  count
  |=  [goal=@ crabs=(list @) inc=$-([@ @] @)]
  |-  ^-  @
  =*  count  $
  ?~  crabs  0
  =*  i  i.crabs
  %+  add  (inc i goal)
  ~+(count(crabs t.crabs))
::
++  increment-1
  |=  [a=@ b=@]
  ^-  @
  %-  abs:si
  (dif:si (new:si | a) (new:si | b))
::
++  increment-2
  |=  [a=@ b=@]
  ^-  @
  =/  step=@
    %-  abs:si
    (dif:si (new:si | a) (new:si | b))
  (div (mul step +(step)) 2)
::
++  part-one  (begin increment-1)
++  part-two  (begin increment-2)
--
