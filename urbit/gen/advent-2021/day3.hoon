:: --- Day 3: Binary Diagnostic ---
::
/*  puzzle-input  %txt  /lib/advent-2021/day3/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  common
  |=  n=(list @t)
  ^-  [gamma=@t epsilon=@t]
  |^
  =<  [n-a n-b]
  ^-  [[n-a=@t @] [n-b=@t @]]
  =;  acc=(map @t @)
    :-  (head (sort ~(tap by acc) gamma))
    (head (sort ~(tap by acc) epsilon))
  %+  roll  n
  |=  [a=@t acc=(map @t @)]
  %+  ~(put by acc)  a
  ?~  el=(~(get by acc) a)
    1
  +(u.el)
  ::
  ++  gamma
    |=([[* v-a=@] [* v-b=@]] (gth v-a v-b))
  ::
  ++  epsilon
    |=([[* v-a=@] [* v-b=@]] (lth v-a v-b))
  --
::
++  part-one
  ^-  @
  ::
  =/  bits=(jar @ @t)
    %+  roll  puzzle-input
    |=  [line=@t bits=(jar @ @t)]
    =+  line=(trip line)
    %+  roll  (gulf 0 (dec (lent line)))
    |=  [col=@ bits=_bits]
    (~(add ja bits) col (snag col line))
  =/  rates=(map @ [g=@t e=@t])
    %+  roll  ~(tap by bits)
    |=  [[col=@ bins=(list @t)] rates=(map @ [g=@t e=@t])]
    (~(put by rates) col (common bins))
  =;  [g-r=tape e-r=tape]
    %-  mul
    :-  (rash (crip (flop g-r)) bin)
    (rash (crip (flop e-r)) bin)
  %+  roll  (sort ~(tap by rates) |=([[a=@ *] [b=@ *]] (lth a b)))
  |=  [[index=@ [g=@t e=@t]] g-r=tape e-r=tape]
  [g g-r]^[e [e-r]]
::
++  part-two  ~
--
