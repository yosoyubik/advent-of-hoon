/*  puzzle-input  %txt  /lib/advent/day11/txt
=/  max=@  (lent ^-(wain puzzle-input))
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 ~] [%2 part-two]]
|%
::
++  get-coordinates
  |=  [i=@ width=@]
  ^-  [x=@ y=@]
  :-  (div i width)
  (mod i width)
::
++  get-index
  |=  [x=@ y=@ width=@]
  (add y (mul width x))
::
++  get-occupied
  |=  [line=tape occs=(set @)]
  ^-  (set @t)
  =;  [@ o=(set @t)]
    o
  %+  roll  line
  |=  [a=@t i=@ o=_occs]
  :-  +(i)
  ?.  =(a '#')
    o
  (~(put in o) i)
::
++  look-around
  |=  [x=@ y=@ seats=tape width=@]
  ?:  =('.' (snag (get-index x y width) seats))
    0
  =/  [rows=(list @) cols=(list @)]
    :-  %+  gulf
          ?:((gth x 0) (sub x 1) x)
        ?:((gte x (sub max 1)) x +(x))
    %+  gulf
      ?:((gth y 0) (sub y 1) y)
    ?:((gte y (sub width 1)) y +(y))
  %+  roll  rows
  |=  [r=@ occupied=@]
  %+  add  occupied
  %+  roll  cols
  |=  [c=@ occupied=@]
  ?:  ?|  =([r c] [x y])
          !=('#' (snag (get-index r c width) seats))
      ==
    occupied
  +(occupied)
::
++  modify-seats
  |=  [i=@ seat=@t seats=tape]
  ;:  weld
    (scag i seats)
    ~[seat]
    (slag +(i) seats)
  ==
::
++  part-one
  ::  very slow!!!
  ::
  =/  [width=@ occupation=(set @) seats=tape]
    %+  roll  puzzle-input
    |=  [entry=cord width=@ occs=(set @t) seats=tape]
    =+  line=(trip entry)
    :+  (lent line)
       (get-occupied line occs)
    (weld seats line)
  =+  current-occupation=occupation
  =+  full-seats=seats
  =+  current-seats=seats
  =|  i=@
::   ~&  seats
  %~  wyt  in
  |-  ^+  occupation
  ?~  seats
    =/  stop=?
      .=  ~(wyt in occupation)
      ~(wyt in (~(uni in occupation) current-occupation))
    ?:  =(~(wyt in occupation) ~(wyt in current-occupation))
        ~&  %end
        occupation
    %_  $
      i                   0
      current-occupation  occupation
      full-seats          current-seats
      seats               current-seats
    ==
  =*  seat  i.seats
  =/  [x=@ y=@]  (get-coordinates i width)
  =/  occupied=@  (look-around x y full-seats width)
  %_    $
      i           +(i)
      seats       t.seats
      current-seats
    ?:  &(=(seat 'L') =(occupied 0))
      (modify-seats i '#' current-seats)
    ?.  &(=(seat '#') (gte occupied 4))
      current-seats
    (modify-seats i 'L' current-seats)
  ::
      occupation
    ?:  &(=(seat 'L') =(occupied 0))
      (~(put in occupation) i)
    ?.  &(=(seat '#') (gte occupied 4))
      occupation
    (~(del in occupation) i)
  ==
::
++  put-in-map
  |=  [offset=@ line=tape seats=(map @ cord)]
  ^+  seats
  =<  map
  %+  roll  line
  |=  [=cord [i=@ map=_seats]]
  :-  +(i)
  :: ?:  =(cord '.')  map
  (~(put by map) [(add offset i) cord])
::
++  part-one-one
  ::  also slow!
  ::
  =/  [i=@ width=@ seats-map=(map @ cord) seats=tape]
    %+  roll  puzzle-input
    |=  [entry=cord i=@ width=@ seats-map=(map @ cord) seats=tape]
    =+  line=(trip entry)
    :*  +(i)
        (lent line)
        (put-in-map (mul i (lent line)) line seats-map)
        (weld seats line)
    ==
  =|  occupation=(set @)
  =|  current-occupation=(set @)
  =/  current-seats  seats-map
  =|  i=@
  %~  wyt  in
  |-  ^+  occupation
  ?.  (lth i (mul max width))
    =/  stop=?
      .=  ~(wyt in occupation)
      ~(wyt in (~(uni in occupation) current-occupation))
    ?:  =(~(wyt in occupation) ~(wyt in current-occupation))
        ~&  %end
        occupation
    %_  $
      i                   0
      current-occupation  occupation
      seats-map           current-seats
    ==
  =/  seat=@t     (~(got by seats-map) i)
  =/  [x=@ y=@]   (get-coordinates i width)
  =/  occupied=@  (look-around-1-1 x y seats-map width)
  %_    $
      i           +(i)
      current-seats
    ?:  &(=(seat 'L') =(occupied 0))
      (~(put by current-seats) [i '#'])
    ?.  &(=(seat '#') (gte occupied 4))
      current-seats
    (~(put by current-seats) [i 'L'])
  ::
      occupation
    ?:  &(=(seat 'L') =(occupied 0))
      (~(put in occupation) i)
    ?.  &(=(seat '#') (gte occupied 4))
      occupation
    (~(del in occupation) i)
  ==
::
++  inspect-around
  |=  [x=@ y=@ seats=(map @ cord) width=@]
  ?:  =('.' (~(got by seats) (get-index x y width)))
    0
  :: ~&  begin+[(~(got by seats) (get-index x y width)) x y (get-index x y width)]
  :: ~&  len+~(wyt by seats)
  =|  occupied=@
  =/  remain-ops=(set [@s @s])
    %-  sy
    :~  [--1 --1]  [--1 -0]  [--1 -1]
        [-0 --1]             [-0 -1]
        [-1 --1]   [-1 -0]   [-1 -1]
    ==
  |-  ^-  @
  ?:  =(0 ~(wyt in remain-ops))
    :: ~&  occupied
    occupied
  =;  [occs=@ new-ops=(set [@s @s])]
    $(occupied (add occs occupied), remain-ops new-ops)
  :: ~&  [~(wyt in remain-ops) ~(tap in remain-ops)]
  %+  roll  ~(tap in remain-ops)
  |=  [op=[x=@s y=@s] occupied=@ current-ops=_remain-ops]
  =/  [n-x=@s n-y=@s]
    :-  (sum:si x.op (new:si | x))
    (sum:si y.op (new:si | y))
  ?:  ?|  &((syn:si n-x) !=(--0 n-x))
          &((syn:si n-y) !=(--0 n-y))
          (gth (abs:si n-y) (sub width 1))
          (gth (abs:si n-x) (sub max 1))
      ==
    :: ~&  [no-op+op [n-x n-y]]
    :-  occupied
    (~(del in current-ops) op)
  :: ~&  [seats (get-index (abs:si n-x) (abs:si n-y) width)]
  :: ~&  [op [n-x n-y] (~(get by seats) (get-index (abs:si n-x) (abs:si n-y) width))]
  :: ~&  [op n-x n-y (get-index (abs:si n-x) (abs:si n-y) width)]
  =/  nabo-seat
    (~(got by seats) (get-index (abs:si n-x) (abs:si n-y) width))
  :: ~&  nabo-seat
  ?:  =('.' nabo-seat)
    :-  occupied
    (~(put in (~(del in current-ops) op)) (extend-op op))
  :_  (~(del in current-ops) op)
  ?.  =('#' nabo-seat)
    occupied
  +(occupied)
::
++  extend-op
  |=  [r=@s c=@s]
  :-  ?:  =(-0 r)
        r
      (sum:si ?:((syn:si r) --1 -1) r)
  ?:  =(-0 c)
    c
  (sum:si ?:((syn:si c) --1 -1) c)
::
++  look-around-1-1
  |=  [x=@ y=@ seats=(map @ cord) width=@]
  ?:  =('.' (~(got by seats) (get-index x y width)))
    0
  =/  [rows=(list @) cols=(list @)]
    :-  %+  gulf
          ?:((gth x 0) (sub x 1) x)
        ?:((gte x (sub max 1)) x +(x))
    %+  gulf
      ?:((gth y 0) (sub y 1) y)
    ?:((gte y (sub width 1)) y +(y))
  %+  roll  rows
  |=  [r=@ occupied=@]
  %+  add  occupied
  %+  roll  cols
  |=  [c=@ occupied=@]
  =+  seat=(~(got by seats) (get-index r c width))
  ?:  ?|  =([r c] [x y])
          !=('#' seat)
      ==
    occupied
  +(occupied)
::
++  part-two
  =/  [i=@ width=@ seats-map=(map @ cord) seats=tape]
    %+  roll  puzzle-input
    |=  [entry=cord i=@ width=@ seats-map=(map @ cord) seats=tape]
    =+  line=(trip entry)
    :*  +(i)
        (lent line)
        (put-in-map (mul i (lent line)) line seats-map)
        (weld seats line)
    ==
  =|  occupation=(set @)
  =|  last-occupation=(set @)
  =/  current-seats  seats-map
  =|  i=@
  :: (inspect-around 3 3 seats-map width)
  %~  wyt  in
  |-  ^+  occupation
  ?.  (lth i (mul max width))
    :: =/  stop=?
    ::   .=  ~(wyt in occupation)
    ::   ~(wyt in (~(uni in occupation) last-occupation))
    ?:  =(~(wyt in occupation) ~(wyt in last-occupation))
        ~&  %end
        occupation
    ~&  curent+~(wyt in occupation)
    %_  $
      i                0
      last-occupation  occupation
      seats-map        current-seats
    ==
  =/  seat=@t     (~(got by seats-map) i)
  =/  [x=@ y=@]   (get-coordinates i width)
  =/  occupied=@  (inspect-around x y seats-map width)
  :: ~&  occupied+occupied
  =/  [new-seats=(map @ @t) new-occupation=(set @)]
    ?:  &(=(seat 'L') =(occupied 0))
      [(~(put by current-seats) [i '#']) (~(put in occupation) i)]
    ?.  &(=(seat '#') (gte occupied 5))
      [current-seats occupation]
    [(~(put by current-seats) [i 'L']) (~(del in occupation) i)]
  %_    $
      i              +(i)
      current-seats  new-seats
      occupation     new-occupation
  ==
--
