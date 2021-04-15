:: --- Day 9: Encoding Error ---
::
/*  puzzle-input  %txt  /lib/advent/day9/txt
=/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
=+  pre-size=25
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  is-sum-result
  |=  [n=tape preamble=(list tape)]
  ^-  ?
  =+  val=(scan n dem)
  %+  roll  preamble
  |=  [a=tape found=_|]
  =-  |(found -)
  %+  roll  preamble
  |=  [b=tape found=_|]
  ?|  found
      ?&  !=(a b)
          =(val (add (scan a dem) (scan b dem)))
  ==  ==
::
++  move-window
  |=  [n=tape preamble=(list tape)]
  ^-  (list tape)
  ?~  preamble  ~
  (snoc t.preamble n)
::
++  part-one
  %+  roll  puzzle-input
  |=  [entry=cord [first-fail=tape preamble=(list tape)]]
  ?.  =((lent preamble) pre-size)
    ["" (snoc preamble (trip entry))]
  :_  (move-window (trip entry) preamble)
  ?:  (is-sum-result (trip entry) preamble)
    first-fail
  (trip entry)
::
++  reduce
  |=  nums=(list tape)
  ^-  @
  %+  roll  nums
  |=  [=tape num=@]
  (add num (scan tape dem))
::
++  find-extremes
  |=  nums=(list tape)
  ^-  [@ @]
  =/  sorted=(list tape)
    %+  sort  nums
    |=([a=tape b=tape] (gth (scan b dem) (scan a dem)))
  =/  reverse  (flop sorted)
  ?~  sorted
    [*@ *@]
  :-  (scan i.sorted dem)
  ?>  ?=(^ reverse)
  (scan i.reverse dem)
::
++  compress
  |=  [nums=(list tape) max=@]
  |-  ^-  (list tape)
  ?~  nums  nums
  ?:  (lte (reduce t.nums) max)
    t.nums
  $(nums t.nums)
::
++  part-two
  =+  invalid=556.543.474
  %-  add
  =|  contiguous=(list tape)
  =|  extremes=[@ @]
  |-  ^-  [@ @]
  ?~  puzzle-input  extremes
  ?.  =(extremes [0 0])  extremes
  =*  entry  i.puzzle-input
  =+  reduced=(reduce contiguous)
  =+  reduced-minus=(reduce (slag 1 contiguous))
  %_    $
      puzzle-input
    t.puzzle-input
  ::
      extremes
    ?:  (lth reduced invalid)
      extremes
    ?:  =(invalid reduced)
      (find-extremes contiguous)
    ?:  =(invalid reduced-minus)
      (find-extremes (slag 1 contiguous))
    extremes
  ::
      contiguous
    =/  contiguous-try
      (snoc contiguous (trip entry))
    ?.  (gth (reduce contiguous-try) invalid)
      contiguous-try
    (compress contiguous-try invalid)
  ==
--
