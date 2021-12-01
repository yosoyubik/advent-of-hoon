:: --- Day 2: Password Philosophy ---
::
/*  puzzle-input  %txt  /lib/advent-2020/day2/txt
::
:-  %say
|=  *
=<  [%noun part-two]
|%
++  part-one
  ::  day2 is a wain (i.e. (list cord))
  ::
  =|  valid=@
  |-  ^-  @ud
  |^
  ?~  puzzle-input  valid
  =*  entry  i.puzzle-input
  =/  [[min=@ max=@] char=@t passwd=tape]
    (split-entry (trip entry))
  =?  valid  (comply min max char passwd)
    +(valid)
  $(puzzle-input t.puzzle-input)
  ::
  ++  comply
    |=  [min=@ max=@ char=@t passwd=tape]
    ^-  ?
    =/  count=@
      %-  lent
      %+  skim  (scan passwd (star ;~(pose (just char) (cold ~ aln))))
      |=(a=?(@t ~) =(a char))
    &((gte count min) (lte count max))
  --
::
++  part-two
  ::  day2 is a wain (i.e. (list cord))
  ::
  =|  valid=@
  |-  ^-  @ud
  |^
  ?~  puzzle-input  valid
  =*  entry  i.puzzle-input
  =/  [[min=@ max=@] char=@t passwd=tape]
    (split-entry (trip entry))
  =?  valid  (comply min max char passwd)
    +(valid)
  $(puzzle-input t.puzzle-input)
  ::
  ++  comply
    |=  [min=@ max=@ char=@t passwd=tape]
    ^-  ?
    =-  =(- 1)
    %+  mix
      =((snag (sub min 1) passwd) char)
    =((snag (sub max 1) passwd) char)
  --
::
  ++  split-entry
    |=  entry=tape
    ^-  [[@ @] @t tape]
    =/  result=(list tape)
      (scan entry (more ace (star ;~(less ace next))))
    ?>  ?=([range=* rule=* passwd=* ~] result)
    :+  =-  [(scan -< dem) (scan ->- dem)]
        (scan i.result (more hep (star ;~(less hep next))))
      (scan i.t.result ;~(sfix aln (just ':')))
    i.t.t.result
--
