:: --- Day 2: Rock Paper Scissors ---
::
/*  puzzle-input  %txt  /lib/advent-2022/day2/txt
::
=>  |%  +$  hand  ?(%rock %paper %sciss)
    --
:-  %say
|=  *
=<  :+  %noun
      [%1 (part %one)]
    [%2 (part %two)]
|%
::
++  part
  |=  part=?(%one %two)
  %+  roll  puzzle-input
  |=  [line=@t score=@]
  =/  [ze=@t me=@t]  (rash line ;~((glue ace) alf alf))
  =/  [me=hand ze=hand]
    ?-  part
      %one  (transform-one me)^(transform-one ze)
      %two  =+  ze=(transform-one ze)
            (transform-two me ze)^ze
    ==
  ;:  add  score  (match me ze)
  ?-  me
    %rock   1
    %paper  2
    %sciss  3
  ==  ==
::
++  transform-one
  |=  a=@t
  ^-  hand
  ?:  |(=('A' a) =('X' a))  %rock
  ?:  |(=('B' a) =('Y' a))  %paper
  ?:  |(=('C' a) =('Z' a))  %sciss
  !!
::
++  transform-two
  |=  [me=@t ze=hand]
  ^-  hand
  ?:  &(=('X' me) =(ze %rock))  %sciss
  ?:  &(=('X' me) =(ze %paper))  %rock
  ?:  &(=('X' me) =(ze %sciss))  %paper
  ?:  =('Y' me)  ze
  ?:  &(=('Z' me) =(ze %rock))  %paper
  ?:  &(=('Z' me) =(ze %paper))  %sciss
  ?:  &(=('Z' me) =(ze %sciss))  %rock
  !!
::
++  match
  |=  [me=hand ze=hand]
  ^-  @
  ?:  =(me ze)  3
  ?:  ?|  &(?=(%rock me) ?=(%paper ze))
          &(?=(%paper me) ?=(%sciss ze))
          &(?=(%sciss me) ?=(%rock ze))
      ==
    0
  ?:  ?|  &(?=(%rock ze) ?=(%paper me))
          &(?=(%paper ze) ?=(%sciss me))
          &(?=(%sciss ze) ?=(%rock me))
      ==
    6
  !!
--
