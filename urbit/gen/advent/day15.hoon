::
/*  puzzle-input  %txt  /lib/advent/day15/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 (part-one 2.020)] [%2 (part-two-roll 30.000.000)]]
|%
++  part-one
  |=  max=@
  =/  numbers=(list @)
    ?>  ?=(^ puzzle-input)
    (rash i.puzzle-input (more com dem))
  =/  spoken=(map @ [last=@ rece=@])
    %+  roll  numbers
    |=  [a=@ s=(map @ [@ @])]
    (~(put by s) [a [~(wyt by s) ~(wyt by s)]])
  =.  numbers  (flop numbers)
  ?>  ?=(^ numbers)
  =/  last  i.numbers
  =+  turn=(lent numbers)
  |-  ^-  @
  ?:  =(turn max)  last
  =+  has-spoken=(~(get by spoken) last)
  =/  new=@
    ::  first turn
    ::
    ?:  =(turn (lent numbers))  0
    ?~  has-spoken  0
    (sub last.u.has-spoken rece.u.has-spoken)
  =+  new-spoken=(~(get by spoken) new)
  %_  $
    last    new
    turn    +(turn)
    spoken  %+  ~(put by spoken)  new
            :-  turn
            ?~  new-spoken
              turn
            last.u.new-spoken
  ==
::
++  part-two
  ::
  ::  Crash!
  ::  (Uses more than Urbit's 2Gb...)
  ::
  |=  max=@
  =/  numbers=(list @)
    ?>  ?=(^ puzzle-input)
    (rash i.puzzle-input (more com dem))
  =/  spoken=(map @ @)
    %+  roll  numbers
    |=  [a=@ s=(map @ @)]
    (~(put by s) [a ~(wyt by s)])
  =.  numbers  (flop numbers)
  ~&  numbers+numbers
  ?>  ?=(^ numbers)
  =/  last  i.numbers
  =+  turn=(lent numbers)
  |-  ^-  @
  ?:  =(turn max)  last
  =+  has-spoken=(~(get by spoken) last)
  =/  new=@
    ::  first turn
    ::
    ?:  =(turn (lent numbers))  0
    ?~(has-spoken 0 (sub (sub turn u.has-spoken) 1))
  =+  new-spoken=(~(get by spoken) new)
  %_  $
    last    new
    turn    +(turn)
    spoken  %+  ~(put by spoken)  new
            ?~  new-spoken
              turn
            u.new-spoken
  ==
::
++  part-two-roll
  ::  vey slow... but works!
  ::
  |=  max=@
  =/  numbers=(list @)
    ?>  ?=(^ puzzle-input)
    (rash i.puzzle-input (more com dem))
  =/  spoken=(map @ [last=@ rece=@])
    %+  roll  numbers
    |=  [a=@ s=(map @ [@ @])]
    (~(put by s) [a [~(wyt by s) ~(wyt by s)]])
  =.  numbers  (flop numbers)
  =+  init=(lent numbers)
  ?>  ?=(^ numbers)
  =+  last=i.numbers
  =+  chunk-size=(div (sub (sub max 1) init) 4)
  =<  last
  ::  split in four chunks, cause gulf'ing 30M crashes...
  ::
  %+  roll  (gulf 0 5)
  |=  $:  iter=@
          init-chunk=_init
          last=@
          spoken=_spoken
      ==
  ?:  (gth init-chunk (sub max 1))
    ~&  "done"
    [init-chunk last spoken]
  =+  next-chunk=(add (mul iter chunk-size) chunk-size)
  =?  next-chunk  (gth next-chunk (sub max 1))
    (sub max 1)
  ~&  [i=init-chunk j=next-chunk]
  :-  +(next-chunk)
  ::
  %+  roll  (gulf init-chunk next-chunk)
  |=  [turn=@ last=_last spoken=_spoken]
  =+  has-spoken=(~(get by spoken) last)
  =/  new=@
    ::  first turn
    ::
    ?:  =(turn (lent numbers))  0
    ?~  has-spoken  0
    (sub last.u.has-spoken rece.u.has-spoken)
  =+  new-spoken=(~(get by spoken) new)
  :-  new
  %+  ~(put by spoken)  new
  :-  turn
  ?~  new-spoken
    turn
  last.u.new-spoken
--
