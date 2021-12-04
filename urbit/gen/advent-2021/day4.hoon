:: --- Day 4: XX ---
::
/*  puzzle-input   %txt   /lib/advent-2021/day4/txt
::
=>  |%
    +$  item   [n=@ marked=?]
    +$  row    (map c=@ item)
    +$  board  (map r=@ row)
    +$  index  (map [b=@ n=@] [r=@ c=@])
    --
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
::
++  parse-boards
  |=  input=(list cord)
  =<  [boards index]
  %+  roll  input
  |=  [line=@t i=@ b=@ boards=(map @ board) =index]
   ?:  =(line '')  [0 +(b) boards index]
   =/  =board
     ?:  =(i 0)  *board
     (~(got by boards) b)
  =/  new-row=(list @)
    =/  l=tape  (trip line)
    =.  l  ?:(=(' ' (head l)) (tail l) l)
    (scan l (more (star ace) dem))
  =/  row-items
    =<  l
    %+  roll  (turn new-row (late %.n))
    |=  [=item col=@ l=(list [@ item])]
    [+(col) [col item]^l]
  =.  index
    %+  roll  row-items
    |=  [[col=@ =item] index=_index]
    (~(put by index) [b n.item] [i col])
  =.  boards
    %+  ~(put by boards)  b
    %+  ~(put by board)   i
    (~(gas by *row) row-items)
  [+(i) b boards index]
::
++  get-n
  |=  [r=@ c=@ =board]
  ^-  item
  (~(got by (~(got by board) r)) c)
::
++  is-winner
  |=  [[r=@ c=@] =board]
  ^-  ?
  |^  ?|  (winner-row (~(got by board) r))
          (winner-col board)
      ==
  ::
  ++  winner-col
    |=  =^board
    ^-  ?
    =;  board
      (winner-row (~(got by board) c))
    ::  flipping
    ::
    %+  roll  ~(tap by board)
    |=  [[row=@ rows=(map @ item)] b=(map @ row)]
    %+  roll  ~(tap by rows)
    |=  [[col=@ =item] b=_b]
    %+  ~(put by b)  col
    %.  [row item]
    ?^  cols=(~(get by b) col)
      ~(put by u.cols)
    ~(put by *(map @ ^item))
  ::
  ++  winner-row
    :: |=  =^board
    :: %+  lien  ~(val by board)
    |=  =row
    ^-  ?
    (levy ~(val by row) |=(=item marked.item))
  --
::
++  calculate-score
  |=  board=(unit [=board n=@])
  ^-  @
  ?~  board  0
  |^
  %+  mul  n.u.board
  (sum-unmarked board.u.board)
  ::
  ++  sum-unmarked
    |=  =^board
    ^-  @
    %+  roll  ~(val by board)
    |=  [=row score=@]
    %+  roll  ~(val by row)
    |=  [=item score=_score]
    ?:  marked.item  score
    (add n.item score)
  --
::
++  part-one
  =/  numbers=(list @)
    (rash (head puzzle-input) (more com dem))
  ?>  ?=([@ @ ^] puzzle-input)
  =/  [boards=(map @ board) =index]
    (parse-boards t.t.puzzle-input)
  =+  n-boards=~(wyt by boards)
  ~&  n-boards
  %-  calculate-score
  =<  w
  ::  game begins
  ::
  %+  roll  numbers
  |=  [num=@ w=(unit [board @]) boards=_boards]
  ?:  ?=(^ w)  w^boards  :: unnecessary iterations, better with |-
  ::
  =|  b-i=@
  |-  ^-  [(unit [board @]) (map @ board)]
  ?:  (gte b-i n-boards)
    w^boards
  =/  =board  (~(got by boards) b-i)
  ?~  i=(~(get by index) b-i num)
    $(b-i +(b-i))
  =/  [r=@ c=@]  u.i
  =+  item=(get-n r c board)
  =.  board
    =/  =row  (~(got by board) r)
    %+  ~(put by board)  r
    (~(put by row) c item(marked %.y))
  ?.  (is-winner [r c] board)
    =.  boards  (~(put by boards) b-i board)
    $(b-i +(b-i))
  [`[board n.item] boards]
::
++  part-two
 =/  numbers=(list @)
    (rash (head puzzle-input) (more com dem))
  ?>  ?=([@ @ ^] puzzle-input)
  =/  [boards=(map @ board) =index]
    (parse-boards t.t.puzzle-input)
  =+  n-boards=~(wyt by boards)
  ::  game begins
  ::
  %-  calculate-score
  =<  w
  %+  roll  numbers
  |=  [num=@ w=(unit [board @]) boards=_boards winners=(set @)]
  ?:  =(n-boards ~(wyt in winners))
    w^boards^winners    :: unnecessary iterations, better with |-
  ::
  =|  b-i=@
  |-  ^+  [w boards winners]
  ?:  (gte b-i n-boards)
    w^boards^winners
  ?:  (~(has in winners) b-i)
    $(b-i +(b-i))
  =/  =board  (~(got by boards) b-i)
  ?~  i=(~(get by index) b-i num)
    $(b-i +(b-i))
  =/  [r=@ c=@]  u.i
  =+  item=(get-n r c board)
  =.  board
    =/  =row  (~(got by board) r)
    %+  ~(put by board)  r
    (~(put by row) c item(marked %.y))
  =+  won=(is-winner [r c] board)
  =?  winners  won
    (~(put in winners) b-i)
  =?  w  won
    `[board n.item]
  =.  boards  (~(put by boards) b-i board)
  $(b-i +(b-i))
--
