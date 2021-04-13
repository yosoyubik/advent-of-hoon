/*  puzzle-input  %txt  /lib/advent/day19/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
=>  |%
    +$  uno           @
    +$  dos           [a=@ b=@]
    +$  go-rule       ?(uno dos)
    +$  or-uno        (pair uno uno)
    +$  or-dos        (pair dos dos)
    +$  seq-rule      $%  [%uno uno]
                          [%dos dos]
                          [%or-dos or-dos]
                          [%or-uno or-uno]
                      ==
    +$  message-rule  $%([%char r=@t] [%seqs r=seq-rule])
    --
::
|%
++  part-one
  =|  rules=(map @ rule)
  |^
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
                :: '2 3 | 3 2'
                ::
                %+  stag  %or-dos
                ;~  (glue ;~(plug ace bar ace))
                    ;~((glue ace) dem dem)
                    ;~((glue ace) dem dem)
                ==
                :: '2 | 3'
                ::
                %+  stag  %or-uno
                ;~((glue ;~(plug ace bar ace)) dem dem)
                ::  2 3
                ::
                %+  stag  %dos
                ;~((glue ace) dem dem)
                ::  2
                ::
                %+  stag  %uno
                dem
                :: (more ace dem)
    ==  ==  ==
  ::
  ++  reduce-rules
    |=  rules=(map @ message-rule)
    =|  i=@
    |-
    =*  next  $
    =+  rule=(~(got by rules) i)
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
      --
    ==
  --
::
++  part-two  ~
--
