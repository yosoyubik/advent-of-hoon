/*  puzzle-input  %txt  /lib/advent/day23/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =+  moves=100
  =/  cups=(list @)
    %+  roll  puzzle-input
    |=  [e=@t ans=(list @)]
    (roll (trip e) |=([a=@t ans=_ans] (snoc ans (rash a dem))))
  |-  ^-  tape
  ?~  cups  !!
  ::  current cup is always at the head
  ::
  =*  current  i.cups
  ?:  =(moves 0)
    =;  out=(list @)
      (turn out |=(a=@ (scot %u a)))
    =/  one=@  (need (find ~[1] cups))
    %+  weld
      (slag (add one 1) `(list @)`cups)
    (scag one `(list @)`cups)
  =/  pickup=(list @)  (scag 3 t.cups)
  =/  dest=@   (find-dest (sub current 1) pickup 9)
  =/  first=@  (need (find pickup cups))
  =/  new-cups=(list @)
    %+  weld
      (scag first `(list @)`cups)
    (slag (add first (lent pickup)) `(list @)`cups)
  %_  $
    moves  (sub moves 1)
    cups   =;  new=(list @)
             ::  rotate cup circle 1 position
             ::  so the head has the next current
             ::
             (weld (slag 1 new) (scag 1 new))
           =/  dest-index=@
             (add 1 (need (find ~[dest] new-cups)))
           ;:  weld
               (scag dest-index `(list @)`new-cups)
               pickup
               (slag dest-index `(list @)`new-cups)
  ==       ==
::
++  find-dest
  |=  [dest=@ pickup=(list @) max=@]
  |-  ^-  @
  ?:  =(0 dest)
    $(dest max)
  ?~  (find ~[dest] pickup)
    dest
  $(dest (sub dest 1))
::
++  part-two
  =+  moves=10.000.000
  =/  cups=(map @ @)
    =+  max=1.000.000
    =+  label=10
    =;  init-cups=(map @ @)
      |-  ^+  init-cups
      ?:  =(label max)
        ~&  "done"
        ::  last one will point to the first
        ::
        (~(put by init-cups) max (~(got by init-cups) 0))
      %_  $
        label  +(label)
        init-cups   (~(put by init-cups) label +(label))
      ==
    %+  roll  puzzle-input
    |=  [e=@t ans=(map @ @)]
    =<  cups
    %+  reel  (trip e)
    |=  [a=@t i=@ prev=@ cups=(map @ @)]
    =/  label=@  (rash a dem)
    =?  cups  =(i (sub (lent (trip e)) 1))
      ::  current at i=0
      ::
      (~(put by cups) [0 label])
    :+  +(i)
      label
    ?:  =(i 0)
      ::  last one will point to 10 (max is 9)
      ::
      (~(put by cups) [label 10])
    (~(put by cups) [label prev])
  ::
  =<  ans
  ::  using a normal recusion bail:memes
  ::  |-  ^-  @
  ::  and this is still very slow... but works!
  ::
  %+  reel  (gulf 0 moves)
  |=  [move=@ ans=@ cups=_cups]
  ::  print progress
  ::
  =-  ?.(=(0 (mod move 100.000)) - ~&(moves-left+move -))
  ::  current cup is always at index 0
  ::
  ?:  =(move 0)
    =+  after-1=(~(got by cups) 1)
    =+  after-2=(~(got by cups) after-1)
    :_  cups
    (mul after-1 after-2)
  =/  current=@   (~(got by cups) 0)
  =/  pickup-1=@  (~(got by cups) current)
  =/  pickup-2=@  (~(got by cups) pickup-1)
  =/  pickup-3=@  (~(got by cups) pickup-2)
  =/  dest=@
    (find-dest (sub current 1) ~[pickup-1 pickup-2 pickup-3] 1.000.000)
  =/  after-dest=@   (~(got by cups) dest)
  =/  pickup-next=@   (~(got by cups) pickup-3)
  =.  cups  (~(put by cups) [current pickup-next])
  ::  pickup will point to the one after destination
  ::
  =.  cups  (~(put by cups) [pickup-3 after-dest])
  ::  destination will point to the pickup
  ::
  =.  cups  (~(put by cups) [dest pickup-1])
  :-  0
  ::  update new current
  ::
  (~(put by cups) [0 pickup-next])
--
