:: --- Day 1: Report Repair ---
:: 
/+  *advent-day1
::
:-  %say
|=  *
=<  :-  %noun
    (part-two report-nums report-nums)
|%
++  part-one
  |=  report-nums=(list @ud)
  =|  total=@ud
  |-  ^-  @ud
  ?~  report-nums    total
  ?:  (gth total 0)  total
  %_  $
      report-nums
    t.report-nums
  ::
      total
    =;  parsed=(list @ud)
      ?~  parsed  total
      (mul i.report-nums i.parsed)
    %+  skim  ^report-nums
    |=  num=@ud
    =((add i.report-nums num) 2.020)
  ==
++  part-two
  |=  [report=(list @ud) report-aux=(list @ud)]
  =|  total=@ud
  |-  ^-  @ud
  =*  left-loop  $
  ?~  report   total
  =/  first=@ud  i.report
  ?:  (gth total 0)  total
  =/  rote=(list @ud)  report-aux
  |-  ^-  @ud
  =*  rite-loop  $
  ?~  report-aux
    left-loop(report t.report, report-aux rote)
  =/  second=@ud  i.report-aux
  %_  rite-loop
      report-aux
    t.report-aux
  ::
      total
    =;  parsed=(list @ud)
      ?~  parsed  total
      :(mul first second i.parsed)
    ^-  (list @ud)
    %+  skim  ^-((list @ud) report)
    |=  num=@ud
    =(:(add first second num) 2.020)
  ==
--
