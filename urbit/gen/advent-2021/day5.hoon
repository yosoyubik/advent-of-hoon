:: --- Day 5: Hydrothermal Venture ---
::
/*  puzzle-input  %txt  /lib/advent-2021/day5/txt
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
++  make-board-1
  %+  roll  puzzle-input
  |=  [line=@t =board]
  =/  [[x1=@ y1=@] [x2=@ y2=@]]  (rash line vent)
  =/  [dim=?(%x %y) range=(list @)]
    (straight x1 y1 x2 y2)
  %+  roll  range
  |=  [c=@ board=_board]
  =/  coords=[@ @]
    ?-  dim
      %x  [x1 c]
      %y  [c y1]
    ==
  =+  val=(~(gut by board) coords 0)
  (~(put by board) coords +(val))
::
++  straight
  |=  [x1=@ y1=@ x2=@ y2=@]
  ^-  [dim=?(%x %y) range=(list @)]
  ?:  =(x1 x2)
    :-  %x
    (gulf (min y1 y2) (max y1 y2))
  ?:  =(y1 y2)
    :-  %y
    (gulf (min x1 x2) (max x1 x2))
  x+~  :: XX
::
++  diagonal
  |=  [x1=@ y1=@ x2=@ y2=@]
  ^-  [dim=?(%x %y %z) range-s=(list @) range-d=(list @)]
  ?:  =(x1 x2)
    :+  %x
      (gulf (min y1 y2) (max y1 y2))
    ~
  ?:  =(y1 y2)
    :+  %y
      (gulf (min x1 x2) (max x1 x2))
    ~
  ?:  .=  %-  abs:si
          (dif:si (new:si | x2) (new:si | x1))
      %-  abs:si
      (dif:si (new:si | y2) (new:si | y1))
    :+  %z
      =+  xs=(gulf (min x1 x2) (max x1 x2))
      ?:  (gth x2 x1)  xs
      (flop xs)
    =+  ys=(gulf (min y1 y2) (max y1 y2))
    ?:  (gth y2 y1)  ys
    (flop ys)
  x+[~ ~]  :: XX
::
++  make-board-2
  %+  roll  puzzle-input
  |=  [line=@t =board]
  :: ~&  line
  =/  [[x1=@ y1=@] [x2=@ y2=@]]  (rash line vent)
  =/  [dim=?(%x %y %z) range-s=(list @) range-d=(list @)]
    (diagonal x1 y1 x2 y2)
  =<  board
  %+  roll  range-s
  |=  [c=@ i=@ board=_board]
  =/  coords=[@ @]
    ?-  dim
      %x  [x1 c]
      %y  [c y1]
      %z  [c (snag i range-d)]
    ==
  :-  +(i)
  =+  val=(~(gut by board) coords 0)
  (~(put by board) coords +(val))
::
++  overlaps
  |=  =board
  %+  roll  ~(val by board)
  |=  [c=@ o=@]
  ?:((gte c 2) +(o) o)
::
++  part-one
  =/  =board  make-board-1
  (overlaps board)
::
++  part-two
  =/  =board  make-board-2
  (overlaps board)
--
