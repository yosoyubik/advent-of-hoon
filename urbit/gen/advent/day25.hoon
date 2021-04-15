:: --- Day 25: Combo Breaker ---
::
/*  puzzle-input  %txt  /lib/advent/day25/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =/  [card-pub=@ door-pub=@]  get-rfids
  =/  loop-size=@  (door-loop-size door-pub)
  ~&  door-loop-size+loop-size
  (transform loop-size card-pub)
::
++  transform
  |=  [loop=@ card=@]
  ~&  loop+loop
  |-  ^-  @
  %+  roll  (gulf 1 loop)
  |=  [* code=_1]
  (mod (mul code card) 20.201.227)
::
++  door-loop-size
  |=  door=@
  =|  loop=@
  =+  check=1
  |-  ^-  @
  ?:  =(check door)  loop
  %_  $
    loop  +(loop)
    check  (mod (mul check 7) 20.201.227)
  ==
::
++  part-two  ~
::
++  get-rfids
  ^-  [card=@ door=@]
  :-  (rash (snag 0 puzzle-input) dem)
  (rash (snag 1 puzzle-input) dem)
--
