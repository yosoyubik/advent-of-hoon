:: --- Day 14: Docking Data ---
::
/*  puzzle-input  %txt  /lib/advent-2020/day14/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =;  [^ memory=(map @ @)]
    (roll ~(tap by memory) |=([[@ v=@] t=@] (add v t)))
  %+  roll  puzzle-input
  |=  [e=@t [mask=@ub n-mask=@ub] memory=(map @ @)]
  ?~  (find "mask" (trip e))
    :: mem
    =/  [@t mem=@ @t val=@]
      (rash e ;~(plug (jest 'mem[') dem (jest '] = ') dem))
    :: (value OR mask) AND (NOT mask)
    ::
    =+  new-val=(dis (con val mask) n-mask)
    :-  [mask n-mask]
    (~(put by memory) [mem new-val])
  :: mask: "OR with 1s and AND with NOT 0s"
  ::
  :_  memory
  =;  parsed=(list @t)
    [(get-mask parsed) (get-not-mask parsed)]
  (rash e ;~(pfix ;~(plug (jest 'mask =') (star ace)) (star alp)))
::
++  get-mask
  |=  mask=(list @t)
  ^-  @ub
  %+  rep  0
  %-  flop
  %+  turn  mask
  |=  a=@t
  ?:(=(a 'X') 0 (rash a dem))
::
++  get-not-mask
  |=  mask=(list @t)
  ^-  @ub
  %+  rep  0
  %-  flop
  %+  turn  mask
  |=  a=@t
  ?:(=(a 'X') 1 (rash a dem))
::
++  part-two
  =;  [^ memory=(map @ @)]
    :: ~&  memory+memory
    (roll ~(tap by memory) |=([[@ v=@] t=@] (add v t)))
  %+  roll  puzzle-input
  |=  [e=@t [mask=@ub f-mask=(list (list [$-([@ @] @) @]))] memory=(map @ @)]
  ?~  (find "mask" (trip e))
    :: mem
    =/  [@t mem=@ @t val=@]
      (rash e ;~(plug (jest 'mem[') dem (jest '] = ') dem))
    :: (value OR mask) AND (apply list of masks
    ::
    =+  first-pass=(con mem mask)
    :-  [mask f-mask]
    (apply-floats first-pass val memory f-mask)
  :: mask: "OR with 1s and AND with NOT 0s"
  ::
  :_  memory
  =;  parsed=(list @t)
    :: ~&  parsed
    [(get-mask parsed) (get-float-masks parsed)]
  (rash e ;~(pfix ;~(plug (jest 'mask =') (star ace)) (star alp)))
::
++  apply-floats
  |=  [b=@ val=@ memory=(map @ @) f-mask=(list (list [$-([@ @] @) @]))]
  |-  ^+  memory
  ?~  f-mask  memory
  =;  mem=@
    :: ~&  mem+mem
    $(memory (~(put by memory) [mem val]), f-mask t.f-mask)
  %+  roll  i.f-mask
  |=  [[f=$-([@ @] @) m=@] val=@]
  ^-  @
  :: ~&  `@ub`m
  ?:  =(val 0)
    (f m b)
  (f m val)
::
++  expand-binary
  |=  [bin=@ length=@]
  ^-  (list @)
  =+  b=(flop (rip 0 bin))
  ?:  =((lent b) length)  b
  %+  roll  (gulf 1 (sub length (lent b)))
  |=([pos=@ expanded=_b] [0 expanded])
::
++  get-float-masks
  |=  mask=(list @t)
  ^-  (list (list [$-([@ @] @) @]))
  %+  roll  (gulf 0 (sub (pow 2 (lent (fand "X" mask))) 1))
  |=  [i=@ floats=(list (list [$-([@ @] @) @]))]
  =+  index=(fand "X" mask)
  =/  dissa=(list @)  (expand-binary i (lent index))
    :: ?.  |(=(i 0) =(i 1))
    ::   (flop (rip 0 i))
    :: ?:  =(i 0)
    ::   (turn (trip (fil 3 (lent index) '0')) |=(a=@t (rash a dem)))
    :: %+  snoc
    ::   (turn (trip (fil 3 (sub (lent index) 1) '0')) |=(a=@t (rash a dem)))
    :: 1
  ::  ~[1 3 4]
  :_  floats
  =<  f
  %+  roll  index
  |=  [pos=@ bit=@ f=(list [$-([@ @] @) @])]
  :-  +(bit)
  :_  f
  =+  mask=(pow 2 (sub 35 pos))
  ?:  =((snag bit dissa) 1)
    [con mask]
  [dis (not 0 36 mask)]
--
