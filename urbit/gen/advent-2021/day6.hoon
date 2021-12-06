:: --- Day 6: Lanternfish ---
::
/*  puzzle-input   %txt   /lib/advent-2021/day6/txt
::
=>  |%
    +$  fish  (map fish-type=@ count=@)
    --
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
::
++  parse-input
  |=  input=(list @)
  %+  roll  input
  |=  [type=@ =fish]
  %+  ~(put by fish)  type
  ?~  f=(~(get by fish) type)
    1
  +(u.f)
::
++  count-fish
  |=  =fish
  %+  roll  ~(tap by fish)
  |=  [[* count=@] total=@]
  (add count total)
::
++  go
  |=  max=@
  =/  input=(list @)
    (rash (head puzzle-input) (more com dem))
  =/  =fish  (parse-input input)
  =|  day=@
  |-  ^-  @
  ?:  =(day max)  (count-fish fish)
  =.  fish  (update-timers fish)
  $(day +(day))
::
++  add-type
  |=  [type=@ count=@ =fish]
  %+  ~(put by fish)  type
  ?~  f=(~(get by fish) type)
    count
  (add count u.f)
::
++  del-type
  |=  [count=@ type=@ =fish]
  ?:  =(count 1)
    (~(del by fish) type)
  (~(put by fish) type (dec count))
::
++  update-timers
  |=  =fish
  %+  roll  ~(tap by fish)
  |=  [[type=@ count=@] =^fish]
  ?.  =(type 0)
    ::  add all to next type
    ::
    (add-type (dec type) count fish)
  =.  fish  (add-type 6 count fish)
  (add-type 8 count fish)
::
++  part-one  (go 80)
++  part-two  (go 256)
--
