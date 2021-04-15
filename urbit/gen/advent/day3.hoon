:: --- Day 3: Toboggan Trajectory ---
::
/*  puzzle-input  %txt  /lib/advent/day3/txt
::
:-  %say
|=  *
=<  [%noun part-two]
|%
++  found-tree
  |=  [index=@ =tape block=@]
  ^-  ?
  ~&  [(snag (mod index block) tape) tape]
  =((snag (mod index block) tape) '#')
::
++  part-one
  =|  col=@
  =|  trees=@
  |-  ^-  @ud
  ?~  puzzle-input  trees
  =*  entry  i.puzzle-input
  %_  $
    col          (add col 3)
    trees        ?:  (found-tree col (trip entry) (lent (trip entry)))
                   +(trees)
                 trees
    puzzle-input  t.puzzle-input
  ==
::
++  part-two
  =|  col=@
  =|  trees=@
  |^
  =;  counts=(list @)
    ~&  counts
    (roll counts mul)
  %+  turn  slopes
  |=  [right=@ down=@]
  =|  row=@
  |-  ^-  @ud
  ?~  puzzle-input  trees
  =/  entry  (trip i.puzzle-input)
  =/  skip=?  (skip-entry row down)
  %_    $
    col           ?:(skip col (add col right))
    row           +(row)
    puzzle-input  t.puzzle-input
  ::
      trees
    ?:  skip
      trees
    ?:  (found-tree col entry (lent entry))
      +(trees)
    trees
  ==
  ::
  ++  skip-entry
    |=  [row=@ down=@]
    !=((mod row down) 0)
  ::
  ++  slopes
    ^-  (list [@ @])
    ~[slope-1 slope-2 slope-3 slope-4 slope-5]
  ++  slope-1  [1 1]
  ++  slope-2  [3 1]
  ++  slope-3  [5 1]
  ++  slope-4  [7 1]
  ++  slope-5  [1 2]
  --
--
