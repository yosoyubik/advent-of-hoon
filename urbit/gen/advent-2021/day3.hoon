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
++  get-bits-one
  |=  input=(list tape)
  %+  roll  input
  |=  [line=tape bits=(jar @ @t)]
  %+  roll  (gulf 0 (dec (lent line)))
  |=  [col=@ bits=_bits]
  (~(add ja bits) col (snag col line))
::
++  get-bits-two
  |=  input=(list tape)
  =;  bits=(jar @ @t)
    %-  ~(gas by *(jar @ @t))
    %+  turn  ~(tap by bits)
    |=([i=@ l=(list @t)] i^(flop l))
  %+  roll  input
  |=  [line=tape bits=(jar @ @t)]
  %+  roll  (gulf 0 (dec (lent line)))
  |=  [col=@ bits=_bits]
  (~(add ja bits) col (snag col line))
::
++  part-one
  ^-  @
  =/  column-bits=(jar @ @t)  (get-bits-one (turn puzzle-input trip))
  =/  rates=(map @ [g=@t e=@t])
    %+  roll  ~(tap by column-bits)
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
++  puzzle-to-tape
  |=  =wain
  ^-  (list [@ud tape])
  %-  tail
  %+  roll  wain
  |=  [line=@t i=@ud tapes=(list [@ud tape])]
  :-  +(i)
  [[i (trip line)] tapes]
::
++  recalculate-index
  |=  tapes=(list tape)
  ^-  (map @ud tape)
  %-  ~(gas by *(map @ud tape))
  %-  tail
  %+  roll  tapes
  |=  [=tape i=@ud tapes=(list [@ud tape])]
  :-  +(i)
  [[i tape] tapes]
::
++  part-two
  =/  column-bits=(jar col=@ @t)
    (get-bits-two (turn puzzle-input trip))
  ~&  column-bits
  =/  remaining=(map @ud tape)
    %-  ~(gas by *(map @ud tape))
    (puzzle-to-tape puzzle-input)
  =|  life-support=@
  =|  column=@
  |^  =/  [[a=(map @ud tape)] [b=(map @ud tape)]]
        [(calculate %gen) (calculate %scrub)]
      %-  mul
      :-  (rash (crip (head ~(val by a))) bin)
      (rash (crip (head ~(val by b))) bin)
  ::
  ++  calculate
    |=  rate=?(%gen %scrub)
    |-  ^+  remaining
    ?:  =(1 ~(wyt by remaining))
      remaining
    ::
    =/  bits=(list @t)   (~(get ja column-bits) column)
    =/  [ones=@ zeros=@]
      %+  roll  `(list @t)`bits
      |=  [b=@t ones=@ zeros=@]
      ?:(=(b '1') [+(ones) zeros] [ones +(zeros)])
    =/  new-remaining=(list tape)
      =;  r=(map @ud tape)
       %+  turn
         %+  sort  ~(tap by r)
         |=([[a=@ *] [b=@ *]] (lth a b))
       tail
      %-  tail
      %+  roll  `(list @t)`bits
      |=  [bit=@t pos=@ud rem=_remaining]
      :-  +(pos)
      ?:  =(1 ~(wyt by rem))  rem
      ?:  ?=(%gen rate)
        ?:  &(=(bit '0') (gth zeros ones))  rem
        ?:  &(=(bit '1') (gte ones zeros))  rem
        (~(del by rem) pos)
      ::
      ?:  &(=(bit '1') (lth ones zeros))  rem
      ?:  &(=(bit '0') (lte zeros ones))  rem
      (~(del by rem) pos)
   =:  remaining    (recalculate-index new-remaining)
       column-bits  (get-bits-two new-remaining)
   ==
   $(column +(column))
  --
--
