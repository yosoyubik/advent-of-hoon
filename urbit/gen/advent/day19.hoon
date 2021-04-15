:: --- Day 19: Monster Messages ---
::
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
  |=  [e=cord total=@ part=@ rules=(map @ message-rule)]
  ?:  =('' e)
    [total +(part) rules]
  ?.  =(0 part)
    ::  FIXME: don't do this every time
    ::
    =+  rul=(reduce-rules rules)
    :_  [part rules]
    ?^  (rush e rul)
      +(total)
    total
  [total part (~(put by rules) (parse-rule e))]
::
++  part-two
  =/  rules-a=(map @ message-rule)
    ::  0 : 1 | 1 0
    ::  1 : 'a'
    ::  2: 'b'
    ::
    %-  molt
    :~  :-  1
        ^-  message-rule  [%char 'a']
        :-  2
        ^-  message-rule  [%char 'b']
        :-  0
        ^-  message-rule  [%seqs [%or-1-2 [1 [1 0]]]]
    ==
    =/  rules-b=(map @ message-rule)
      ::  0 : 1 2 | 1 0 2
      ::  1 : 'a'
      ::  2: 'b'
      ::  3 : 1 | 1 3
      ::
      %-  molt
      :~  :-  1
          ^-  message-rule  [%char 'a']
          :-  2
          ^-  message-rule  [%char 'b']
          :-  0
          ^-  message-rule  [%seqs [%or-2-3 [[1 2] [1 0 2]]]]
          :-  3
          ^-  message-rule  [%seqs [%or-1-2 [1 [1 3]]]]
      ==
  =+  rul-a=(reduce-rules rules-a)
  =+  rul-b=(reduce-rules rules-b)
  ~&
  :*  (rush 'a' rul-a)
      (rush 'aa' rul-a)
      (rush 'aaaaaaaaaaa' rul-a)
    ::
      (rush 'ab' rul-b)
      (rush 'aabb' rul-b)
      (rush 'aaaaaaaaabbbbbbbbb' rul-b)
  ==
  =<  total
  %+  roll  puzzle-input
  |=  [e=cord total=@ part=@ rules=(map @ message-rule)]
  ?:  =('' e)
    [total +(part) rules]
  ?.  =(0 part)
    ::  FIXME: don't do this every time
    ::
    =+  rul=(reduce-rules rules)
    :_  [part rules]
    ?^  (rush e rul)
      +(total)
    total
  :+  total
    part
  %-  ~(put by rules)
  =/  [type=@ =message-rule]  (parse-rule e)
  :-  type
  ?:  =(type 8)
    [%seqs %or-1-2 [42 [42 8]]]
  ?.  =(type 11)
    message-rule
  [%seqs %or-2-3 [[42 31] [42 11 31]]]
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
      ==
    ==
  ==
::
++  reduce-rules
  |=  rules=(map @ message-rule)
  =|  i=@
  |-
  =*  go-to  $
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
      go-to(i +.r.rule)
    ::
    ++  compose-dos
      ?>  ?=(dos +.r.rule)
      ;~  (comp |=([a=tape b=tape] (weld a b)))
        %+  knee  *tape
        |.  ~+
        go-to(i a.r.rule)
      ::
        %+  knee  *tape
        |.  ~+
        go-to(i b.r.rule)
       ==
    ::
    ++  compose-or-uno
      ?>  ?=(or-uno +.r.rule)
      ;~  pose
        %+  knee  *tape
        |.  ~+
        go-to(i p.r.rule)
      ::
        %+  knee  *tape
        |.  ~+
        go-to(i q.r.rule)
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
          go-to(i a.left)
        ::
          %+  knee  *tape
          |.  ~+
          go-to(i b.left)
        ==
      ::
        ;~  (comp |=([r=tape s=tape] (weld r s)))
          %+  knee  *tape
          |.  ~+
          go-to(i a.rite)
        ::
          %+  knee  *tape
          |.  ~+
          go-to(i b.rite)
        ==
      ==
    ::
    ++  compose-or-1-2
      ?>  ?=(or-1-2 +.r.rule)
      =*  left  p.r.rule
      =*  rite  q.r.rule
      ;~  (comp |=([r=tape s=tape] (weld r s)))
        %+  knee  *tape
        |.  ~+
        go-to(i a.rite)
      ::
        ;~  pose
          %+  knee  *tape
          |.  ~+  compose-or-1-2
        ::
          (easy ~)
        ==
      ==
    ::
    ++  compose-or-2-3
      ?>  ?=(or-2-3 +.r.rule)
      =*  left  p.r.rule
      ;~  (comp |=([r=tape s=tape] (weld r s)))
        %+  knee  *tape
        |.  ~+
        go-to(i a.left)
      ::
        ;~  pose
          %+  knee  *tape
          |.  ~+  compose-or-2-3
        ::
          (easy ~)
        ==
      ::
        %+  knee  *tape
        |.  ~+
        go-to(i b.left)
      ==
    --
  ==
--
