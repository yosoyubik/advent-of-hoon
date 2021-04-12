::
/*  puzzle-input  %txt  /lib/advent/day18/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  %+  roll  puzzle-input
  |=  [e=cord total=@]
  (add total (calculate-expression (parse-expression e)))
::
++  parse-expression
 |=  e=cord
 ^-  (list @t)
 %+  murn  (trip e)
 |=(a=@t ?:(=(a ' ') ~ (some a)))
::
++  calculate-expression
  |=  e=(list @t)
  ^-  @
  ::  2 * 3 + (4 * 5)
  ::
  =<  res
  =|  ops=(list @t)
  =|  nums=(list @)
  =|  res=@
  =|  inners=@
  |-  ^-  [@ res=@]
  |^
  ?~  e  [inners res]
  ?:  (is-r-par i.e)
    [inners res]
  ?:  ?&  ?=(^ nums)
          ?=(^ ops)
          =((lent nums) 1)
          (is-num i.e)
      ==
    :: calculate!
    ::
    %_  $
      e       t.e
      ops     ~
      nums    ~[(calculate i.ops [(rash i.e dem) nums])]
      res     (calculate i.ops [(rash i.e dem) nums])
      inners  +(inners)
    ==
  ?:  (is-num i.e)    $(nums [(rash i.e dem) nums], e t.e, inners +(inners))
  ?:  (is-op i.e)     $(ops [i.e ops], e t.e, inners +(inners))
  ?.  (is-l-par i.e)  !!
  =/  [new-inners=@ result-exp=@]
    $(e t.e, ops ~, nums ~, res 0, inners 1)
  %_    $
      ops     ~
      inners  (add +(inners) new-inners)
      e       (slag new-inners t.e)
  ::
      nums
    ?.  ?=(^ ops)  [result-exp nums]
    ~[(calculate i.ops [result-exp nums])]
  ::
      res
    ?.  ?=(^ ops)  res
    (calculate i.ops [result-exp nums])
  ==
  ::
  ++  is-r-par  |=(a=@t =(a ')'))
  ++  is-num    |=(a=@t ?=(^ (rush a dem)))
  ++  is-op     |=(a=@t |(=(a '*') =(a '+')))
  ++  is-l-par  |=(a=@t =(a '('))
  --
::
++  calculate
  |=  [op=@t nums=(list @)]
  ?>  ?=([@t @t ~] nums)
  =*  l  i.nums
  =*  r  i.t.nums
  ?:  =(op '*')  (mul l r)
  ?:  =(op '+')  (add l r)
  !!
::
++  part-two
  %+  roll  puzzle-input
  |=  [e=cord total=@]
  (add total (calculate-expression-2 (parse-expression e)))
::
++  calculate-expression-2
  |=  e=(list @t)
  ^-  @
  ::  2 * 3 + (4 * 5)
  ::
  =<  res
  =|  ops=(list @t)
  =|  nums=(list @)
  =|  res=@
  =|  inners=@
  |-  ^-  [@ res=@]
  |^
  ?~  e
    ?>  ?=(^ nums)
    :-  inners
    ?:  =(i.nums res)
      res
    i.nums
  ?:  (is-r-par i.e)
    :-  inners
    ?:  &(?=(^ ops) (is-mul i.ops) ?=(^ nums))
      i.nums
    res
  ?:  ?&  ?=(^ nums)
          &(?=(^ ops) (is-sum i.ops))
          =((lent nums) 1)
          (is-num i.e)
      ==
    :: calculate!
    %_  $
      e       t.e
      ops     t.ops
      nums    ~[(calculate i.ops [(rash i.e dem) nums])]
      res     (calculate i.ops [(rash i.e dem) nums])
      inners  +(inners)
    ==
  ?:  (is-num i.e)  $(nums [(rash i.e dem) nums], e t.e, inners +(inners))
  ?:  (is-sum i.e)  $(ops [i.e ops], e t.e, inners +(inners))
  ?:  (is-mul i.e)
    ::  multiply with whatever comes next
    ::
    =/  [new-inners=@ result-exp=@]
      $(e t.e, ops ~[i.e], nums ~, res 0, inners 1)
    [(add inners new-inners) (calculate i.e [result-exp nums])]
  ?.  (is-l-par i.e)  !!
  =/  [new-inners=@ result-exp=@]
    $(e t.e, ops ~, nums ~, res 0, inners 1)
  %_    $
      e       (slag new-inners t.e)
      ops     ~
      inners  (add +(inners) new-inners)
  ::
      nums
    ?~  nums       ~[result-exp]
    ?.  ?=(^ ops)  [result-exp nums]
    ~[(calculate i.ops [result-exp nums])]
  ::
      res
    ?~  nums       result-exp
    ?.  ?=(^ ops)  res
    (calculate i.ops [result-exp nums])
  ==
  ::
  ++  is-r-par  |=(a=@t =(a ')'))
  ++  is-num    |=(a=@t ?=(^ (rush a dem)))
  ++  is-op     |=(a=@t |(=(a '*') =(a '+')))
  ++  is-mul    |=(a=@t =(a '*'))
  ++  is-sum    |=(a=@t =(a '+'))
  ++  is-l-par  |=(a=@t =(a '('))
  --
--
