:: --- Day 4: Camp Cleanup ---
::
/*  puzzle-input  %txt   /lib/advent-2022/day4/txt
::
:-  %say
|=  *
=<  :+  %noun
      [%1 (part %one)]
    [%2 (part %two)]
|%
++  range  ;~((glue hep) dem dem)
++  part
  |=  part=?(%one %two)
  %+  roll  puzzle-input
  |=  [line=@t out=@]
  =/  [a=[@ @] b=[@ @]]
    (rash line ;~((glue com) range range))
  =?  out
      ?-  part
        %one  |((is-contained a^b) (is-contained b^a))
        %two  |((some-contained a^b) (some-contained b^a))
      ==
    +(out)
  out
::
++  is-contained
  |=  [a=[@ @] b=[@ @]]
  &((gte -.a -.b) (lte +.a +.b))
::
++  some-contained
  |=  [a=[@ @] b=[@ @]]
  ?|  &((gte -.a -.b) (lte +.a +.b))
      =(+.a -.b)  =(-.a +.b)
      &((gte -.a -.b) (lte -.a +.b))
      &((gte +.a -.b) (lte +.a +.b))
  ==
::
--
