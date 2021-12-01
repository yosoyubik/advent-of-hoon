:: --- Day 13: Shuttle Search ---
::
/*  puzzle-input  %txt  /lib/advent-2020/day13/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two-fast]]
|%
++  get-closest
  |=  [init=@ multip=@ goal=@]
  :: ~&  [init multip]
  =|  ans=_init
  |-  ^-  [id=@ time=@]
  ?.  (lth ans goal)
    :: ~&  ans
    [multip ans]
  $(ans (add ans multip))
::
++  check-conditions
  |=  [conditions=(list [id=@ inc=@]) t=@]
  %+  roll  conditions
  |=  [[id=@ inc=@] success=?]
  &(success =(0 (mod (add t inc) id)))
::
++  part-one
  ?>  ?=([cord cord ~] puzzle-input)
  =+  departure=(rash i.puzzle-input dem)
  =/  buses=(list @)
    =;  b=(list @)  (murn b |=(a=@ ?:(=(a 0) ~ (some a))))
    (rash i.t.puzzle-input (more com ;~(pose dem (cold 0 (just 'x')))))
  =<  found
  :-  .
  %+  roll  buses
  |=  [bus=@ i=@ found=@ ans=(list [id=@ time=@])]
  ?.  =(i (sub (lent buses) 1))
    :+  +(i)
      found
    [(get-closest (mul (div departure bus) bus) bus departure) ans]
  :+  i
    =;  [id=@ time=@]
      ^-  @
      ~&  [id time]
      (mul (sub time departure) id)
    =<  -
    %+  sort  [(get-closest (mul (div departure bus) bus) bus departure) ans]
    |=  [[@ time-a=@] [@ time-b=@]]
    (lth time-a time-b)
  ans
::
++  part-two-slow
  :: t mod a = 0,
  :: t+1 mod b = 0,
  :: t+4 mod c = 0,
  :: t+6 mod d = 0,
  :: t+7 mod e = 0
  :: ...
  ?>  ?=([cord cord ~] puzzle-input)
  =/  buses=(list [id=@ inc=@])
    %-  flop
    =<  incs
    %+  roll  (rash i.t.puzzle-input (more com ;~(pose dem (cold 0 (just 'x')))))
    |=  [bus=@ i=@ incs=(list [@ @])]
    :-  +(i)
    ?:  =(bus 0)  incs
    [[bus i] incs]
  ?>  ?=(^ buses)
  =/  first-cond  i.buses
  =/  timestamp  id.i.buses
  |-  ^-  @
  ?:  ?&  =(0 (mod timestamp id.first-cond))
          (check-conditions buses timestamp)
      ==
    timestamp
  $(timestamp (add timestamp id.first-cond))
::
++  part-two-fast
  :: t mod a = 0,
  :: (t + a)+1 mod b = 0,
  :: (t + a * b)+ 4 mod c = 0,
  :: (t + a * b * c) + 6 mod d = 0,
  :: (t + a * b * c + d)+7 mod e = 0
  :: ...
  ?>  ?=([cord cord ~] puzzle-input)
  =/  buses=(list [id=@ inc=@])
    =;  parsed
      %-  flop
      =<  incs
      %+  roll  parsed
      |=  [bus=@ i=@ incs=(list [@ @])]
      :-  +(i)
      ?:  =(bus 0)  incs
      [[bus i] incs]
    (rash i.t.puzzle-input (more com ;~(pose dem (cold 0 (just 'x')))))
  =|  timestamp=@
  =+  modulo=1
  |-  ^-  @
  ?~  buses  timestamp
  =*  bus  i.buses
  ?.  =(0 (mod (add timestamp inc.bus) id.bus))
    $(timestamp (add timestamp modulo))
  $(buses t.buses, modulo (mul modulo id.i.buses))
--
