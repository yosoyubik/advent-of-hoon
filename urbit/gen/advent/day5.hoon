/*  puzzle-input  %txt  /lib/advent/day5/txt
=/  rows  128
=/  cols  8
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =|  count=@
  %+  roll  puzzle-input
  |=  [pass=cord seat-id=@]

  ^-  @
  =/  new-id=@
    %-  get-id
    [row col]:(get-seat (trip pass))
  ?:  (gth new-id seat-id)
    new-id
  seat-id
::
++  get-id
  |=([r=@ c=@] (add (mul r 8) c))
::
++  get-seat
  |=  pass=tape
  ^-  [row=@ col=@]
  =+  r=(scag 7 pass)
  =+  c=(slag 7 pass)
  |^
  :-  i:(parse r [i=0 j=127])
  i:(parse c [i=0 j=8])
  ::
  ++  parse
    |=  [r=tape space=[i=@ j=@]]
    %+  roll  r
    |=  [half=@t rest=_space]
    =+  rest
    ^-  [@ @]
    =/  mid  (div (sub j i) 2)
    ?:  |(=(half 'F') =(half 'L'))
      [i (add mid i)]
    [(sub j mid) j]
  --
::
++  not-in-set
  |=  [seats=(set @) seat=@]
  =((~(has in seats) seat) |)
::
++  in-set
  |=  [seats=(set @) seat=@]
  (~(has in seats) seat)
::
++  possible-seats
    ^-  (set @)
    =-  ~&  possible+~(wyt in -)  -
    %+  roll  (gulf 1 (sub rows 2))
    |=  [row=@ s=(set id=@)]
    %+  roll  (gulf 0 (sub cols 1))
    |=  [col=@ s=_s]
    %-  ~(put in s)
    (add (mul row 8) col)
::
++  part-two
  =/  in-flight=(set @)
    %+  roll  puzzle-input
    |=  [pass=cord s=(set @)]
    =+  (get-seat (trip pass))
    =+  id=(get-id [row col])
    (~(put in s) id)
  =/  remain  (~(dif in possible-seats) in-flight)
  ^-  (set @)
  %-  ~(rep in remain)
  |=  [id=@ s=(set @)]
  ?.  ?&  (in-set in-flight +(id))
          (in-set in-flight (sub id 1))
      ==
    s
  (~(put in s) id)
--
