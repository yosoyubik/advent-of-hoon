:: --- Day 8: Seven Segment Search ---
::
/*  puzzle-input   %txt   /lib/advent-2021/day8/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  segments
  (more ace (plus alf))
::
++  sep
  ;~(plug ace bar ace)
::
++  digits
  ;~((glue sep) segments segments)
::
++  part-one
  %+  roll  puzzle-input
  |=  [line=@t count=@]
  =/  [patterns=(list tape) output=(list tape)]
    (rash line digits)
  =/  lengths=(jar @ tape)  ::  grouping by word length
    %+  roll  patterns
    |=  [word=tape lengths=(jar @ tape)]
    (~(add ja lengths) (lent word) word)
  %+  roll  output
  |=  [word=tape count=_count]
  =/  counts=(list tape)
    (~(get ja lengths) (lent word))
  ?.  =(1 (lent counts))  count
  +(count)
::
++  part-two  ~
--
