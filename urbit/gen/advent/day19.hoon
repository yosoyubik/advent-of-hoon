/*  puzzle-input  %txt  /lib/advent/day19/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
=>  |%
    +$  uno           @
    +$  dos           [a=@ b=@]
    +$  tre           [a=@ b=@ c=@]
    +$  or-uno        (pair uno uno)
    +$  or-dos        (pair dos dos)
    +$  or-1-2        (pair uno dos)
    +$  or-2-3        (pair dos tre)
    +$  seq-rule      $%  [%uno uno]
                          [%dos dos]
                          [%or-dos or-dos]
                          [%or-uno or-uno]
                          [%or-1-2 or-1-2]
                          [%or-2-3 or-2-3]
                      ==
    +$  message-rule  $%([%char r=@t] [%seqs r=seq-rule])
    --
::
|%
++  part-one
  =<  total
  %+  roll  puzzle-input
  |=  [e=cord total=@ part=@ rules=(map @ message-rule) =rule]
  ?:  =('' e)
    [total +(part) rules rule]
  ?.  =(0 part)
    =+  rul=(reduce-rules rules)
    :_  [part rules rule]
    ?^  (rush e rul)
      +(total)
    total
  [total part (~(put by rules) (parse-rule e)) rule]
:: 
++  part-two
  =/  rules-a=(map @ message-rule)
    ::  0 : 1 | 0 2
    ::  1 : 'a'
    ::  2: 'b'
    ::
    %-  molt
    :~  :-  1
        ^-  message-rule  [%char 'a']
        :-  2
        ^-  message-rule  [%char 'b']
        :-  0
        ^-  message-rule  [%seqs [%or-1-2 [1 [2 0]]]]
    ==
    =/  rules-b=(map @ message-rule)
      ::  0 : 1 2 | 1 0 2
      ::  1 : 'a'
      ::  2: 'b'
      ::
      %-  molt
      :~  :-  1
          ^-  message-rule  [%char 'a']
          :-  2
          ^-  message-rule  [%char 'b']
          :-  0
          ^-  message-rule  [%seqs [%or-2-3 [[1 2] [1 0 2]]]]
      ==
  =+  rul-a=(reduce-rules rules-a)
  =+  rul-b=(reduce-rules rules-b)
  :*  (rush 'a' rul-a)
      (rush 'ba' rul-a)
      (rush 'bbbbbbbbbbbbbbbba' rul-a)
    ::
      (rush 'ab' rul-b)
      (rush 'aabb' rul-b)
      (rush 'aaaaaaaaabbbbbbbbb' rul-b)
  ==
::
++  parse-rule
  |=  =cord
  ^-  [type=@ =message-rule]
  %+  rash  cord
  ;~  plug
    ;~(sfix dem ;~(plug col ace))
      ;~  pose
        (stag %char (ifix [doq doq] alf))
        %+  stag  %seqs
        ;~  pose
          :: '2 | 3 4'
          ::
          %+  stag  %or-1-2
          ;~  (glue ;~(plug ace bar ace))
              dem
              ;~((glue ace) dem dem)
          ==
          :: '2 | 3'
          ::
          %+  stag  %or-uno
          ;~((glue ;~(plug ace bar ace)) dem dem)
          :: '2 3 | 3 2 4'
          ::
          %+  stag  %or-2-3
          ;~  (glue ;~(plug ace bar ace))
              ;~((glue ace) dem dem)
              ;~((glue ace) dem dem dem)
          ==
          :: '2 3 | 3 2'
          ::
          %+  stag  %or-dos
          ;~  (glue ;~(plug ace bar ace))
              ;~((glue ace) dem dem)
              ;~((glue ace) dem dem)
          ==
          ::  2 3
          ::
          %+  stag  %dos
          ;~((glue ace) dem dem)
          ::  2
          ::
          %+  stag  %uno
          dem
          :: (more ace dem)
      ==
    ==
  ==
::
++  reduce-rules
  |=  rules=(map @ message-rule)
  =|  i=@
  |-
  =*  next  $
  =+  rule=(~(got by rules) i)
  :: ~&  rule
  ?-    -.rule
      %char
    %+  knee  *tape
    |.  ~+
    ;~(plug (just r.rule) (easy ~))
  ::
      %seqs
    |^
    ?-  -.r.rule
      %uno     compose-uno
      %dos     compose-dos
      %or-uno  compose-or-uno
      %or-dos  compose-or-dos
      %or-1-2  compose-or-1-2
      %or-2-3  compose-or-2-3
    ==
    ::
    ++  compose-uno
      ?>  ?=(uno +.r.rule)
      next(i +.r.rule)
    ::
    ++  compose-dos
      ?>  ?=(dos +.r.rule)
      ;~  (comp |=([a=tape b=tape] (weld a b)))
        %+  knee  *tape
        |.  ~+
        next(i a.r.rule)
      ::
        %+  knee  *tape
        |.  ~+
        next(i b.r.rule)
       ==
    ::
    ++  compose-or-uno
      ?>  ?=(or-uno +.r.rule)
      ;~  pose
        %+  knee  *tape
        |.  ~+
        next(i p.r.rule)
      ::
        %+  knee  *tape
        |.  ~+
        next(i q.r.rule)
      ==
    ::
    ++  compose-or-dos
      ?>  ?=(or-dos +.r.rule)
      =*  left  p.r.rule
      =*  rite  q.r.rule
      ?>  ?=(^ left)
      ?>  ?=(^ rite)
      ;~  pose
        ;~  (comp |=([r=tape s=tape] (weld r s)))
          %+  knee  *tape
          |.  ~+
          next(i a.left)
        ::
          %+  knee  *tape
          |.  ~+
          next(i b.left)
        ==
      ::
        ;~  (comp |=([r=tape s=tape] (weld r s)))
          %+  knee  *tape
          |.  ~+
          next(i a.rite)
        ::
          %+  knee  *tape
          |.  ~+
          next(i b.rite)
        ==
      ==
    ::
    ++  compose-or-1-2
      ?>  ?=(or-1-2 +.r.rule)
      =*  left  p.r.rule
      =*  rite  q.r.rule
      ;~  pose
        %+  knee  *tape
        |.  ~+
        next(i left)
      ::
        ;~  (comp |=([r=tape s=tape] (weld r s)))
          %+  knee  *tape
          |.  ~+
          next(i a.rite)
        ::
          %+  knee  *tape
          |.  ~+
          %^  stir  *tape
            weld
          compose-or-1-2
        ==
      ==
    ::
    ++  compose-or-2-3
      ?>  ?=(or-2-3 +.r.rule)
      =*  left  p.r.rule
      =*  rite  q.r.rule
      ;~  pose
        ;~  (comp |=([r=tape s=tape] (weld r s)))
          %+  knee  *tape
          |.  ~+
          next(i a.left)
        ::
          %+  knee  *tape
          |.  ~+
          next(i b.left)
        ==
      ::
        ;~  (comp |=([r=tape s=tape] (weld r s)))
          %+  knee  *tape
          |.  ~+
          next(i a.rite)
        ::
          %+  knee  *tape
          |.  ~+
          %^  stir  *tape
            welp
          compose-or-2-3
          :: next(i b.rite)
        ::
          %+  knee  *tape
          |.  ~+
          next(i c.rite)
        ==
      ==
    --
  ==
--
