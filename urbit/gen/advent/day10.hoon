:: --- Day 10: Adapter Array ---
::
/*  puzzle-input  %txt  /lib/advent/day10/txt 
=/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  sort-down
  |=  adapters=(list @)
  %+  sort  adapters
  |=  [a=@ b=@]
  (gth b a)
::
++  sort-puzzle
  %+  roll  puzzle-input
  |=  [entry=cord adapters=(list @)]
  %.  [(rash entry dem) adapters]
  ?.  =((lent adapters) max)
    same
  sort-down
::
++  part-one
  =/  sorted-adapters=(list @)
    sort-puzzle
  =|  diffs=[uno=@ tre=@]
  =|  jolt=@
  %-  mul
  |-  ^+  diffs
  ?~  sorted-adapters  diffs(tre +(tre.diffs))
  =*  adapter  i.sorted-adapters
  =/  diff=@  (sub adapter jolt)
  ?.  (lte diff 3)
    ~&  %exit
    diffs(tre +(tre.diffs))
  %_  $
    sorted-adapters  t.sorted-adapters
  ::
    diffs  :-  ?:(=(diff 1) +(uno.diffs) uno.diffs)
           ?:(=(diff 3) +(tre.diffs) tre.diffs)
  ::
    jolt  (add diff jolt)
  ==
::
++  part-two
  ::                      11  12 15  16  19
  ::           5 6 7 10
  ::                        12  15  16  19
  ::
  ::                      11  12 15  16  19
  :: 0 - 1 - 4  6 7 10
  ::                     12  15  16  19
  ::
  ::                     11  12 15  16  19
  ::            7 10
  ::                      12  15  16  19
  ::
  =/  adapters=(list @)  [0 sort-puzzle]
  =|  memo=(map node=@ ways=@)
  ~&  "begin"
  =<  total
  |-  ^-  [total=@ m=_memo]
  =*  count  $
  ?~  adapters  !!
  =*  i  i.adapters
  :: ~&  adapters
  ?:  (lte (lent adapters) 1)
    :: ~&  %done
    [1 (~(put by memo) [i 1])]
  =+  cached=(~(get by memo) i)
  ?^  cached
    [u.cached memo]
  =;  [total=@ memo=(map @ @)]
    :: ~&  [node=i total]
    :-  total
    (~(put by memo) [i.adapters total])
  ?:  ?&  ?=([@ @ @ @ *] adapters)
          (lte (sub i.t.adapters i) 3)
          (lte (sub i.t.t.adapters i) 3)
          (lte (sub i.t.t.t.adapters i) 3)
      ==
    :: ~&  [i %launch-3]
    =+  a=count(adapters t.adapters)
    =+  b=count(adapters t.t.adapters, memo m:a)
    =+  c=count(adapters t.t.t.adapters, memo m:b)
    :_  m:c
    :(add total:a total:b total:c)
  ?:  ?&  ?=([@ @ @ *] adapters)
          (lte (sub i.t.adapters i) 3)
          (lte (sub i.t.t.adapters i) 3)
      ==
    :: ~&  [i %launch-2]
    =+  a=count(adapters t.adapters)
    =+  b=count(adapters t.t.adapters, memo m:a)
    :_  m:b
    (add total:a total:b)
  ?.  ?&  ?=([@ @ *] adapters)
          (lte (sub i.t.adapters i) 3)
      ==
    [0 memo]
  :: ~&  [i %launch-1]
  count(adapters t.adapters)
--
