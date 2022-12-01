:: --- Day 1: Calorie Counting ---
::
/*  puzzle-input  %txt  /lib/advent-2022/day1/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 part-one]
    [%2 part-two]
|%
++  part-one
  %+  roll  puzzle-input
  |=  [line=@t elf=@ max=@]
  ?.  =(line '')
    [(add elf (rash line dem)) max]
  [0 ?:((gth elf max) elf max)]
::
++  part-two
  =;  [* [a=@ b=@ c=@]]
    :(add a b c)
  %+  roll  puzzle-input
  |=  [line=@t elf=@ max=[a=@ b=@ c=@]]
  ?.  =(line '')
    [(add elf (rash line dem)) max]
  =?  max  (gth elf a.max)  [elf a.max b.max]
  =?  max  &((gth elf b.max) (lth elf a.max))
    [a.max elf b.max]
  =?  max  &((gth elf c.max) (lth elf b.max))
    [a.max b.max elf]
  [0 max]
--
