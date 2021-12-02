:: --- Day 2: Dive! ---
::
/*  puzzle-input  %txt    /lib/advent-2021/day2/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  part-one
  %-  mul
  %+  roll  puzzle-input
  |=  [line=@t h=@ d=@]
  =/  [pos=@t * n=@]
    %+  rash  line
    ;~  plug
        ;~(pose (jest 'forward') (jest 'down') (jest 'up'))
        ace
        dem
    ==
  ?+  pos  !!
    %forward  =.(h (add h n) [h d])
    %down     =.(d (add d n) [h d])
    %up       =.(d (sub d n) [h d])
  ==
::
++  part-two
  %-  mul
  =<  [h d]
  %+  roll  puzzle-input
  |=  [line=@t h=@ d=@ a=@]
  =/  [pos=@t * n=@]
    %+  rash  line
    ;~  plug
        ;~(pose (jest 'forward') (jest 'down') (jest 'up'))
        ace
        dem
    ==
  ?+  pos  !!
    %down     =.(a (add a n) [h d a])
    %up       =.(a (sub a n) [h d a])
  ::
    %forward
    =:  h  (add h n)
        d  (add d (mul a n))
    ==
    [h d a]
  ==
--
