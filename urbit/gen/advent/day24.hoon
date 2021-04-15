:: --- Day 24: Lobby Layout ---
::
/*  puzzle-input  %txt  /lib/advent/day24/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =/  directions=(list (list [@s @s]))
    (roll puzzle-input read-directions)
  ~(wyt in (flip-grid directions))
::
++  part-two
  =/  directions=(list (list [@s @s]))
    (roll puzzle-input read-directions)
  =/  blacks=(set [@s @s])  (flip-grid directions)
  ^-  @
  %~  wyt  in
  %+  roll  (gulf 1 100)
  |=  [day=@ prev-grid=_blacks]
  :: %.y = black, %.n = white
  ::
  =/  grid=(map [@s @s] ?)  (fill-grid prev-grid)
  ::
  =;  grid-after-x=(set [@s @s])
    ~&  [day+day ~(wyt in grid-after-x)]
    grid-after-x
  ::
  %+  roll  ~(tap by grid)
  |=  [[tile=[@s @s] black=?] day-grid=(set [@s @s])]
  |^
  =/  blacks=@  (inspect-around tile prev-grid)
  ?:  ?&  black
          ?|  =(blacks 1)
              =(blacks 2)
      ==  ==
      (~(put in day-grid) tile)
  ?.  =(blacks 2)
    day-grid
  (~(put in day-grid) tile)
  ::
  ++  inspect-around
    |=  [[x=@s y=@s] grid=(set [@s @s])]
    %+  roll  ~(val by double-coordinates)
    |=  [adj=[x=@s y=@s] blacks=@]
    =/  has-black=?
      %-  ~(has in grid)
      [(sum:si x.adj x) (sum:si y.adj y)]
    ?.(has-black blacks +(blacks))
  --
::
++  fill-grid
  |=  blacks=(set [@s @s])
  %+  roll  ~(tap in blacks)
  |=  [[x=@s y=@s] grid=(map [@s @s] ?)]
  %+  roll  ~(val by double-coordinates)
  ::  grid has the inspected black tile
  ::
  |=  [[r=@s s=@s] grid=_(~(put by grid) [x y] %.y)]
  =/  neighbor=[@s @s]
    [(sum:si r x) (sum:si s y)]
  (~(put by grid) neighbor (~(has in blacks) neighbor))
::
++  flip-grid
  |=  directions=(list (list [@s @s]))
  %+  roll  directions
  |=  [coords=(list [@s @s]) blacks=(set [@s @s])]
  |^
  =/  tile=[@s @s]  (reduce coords)
  %.  tile
  ?:  (~(has in blacks) tile)
    ~(del in blacks)
  ~(put in blacks)
  ::
  ++  reduce
    |=  coords=(list [@s @s])
    ^-  [@s @s]
    %+  roll  coords
    |=  [coord=[x=@s y=@s] tile=[x=@s y=@s]]
    :-  (sum:si x.tile x.coord)
    (sum:si y.tile y.coord)
  --
::
++  read-directions
  |=  [tile=@t directions=(list (list [@s @s]))]
  %+  snoc  directions
  =;  coords=(list @t)
    %+  turn  coords
    |=(c=@t (~(got by double-coordinates) c))
  %+  rash  tile
  %-  star
  ;~  pose
      (jest 'e')
      (jest 'se')
      (jest 'sw')
      (jest 'w')
      (jest 'nw')
      (jest 'ne')
   ==
::
++  axial-coordinates
  ^-  (map @t [@s @s])
  %-  my
  :~  ['e' [-1 -0]]
      ['se' [-1 --1]]
      ['sw' [-0 --1]]
      ['w' [--1 -0]]
      ['nw' [--1 -1]]
      ['ne' [-0 -1]]
  ==
::
++  double-coordinates
  ::  https://www.redblobgames.com/grids/hexagons/#neighbors-doubled
  ::
  ^-  (map @t [@s @s])
  %-  my
  :~  ['e' [-2 -0]]
      ['se' [-1 --1]]
      ['sw' [--1 --1]]
      ['w' [--2 -0]]
      ['nw' [--1 -1]]
      ['ne' [-1 -1]]
  ==
--
