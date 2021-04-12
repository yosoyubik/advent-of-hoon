::
/*  puzzle-input  %txt  /lib/advent/day20/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  parse-grid
  %+  roll  puzzle-input
  |=  [e=cord id=@ row=@ tiles=(map @ (list tape))]
  ?:  =('' e)  [id 0 tiles]
  ::  e.g: Tile 3593:
  ::
  =+  n-id=(rush e ;~(pfix (jest 'Tile ') ;~(sfix dem col)))
  =+  line=(trip e)
  ?^  n-id
    [u.n-id 0 tiles]
  :+  id
    +(row)
  =+  tile=(~(get by tiles) id)
  ?~  tile
    (~(put by tiles) id [line]~)
  (~(put by tiles) id (snoc u.tile line))
::
++  permutate
  |=  tiles=(map @ (list tape))
  =|  out=(map @ (set wall))
  ^+  out
  %+  roll  ~(tap by tiles)
  |=  [tile=[id=@ =wall] out=_out]
  =<  out
  |^
  ::  2 flips
  ::
  %+  roll  (gulf 0 1)
  |=  [@ tile=_tile out=_out]
  =;  [tile=_tile out=_out]
    (include [id.tile (flip wall.tile 9 9)] out)
  ::  4 rotations
  ::
  %+  roll  (gulf 0 3)
  |=  [@ tile=_tile out=_out]
  (include [id.tile (rotate wall.tile 9 9)] out)
  ::
  ++  include
    |=  [tile=_tile out=_out]
    ^+  +<
    :-  tile
    =+  exists=(~(get by out) id.tile)
    %+  ~(put by out)  id.tile
    ?~  exists
      (sy ~[wall.tile])
    (~(put in u.exists) wall.tile)
  --
::
++  flip
  |=  [tiles=(list tape) w=@ h=@]
  ^-  (list tape)
  %+  roll  (gulf 0 h)
  |=  [row=@ new-tile=(list tape)]
  %+  snoc
    new-tile
  ::
  %+  reel  (gulf 0 w)
  |=  [col=@ new-row=tape]
  %+  snoc
    new-row
  (snag col (snag row `(list tape)`tiles))
::  rotate: 90 degrees to the right
::
++  rotate
  |=  [tiles=(list tape) w=@ h=@]
  ^-  (list tape)
  %+  roll  (gulf 0 w)
  |=  [col=@ new-tiles=(list tape)]
  %+  snoc
    new-tiles
  ::
  %+  reel  (gulf 0 h)
  |=  [row=@ new-row=tape]
  %+  snoc
    new-row
  (snag col (snag row `(list tape)`tiles))
::
++  align
  =/  tiles=(map @ (set wall))
    ::  precomputes all 8 permutations of each tile
    ::
    (permutate tiles:parse-grid)
  =/  grid-size=@
    p:(sqt ~(wyt by tiles))
  =/  done=?  %.n
  =|  ans=@
  =|  visited=(set id=@)
  =|  grid=(map row=@ (map col=@ [id=@ tile=wall]))
  ::  index for the tiles in the final grid
  ::
  =|  [row=@ col=@]
  ::  backtracking!
  ::
  |-  ^+  [done out=ans visited water=grid]
  =*  search  $
  ?:  done  [done ans visited grid]
  ?:  =(row grid-size)
    ::  the end!
    ::
    =/  product=@
      %+  roll  ~(tap by grid)
      |=  [[r=@ row=(map col=@ [id=@ *])] product=@]
      %+  roll  ~(tap by row)
      |=  [[c=@ [id=@ *]] product=_product]
      ::  print tile ids
      ::
      :: ~&  [[r c] id]
      ?.  ?|  =([r c] [0 0])
              =([r c] [(dec grid-size) (dec grid-size)])
              =([r c] [0 (dec grid-size)])
              =([r c] [(dec grid-size) 0])
          ==
        product
      ?:  =(product 0)
        id
      (mul product id)
    [%.y product visited grid]
  ^+  [done ans visited grid]
  ::  loop over 8*N tiles
  ::
  %+  roll  ~(tap by tiles)
  |=  [[id=@ all=(set wall)] done=_done ans=_ans visited=_visited grid=_grid]
  %+  roll  ~(tap in all)
  |=  [tile=wall done=_done ans=_ans visited=_visited grid=_grid]
  ::
  ?:  (~(has in visited) id)
    ::  skip
    ::
    [done ans visited grid]
  ::  compare current tile with one above, and one to the right
  ::
  |^
  ?:  |((cant-bellow row col tile) (cant-right row col tile))
      ::  skip
      ::
      [done ans visited grid]
  ::  match!
  ::
  =/  old-col
    (~(get by grid) row)
  =/  new-col
    ?~  old-col
      (my [col [id tile]]~)
    (~(put by u.old-col) [col [id tile]])
  =/  grid
    (~(put by grid) [row new-col])
  =.  visited
    (~(put in visited) id)
  =;  [done=? product=@ visited=_visited grid=_grid]
    ::  removes current tile from visited
    ::  so other iterations can use it (when =(done %.n) )
    ::
    =+  new-visited=?:(done visited (~(del in visited) id))
    [done product new-visited grid]
  ?:  =(col (dec grid-size))
    search(row +(row), col 0, grid grid, visited visited)
  search(col +(col), grid grid, visited visited)
  ::
  ++  cant-bellow
    |=  [row=@ col=@ tile=wall]
    ^-  ?
    ?.  (gth row 0)  |
    =;  matches=?
      ?:(matches | &)
    %+  match-bellow
      tile
    tile:(~(got by (~(got by grid) (dec row))) col)
  ::
  ++  cant-right
    |=  [row=@ col=@ tile=wall]
    ^-  ?
    ?.  (gth col 0)  |
    =;  matches=?
      ?:(matches | &)
    %+  match-right
      tile
    tile:(~(got by (~(got by grid) row)) (dec col))
  ::
  ++  match-right
    |=  [a=wall b=wall]
    |-  ^-  ?
    ?~  a  &
    ?~  b  &
    ?:  !=((snag 9 i.a) (snag 0 i.b))
      |
    $(a t.a, b t.b)
  ::
  ++  match-bellow
    |=  [a=wall b=wall]
    ^-  ?
    :: ~&  [a b]
    =((snag 0 a) (snag 9 b))
  --
::
++  assemble
  |=  grid=(map @ (map @ [@ wall]))
  ^-  wall
  =/  size=@  ~(wyt by grid)
  =|  [r=@ out=wall]
  |-  ^-  wall
  |^
  ?:  =(r size)  out
  %_  $
    r    +(r)
    out  %+  weld
           out
         =|  [c=@ row=wall]
         |-  ^+  row
         ?:  =(c size)  row
         =/  [id=@ tile=wall]
           (~(got by (~(got by grid) r)) c)
         %_  $
           c    +(c)
           row   (merge row tile)
  ==     ==
  ::
  ++  merge
    |=  [a=wall b=wall]
    =|  i=@
    =|  out=wall
    |-  ^+  out
    ?:  =(i 8)  out
    %_  $
      i    +(i)
      out  %+  snoc  out
           %+  weld
             (clip (snag +(i) b))
           ?~  a  ~
           (snag i `wall`a)
    ==
  ::
  ++  clip  |=(=tape (swag [1 8] tape))
  --
::
++  to-map
  |=  =wall
  =<  all
  %+  roll  wall
  |=  [=tape i=@ all=(map @ (map @ @t))]
  :-  +(i)
  =;  [@ row=(map @ @t)]
    (~(put by all) [i row])
  %+  roll  tape
  |=  [c=@t j=@ row=(map @ @t)]
  :-  +(j)
  (~(put by row) [j c])
::
++  from-map
  |=  water=(map @ (map @ @t))
  ^-  wall
  =/  size=@  ~(wyt by water)
  =|  [r=@ out=wall]
  %-  flop
  |-  ^-  wall
  ?:  =(r size)  out
  %_  $
    r    +(r)
    out  :_  out
         =|  [c=@ row=tape]
         |-  ^+  row
         ?:  =(c size)  row
         =/  char=@t
           (~(got by (~(got by water) r)) c)
         %_  $
           c    +(c)
           row   (snoc row char)
  ==     ==
::
++  part-one
  out:align
::
++  part-two
  =/  water=wall  (assemble water:align)
  =/  monster=wall
    :~  "                  # "
        "#    ##    ##    ###"
        " #  #  #  #  #  #   "
    ==
  =+  [flips=(gulf 0 1) rots=(gulf 0 3)]
  =+  [w=(dec (lent (snag 0 water))) h=(dec (lent water))]
  =|  [count=@ final=wall]
  |^
  |-  ^-  @
  ?~  flips
    ::  count roughness
    ::
    %+  roll  final
    |=  [=tape rough=@]
    %+  add  rough
    (roll tape |=([a=@t c=@] ?:(=('#' a) +(c) c)))
  |-  ^-  @
  ?~  rots
    ^$(rots (gulf 0 3), flips t.flips, water (flip water w h))
  =.  water  (rotate water w h)
  =+  (explore-sea (to-map water))
  =?  final  !=(0 c)  (from-map w)
  =?  count  !=(0 c)  c
  $(rots t.rots)
  ::
  ++  explore-sea
    |=  water=(map @ (map @ @t))
    =|  count=@
    =|  [r=@ c=@]
    |^
    |-  ^+  [c=count w=water]
    ?:  =((add r 2) ~(wyt by water))
      [count water]
    |-  ^+  [count water]
    ?:  =((add 19 c) ~(wyt by (~(got by water) 0)))
      ^$(c 0, r +(r))
    ?.  find-monster
      $(c +(c))
    $(count +(count), water (mark-monster water), c +(c))
    ::
    ++  mark-monster
      |=  sea=(map @ (map @ @t))
      =|  [rm=@ cm=@]
      |-  ^+  sea
      ?:  =(rm 3)  sea
      |-  ^+  sea
      ?:  =(cm 20)
        ^$(cm 0, rm +(rm))
      =?  sea  =('#' (snag cm (snag rm monster)))
        =+  row=(~(got by sea) (add r rm))
        (~(put by sea) [(add r rm) (~(put by row) [(add c cm) 'O'])])
      $(cm +(cm))
    ::
    ++  find-monster
      =|  can-match=?
      =|  rm=@
      |-  ^-  ?
      ?.  can-match  %.n
      ?:  =(rm 3)  can-match
      %_    $
          rm
        +(rm)
      ::
          can-match
        =|  cm=@
        =/  skip=?  %.n
        |-  ^-  ?
        ?:  skip      %.n
        ?:  =(cm 20)  %.y
        =/  in-monster=@t
          (snag cm (snag rm monster))
        =/  in-water=@t
          (~(got by (~(got by water) (add r rm))) (add c cm))
        %_  $
          cm    +(cm)
          skip  &(=('#' in-monster) =('.' in-water))
        ==
      ==
    --
  --
--
