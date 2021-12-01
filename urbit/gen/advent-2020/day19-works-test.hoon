::
:: 0: 4 1 5
:: 1: 2 3 | 3 2
:: 2: 4 4 | 5 5
:: 3: 4 5 | 5 4
:: 4: "a"
:: 5: "b"
::
:: ;~  plug
::     (jest 'a')
::     ;~  pose
::         ;~   plug
::              ;~  pose
::                  ;~  plug
::                      (jest 'a')
::                      (jest 'a')
::                  ==
::                  ;~  plug
::                      (jest 'b')
::                      (jest 'b')
::              ==  ==
::             ;~  pose
::                 ;~  plug
::                   (jest 'a')
::                   (jest 'b')
::                 ==
::                 ;~  plug
::                     (jest 'b')
::                     (jest 'a')
::                 ==
::         ==  ==
::         ;~  plug
::             ;~  pose
::                 ;~  plug
::                   (jest 'a')
::                   (jest 'b')
::                 ==
::                 ;~  plug
::                     (jest 'b')
::                     (jest 'a')
::                 ==
::             ==
::             ;~  pose
::                  ;~  plug
::                      (jest 'a')
::                      (jest 'a')
::                  ==
::                  ;~  plug
::                      (jest 'b')
::                      (jest 'b')
::     ==  ==  ==   ==
::     (jest 'b')
:: ==
::
/*  puzzle-input  %txt  /lib/advent-2020/day19/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
=>  |%
    +$  one-rule      [a=@ b=@ c=@]
    +$  or-rule       (pair [a=@ b=@] [a=@ b=@])
    +$  message-rule  $%([%char r=@t] [%seqs r=?(one-rule or-rule)])
    --
::
|%
:: factor: dem | expr
:: turm: factor | turm * factor
:: expr: term | term + expr
::
:: base: '2' | '3'
:: recur: base recur
:: end: '~'
::
++  base
  %+  knee  *@t
  |.  ~+
  ;~  pose
      (just 'a')
      (just 'b')
  ==
::
++  recur
  %+  knee  *(list @t)
  |.  ~+
  ;~  plug
      base
      ;~(pose recur (easy ~))
      :: ;~(pose (just '~') recur)
  ==
:: 0: 4 1 5
:: 1: 2 3 | 3 2
:: 2: 4 4 | 5 5
:: 3: 4 5 | 5 4
:: 4: "a"
:: 5: "b"
::
:: Grammar (types of rules):
::
:: '0: 1 2'
:: '1: "a"'
:: '2: 1 3 2 | 3 1 2'
:: '3: "b"'
::
:: A rule that matches one character ('a' or 'b') Rules 1 & 3
::
++  one-char
  %+  knee  *@t
  |.  ~+
  ;~  pose
    (just 'a')
    (just 'b')
  ==
::
++  a-char
  :: %+  knee  *(list @t)
  :: |.  ~+
  :: ;~(plug (just 'a') (easy ~))
  (just 'a')
::
++  end
  :: %+  knee  *(list @t)
  :: |.  ~+
  :: ;~(plug (easy ~))
  (easy ~)
::
++  b-char
  :: %+  knee  *(list @t)
  :: |.  ~+
  :: ;~(plug (just 'b') (easy ~))
  (just 'b')
::
:: ++  rule-2
  :: |-
  :: %+  knee  *(list @t)
  :: |.  ~+
  :: ;~  (comp |*([a=(list) b=(list)] (weld a b)))
  ::     ;~  pose
  ::         ;~((comp |*([a=(list) b=(list)] (weld a b))) a-char b-char)
  ::         ;~((comp |*([a=(list) b=(list)] (weld a b))) b-char a-char)
  ::     ==
  ::     (easy *(list @t))
  ::     ::
  :: ==

::
:: ++  many-a
::   |-
::   %+  knee  tape
::   |.  ~+
::   ;~  pose
::     ;~((comp |*([a=* b=(list)] (weld ~[a] b))) (just 'a') ^$)
::     (easy *tape)
::   ==
::
++  pars
  |-
  ;~  plug
      prn
      ;~  pose
          (knee *tape |.(^$))
          (easy ~)
  ==  ==
::
:: ++  rule-0  ;~(plug (just 'a') rule-2)
:: ++  rule-0
::   ::  0: 4 1 5
::   ::
::   %+  knee  *(list @t)
::   |.  ~+
::   ;~  plug
::   ==
:: :: A rule that matches either one sequence, or a list of sequences
:: ::
:: ++  sequence
::   |=  rules=(map @ message-rule)
::   =|  =rule
::   =|  current=@
::   |-  ^+  rule
::   ?:  =(0 ~(wyt by rules))
::     rule
::   =+  parse=(~(got by rules) current)
::
::
::   ?-    -.type
::       %char
::     (just +.parse)
::   ::
::       %seqs
::     %+  roll  +.parse
::     |=  [r=?(%~ (list ?(%~ (list ?(%~ @))))) =rule]
::     ?:  =(%~ r)  (easy ~)
::     %+  knee  *(list @t)
::     |.  ~+
::     ;~  pose
::         base
::         ;~(pose recur (easy ~))
::         :: ;~(pose (just '~') recur)
::     ==
::   ==
::
::   %+  knee  *(list sequence)
::   |.  ~+
::   ;~  pose
::       one-char
::   ==
::
++  part-one
  =|  rules=(map @ rule)
  |^
  =;  [total=@ @ rules=(map @ message-rule) *]
    total
  ::
  %+  roll  puzzle-input
  |=  [e=cord total=@ part=@ rules=(map @ message-rule) =rule]
  ?:  =('' e)
    [total +(part) rules rule]
  :: ~&  (parse-rule e)
  ?.  =(0 part)
    :: ~&  e
    =+  rul=(reduce-rules rules)
    :_  [part rules rule]
    ?^  =-  ~&  [e -]  -
        (rush e rul)
      +(total)
    total
  [total part (~(put by rules) (parse-rule e)) rule]
  ::
  ++  parse-rule
    |=  =cord
    ^-  [type=@ =message-rule]
    ~&  cord
    %+  rash  cord
    ;~  plug
        ;~(sfix dem ;~(plug col ace))
        ;~  pose
            (stag %char (ifix [doq doq] alf))
            :: %+  stag  %seqs1  (more ace dem)
            %+  stag  %seqs
            ;~  pose
                ::  2 3 | 3 2
                ::
                ;~  ::(glue (ifix [ace ace] bar)) :: ' | '
                    (glue ;~(plug ace bar ace))
                    ;~((glue ace) dem dem)      :: '2 3'
                    ;~((glue ace) dem dem)      :: '3 2'
                ==
              ::
                :: ;~((glue ace) dem dem dem)
                ;~((glue ace) dem dem dem)
                :: (more ace dem)
    ==  ==  ==
  ::
  ++  reduce-rules
    |=  rules=(map @ message-rule)
    =|  i=@
    |-
    :: ?:  =(reduced ~(wyt by rules))
    ::   rule
    :: rules
    =*  next  $
    =+  rule=(~(got by rules) i)
    ?-  -.rule
      %char  ::;~(plug (just r.rule) (easy ~))
             %+  knee  *tape
             |.  ~+
             ;~(plug (just r.rule) (easy ~))
      %seqs  ::~&  r.rule
             ::(just '1')
            ?:  ?=(one-rule r.rule)
              :: ;~(plug $(i a.r.rule) $(i b.r.rule))
              ;~  (comp |=([a=tape b=tape] (weld a b)))
                %+  knee  *tape
                |.  ~+
                ^$(i a.r.rule)
              ::
                %+  knee  *tape
                |.  ~+
                ^$(i b.r.rule)
              ::
                %+  knee  *tape
                |.  ~+
                ^$(i c.r.rule)
              ==
             ?>  ?=(or-rule r.rule)
             =*  l  p.r.rule
             =*  r  q.r.rule
             ;~  pose
              :: ;~(plug next(i a.left) next(i b.left))
              :: ;~(plug next(i a.rite) next(i b.rite))
              :: ;~(plug (just a.l) (just b.l))
                ;~  (comp |=([a=tape b=tape] (weld a b)))
                  %+  knee  *tape
                  |.  ~+
                  ^$(i a.l)
                ::
                  %+  knee  *tape
                  |.  ~+
                  ^$(i b.l)
                ==
               ::
                ;~  (comp |=([a=tape b=tape] (weld a b)))
                  %+  knee  *tape
                  |.  ~+
                  ^$(i a.r)
                ::
                  %+  knee  *tape
                  |.  ~+
                  ^$(i b.r)
                ==
    ==       ==

    ::   =+  l=(limo +.new-rule)
    ::   ?:  (lte (lent l) 1)
    ::     |-  ^-  rule
    ::     ?~  l  (easy ~)
    ::     :: %+  roll  l
    ::     :: |=  [r-i=@ r=?(~ rule)]
    ::     :: ?~  r  ;~(plug next(i r-i))
    ::     :: ;~(plug r next(i r-i))
    ::   %+  roll  l
    ::   |=  [sub-rule=(list @) r=?(~ rule)]
    ::   ;~  pose
    ::       %+  roll  sub-rule
    ::       |=  [r-i=@ r=rule]
    ::       ?~  r  ;~(plug next(i r-i))
    ::       ;~(plug r next(i r-i))
    ::   ==
    :: ==
  --
::
++  part-two  ~
--
