:: --- Day 16: Ticket Translation ---
::
/*  puzzle-input  %txt  /lib/advent/day16/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =|  e-rate=@
  =|  gaps=@
  =|  rules=(map tape [@ [@ @] [@ @]])
  |-  ^-  @
  ?~  puzzle-input  e-rate
  =*  line  i.puzzle-input
  ?:  =('' line)  $(puzzle-input t.puzzle-input, gaps +(gaps))
  ?:  =(gaps 0)
    %_    $
        puzzle-input  t.puzzle-input
    ::
        rules
      (~(put by rules) (parse-rule line))
    ==
  ?:  =(gaps 1)  $(puzzle-input t.puzzle-input)
  ?:  =('nearby tickets:' line)  $(puzzle-input t.puzzle-input)
  =+  ticket=(rash line (more com dem))
  %_  $
    e-rate        (add (check-ticket ticket rules) e-rate)
    puzzle-input  t.puzzle-input
  ==
::
++  check-ticket
  |=  [t=(list @) rules=(map tape [@ [@ @] [@ @]])]
  ^-  @
  =+  ranges=~(val by rules)
  %+  roll  t
  |=  [value=@ non-valid=@]
  ?:  (check-value value ranges)
    non-valid
  (add value non-valid)
::
++  check-value
  |=  [v=@ ranges=(list [@ [@ @] [@ @]])]
  %+  lien  ranges
  |=  [@ [l-a=@ r-a=@] [l-b=@ r-b=@]]
  ?|  &((gte v l-a) (lte v r-a))
      &((gte v l-b) (lte v r-b))
  ==
::
++  parse-rule
  |=  r=cord
  ^-  [tape [@ [@ @] [@ @]]]
  =<  [class *@ [rmin-a rmax-a] [rmin-b rmax-b]]
  ::  FIXME: this is terrible
  ::
  ^-  $:  class=tape  @  @
          rmin-a=@  @  rmax-a=@
          @  @  @
          rmin-b=@  @  rmax-b=@
      ==
  %+  rash  r
  ;~  plug
      (star ;~(pose alf ace))
      col  ace   dem  hep  dem  ace  (jest 'or')  ace  dem  hep  dem
  ==
::
++  part-two
  =/  [rules=(map tape [@ [@ @] [@ @]]) positions=(map @ (list @)) my-ticket=(list @)]
    parse-input
  =/  fields=(list tape)  (flop ~(tap in ~(key by rules)))
  |^
  =/  possibles=(map tape (list @))  calculate-possibles
  ::  sort possibles by "increasing number of options/permutations"
  ::
  =/  sorted-poss=(list [tape (list @)])
    %+  sort  ~(tap by possibles)
    |=([[* l=(list @)] [* m=(list @)]] (lth (lent l) (lent m)))
  =/  found-rules=(list [field=tape pos=@])
    %~  tap  by
    =<  rules
    %+  roll  sorted-poss
    |=  [[field=tape pos=(list @)] [assigned=(set @) rules=(map tape @)]]
    =/  position
      |-  ^-  @
      ?~  pos  !!
      ?.  (~(has in assigned) i.pos)
        i.pos
      $(pos t.pos)
    :-  (~(put in assigned) position)
    (~(put by rules) field position)
  ::
  =+  rules=6
  =+  val=1
  |-  ^-  @
  ?:  =(rules 0)  val
  ?~  found-rules  !!
  =+  found=(find "departure" field.i.found-rules)
  =/  new=@
    ?~  found
      1
    ~&  field.i.found-rules
    =.  rules  (sub rules 1)
    (snag pos.i.found-rules my-ticket)
  %_  $
    rules        ?~(found rules (sub rules 1))
    found-rules  t.found-rules
    val          (mul val new)
  ==
  ::
  ++  calculate-possibles
    =|  possibles=(map tape (list @))
    |-  ^+  possibles
    ?~  fields  possibles
    =/  rule=[pos=@ r-a=[@ @] r-b=[@ @]]
      (~(got by rules) i.fields)
    ~&  rule
    %_  $
      fields     t.fields
      possibles  (~(put by possibles) [i.fields (check-positions rule)])
    ==
  ::
  ++  check-positions
    |=  [@ [l-a=@ r-a=@] [l-b=@ r-b=@]]
    =/  pos=(list [pos=@ vals=(list @)])
      ~(tap by positions)
    =|  possibles=(list @)
    |-  ^+  possibles
    ?~  pos  possibles
    =*  p   pos.i.pos
    =*  vals  vals.i.pos
    %_    $
        pos  t.pos
    ::
        possibles
      ?.  %+  levy  vals
          |=(v=@ |(&((gte v l-a) (lte v r-a)) &((gte v l-b) (lte v r-b))))
        possibles
      [p possibles]
    ==
  --
::
++  parse-input
  =|  gaps=@
  =|  rules=(map tape [pos=@ r-a=[@ @] r-b=[@ @]])
  =|  tickets=(map @ (list @))
  =|  position=@
  =|  my-ticket=(list @)
  |-  ^+  [rules tickets my-ticket]
  ?~  puzzle-input  [rules tickets my-ticket]
  =*  line  i.puzzle-input
  ?:  =('' line)  $(puzzle-input t.puzzle-input, gaps +(gaps))
  ?:  =(gaps 0)
    %_  $
      puzzle-input  t.puzzle-input
      rules         (~(put by rules) (parse-rule line))
    ==
  ?:  ?|  =('your ticket:' line)
          =('nearby tickets:' line)
      ==
    $(puzzle-input t.puzzle-input)
  ?:  =(gaps 1)
    %_  $
      puzzle-input  t.puzzle-input
      my-ticket     (rash line (more com dem))
    ==
  =+  ticket=(rash line (more com dem))
  %_    $
      puzzle-input
    t.puzzle-input
  ::
      tickets
    ?.  (check-ticket-2 ticket rules)
      tickets
    =<  tickets
    %+  roll  ticket
    |=  [val=@ pos=@ tickets=_tickets]
    =/  current=(unit (list @))
      (~(get by tickets) pos)
    :-  +(pos)
    %+  ~(put by tickets)  pos
    ?~  current
      ~[val]
    [val u.current]
  ==
::
++  check-ticket-2
  |=  [t=(list @) rules=(map tape [@ [@ @] [@ @]])]
  ^-  ?
  =+  ranges=~(val by rules)
  (levy t |=(value=@ (check-value value ranges)))
--
