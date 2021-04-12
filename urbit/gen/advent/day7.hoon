/*  puzzle-input  %txt  /lib/advent/day7/txt
=/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  parse
  |*  [t=tape func=_|=((list [@ @t tape]) (list))]
  =+  sep=(fand "contain" t)
  :-  (scag (sub -:sep 1) t)
  =+  bags=(slag (add -:(fand "contain" t) (lent "contain ")) t)
  ?^  (find "no other bags." bags)  ~
  %-  func
  ^-  (list [num=@ @t bag=tape])
  %+  scan
    bags
  ;~  sfix
      %+  most
        ;~(plug com ace)
      ;~(plug dem ace (star ;~(pose aln ace)))
      dot
  ==
::
++  has-shiny
  |=  bags=(list tape)
  ^-  ?
  ?|  .?((find ~["shiny gold bags"] bags))
      .?((find ~["shiny gold bag"] bags))
  ==
::
++  create-dict
  ^-  (map tape (list tape))
  %+  roll  puzzle-input
  |=  [entry=cord dict=(map tape (list tape))]
  ^+  dict
  %-  ~(put by dict)
  %+  parse  (trip entry)
  |=  bags=(list [num=@ @t bag=tape])
  ^-  (list tape)
  %+  turn   bags
  |=  [@ @t b=tape]
  =/  i=(unit @)  (find "bag" b)
  ?~(i b (weld (scag u.i b) "bags"))
::
++  part-one
  =/  directs=(map tape (list tape))
    create-dict
  %+  roll  ~(tap by directs)
  |=  [[bag=tape bags=(list tape)] total=@]
  =;  found=?
    ?:(found +(total) total)
  |-  ^-  ?
  ?:  (has-shiny bags)
    &
  ?~  bags  |
  ?|  $(bags t.bags)
      $(bags (~(get by directs) i.bags))
  ==
::
++  part-two
  =/  directs=(map tape (list [@ tape]))
    %+  roll  puzzle-input
    |=  [entry=cord dict=(map tape (list [@ tape]))]
    ^+  dict
    %-  ~(put by dict)
    =;  parse-bags=$-((list [num=@ @t b=tape]) (list [@ tape]))
      (parse (trip entry) parse-bags)
    |=  bags=(list [num=@ @t bag=tape])
    %+  turn   bags
    |=  [num=@ @t b=tape]
    =/  i=(unit @)  (find "bag" b)
    :-  num
    ?~(i b (weld (scag u.i b) "bags"))
  =/  bags=(list [num=@ bags=tape])
    (~(got by directs) "shiny gold bags")
  =|  total=@
  |-  ^-  @
  ?~  bags  0
  ;:  add
    $(bags t.bags)
    num.i.bags
    (mul num.i.bags $(bags (~(got by directs) bags.i.bags)))
  ==
--
