:: --- Day 5: Hydrothermal Venture ---
::
/*  puzzle-input  %txt   /lib/advent-2021/day5/txt
::
=>  |%
    :: +$  item   [n=@ marked=?]
    :: +$  row    (map c=@ item)
    +$  board  (map [x=@ y=@] counts=@)
    :: +$  index  (map [b=@ n=@] [r=@ c=@])
    --
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
::
++  parse-coord
  ;~((glue com) dem dem)
::
++  arrow
  ;~(plug ace hep gar ace)
::
++  vent
  ;~((glue arrow) parse-coord parse-coord)
::
++  make-board
  %+  roll  puzzle-input
  |=  [line=@t =board]
  ~&  line
  =/  [[x1=@ y1=@] [x2=@ y2=@]]  (rash line vent)
  =/  [dim=?(%x %y) range=(list @)]
    ?:  =(x1 x2)
      :-  %x
      (gulf (min y1 y2) (max y1 y2))
    ?:  =(y1 y2)
      :-  %y
      (gulf (min x1 x2) (max x1 x2))
    x+~  :: XX
  %+  roll  range
  |=  [c=@ board=_board]
  =/  coords=[@ @]
    ?:  =(%x dim)
      [x1 c]
    [c y1]
  =+  val=(~(gut by board) coords 0)
  (~(put by board) coords +(val))
::
++  overlaps
  |=  =board
  %+  roll  ~(val by board)
  |=  [c=@ o=@]
  ?:  (gte c 2)  +(o)  o
::
++  part-one
  =/  =board  make-board
  (overlaps board)
::
++  part-two  ~
--
