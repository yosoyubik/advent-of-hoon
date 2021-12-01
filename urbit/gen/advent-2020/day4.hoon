:: --- Day 4: Passport Processing ---
::
/*  puzzle-input  %txt  /lib/advent-2020/day4/txt
::
:-  %say
|=  *
=<  :-  %noun
    :-  [%1 =<(passports part-one)]
    [%2 =<(passports part-two)]
|%
++  part-one
  =/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
  %+  roll  puzzle-input
  |=  [entry=cord [i=@ fields=(set [tape tape]) passports=@]]
  ^-  [@ (set [tape tape]) @]
  =/  parsed-fields
    ?:  =('' entry)  fields
    (extract-fields fields (trip entry) %1)
  :+  +(i)
    ?:(=('' entry) ~ parsed-fields)
  ?:  ?&  |(=(max i) =('' entry))
          (validate parsed-fields)
      ==
    +(passports)
  passports
::
++  part-two
  =/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
  %+  roll  puzzle-input
  |=  [entry=cord [i=@ fields=(set [tape tape]) passports=@]]
  ^-  [@ (set [tape tape]) @]
  =/  parsed-fields
    ?:  =('' entry)  fields
    (extract-fields fields (trip entry) %2)
  :+  +(i)
    ?:(=('' entry) ~ parsed-fields)
  ?:  ?&  |(=(max i) =('' entry))
          (validate parsed-fields)
      ==
    +(passports)
  passports
::
++  validate
  |=  fields=(set [tape tape])
  ^-  ?
  .=  ~(wyt in mandatory)
  %~  wyt  in
  (~(int in (get-fields fields)) mandatory)
  ::
++  get-fields
  |=  fields=(set [tape tape])
  ^-  (set tape)
  %-  ~(gas in *(set tape))
  (turn ~(tap in fields) |=([k=tape *] k))
::
++  extract-fields
  |=  [fields=(set [tape tape]) entry=tape part=?(%1 %2)]
  ^+  fields
  =/  pairs=(list tape)
    (scan entry (more ace (star ;~(less ace next))))
  %+  roll  pairs
  |=  [line=tape found=_fields]
  ^+  fields
  =/  [field=tape val=tape]
    (scan line ;~((glue col) (star alf) (star ;~(pose low hig nud hax))))
  ?.  |(=(%1 part) (valid-field field val))
    found
  (~(put in found) [field val])
::
++  valid-field
  |=  [k=tape v=tape]
  ^-  ?
  ?:  =("eyr" k)
    =+  (rust v dem)
    ?~  -  |
    &((gte u.- 2.020) (lte u.- 2.030))
  ?:  =("hgt" k)
    =+  (rust v ;~(sfix dem ;~(pose (jest 'cm') (jest 'in'))))
    ?~  -  |
    ?:  =('m' (snag 0 (flop v)))
      &((gte u.- 150) (lte u.- 193))
    &((gte u.- 59) (lte u.- 76))
  ?:  =("hcl" k)
    =+  (rust v ;~(pfix hax (star aln)))
    ?~  -  |
    =((lent u.-) 6)
  ?:  =("pid" k)
    ?.  =(9 (lent v))  |
    ?~((rust v dem) | &)
  ?:  =("byr" k)
    =+  (scan v dem)
    &((gte - 1.920) (lte - 2.002))
  ?:  =("ecl" k)
    =+  %+  rust  v
        ;~  pose
            (jest 'amb')
            (jest 'blu')
            (jest 'brn')
            (jest 'gry')
            (jest 'grn')
            (jest 'hzl')
            (jest 'oth')
        ==
    ?~(- | &)
  ?.  =("iyr" k)  &
  =+  (rust v dem)
  ?~  -  |
  &((gte u.- 2.010) (lte u.- 2.020))
::
++  mandatory
  ^-  (set tape)
  %-  ~(gas in *(set tape))
  ~["eyr" "hgt" "hcl" "pid" "byr" "ecl" "iyr"]
--
