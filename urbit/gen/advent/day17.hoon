::
/*  puzzle-input  %txt  /lib/advent/day17/txt
::
:-  %say
|=  *
=<  :-  %noun
    ::  very slow...
    ::
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =/  cubes=(set [x=@s y=@s z=@s])
    =<  cubes
    %+  roll  puzzle-input
    |=  [entry=cord i=@ cubes=(set [x=@s y=@s z=@s])]
    |^
    =+  line=(trip entry)
    :-  +(i)
    (put-in-map (mul i (lent line)) line)
    ::
    ++  put-in-map
      |=  [offset=@ line=tape]
      ^+  cubes
      =<  set
      %+  roll  line
      |=  [=cord i=@ set=_cubes]
      =+  offset=(add offset i)
      =+  width=(lent line)
      :-  +(i)
      ?.  =(cord '#')
        set
      %-  ~(put in set)
      [(new:si | (div offset width)) (new:si | (mod offset width)) -0]
    --
  ::
  |^
  %~  wyt  in
  =<  iter-cubes
  %+  roll  (gulf 0 5)
  |=  [iter=@ iter-cubes=_cubes borders=_(get-borders cubes)]
  =;  phase-cubes
    [phase-cubes (get-borders phase-cubes)]
  ::
  %+  roll  (range -.x.borders +.x.borders)
  |=  [x=@s new-cubes=_iter-cubes]
  ::
  %+  roll  (range -.y.borders +.y.borders)
  |=  [y=@s new-cubes=_new-cubes]
  ::
  %+  roll  (range -.z.borders +.z.borders)
  |=  [z=@s new-cubes=_new-cubes]
  =+  has-cube=(~(has in iter-cubes) [x y z])
  =+  actives=(inspect-around [x y z] iter-cubes)
  ?.  has-cube
    ?.  =(3 actives)
      new-cubes
    (~(put in new-cubes) [x y z])
  ?:  |(=(2 actives) =(3 actives))
    new-cubes
  (~(del in new-cubes) [x y z])
  ::
  ++  inspect-around
    |=  [[x=@s y=@s z=@s] cubes=(set [x=@s y=@s z=@s])]
    =|  actives=@
    =/  nabos=(list [x=@s y=@s z=@s])  around
    :: ~&  [x y z]
    |-  ^-  @
    ?~  nabos  actives
    =+  op=i.nabos
    =/  nabo=[@s @s @s]
      :+  (sum:si x.op x)
        (sum:si y.op y)
      (sum:si z.op z)
    :: =+  has=(~(get by cubes) nabo)
    :: ~&  [nabo (~(has in iter-cubes) nabo)]
    %_  $
      nabos    t.nabos
      actives  ?.((~(has in cubes) nabo) actives +(actives))
    ==
  ::
  ++  around
    %+  roll  (range -0 -0)
    |=  [x=@s vectors=(list [x=@s y=@s z=@s])]
    %+  roll  (range -0 -0)
    |=  [y=@s vectors=_vectors]
    %+  roll  (range -0 -0)
    |=  [z=@s vectors=_vectors]
    ?:  &(=(x -0) =(y -0) =(z -0))
      vectors
    [[x y z] vectors]
    :: :~  [--1 --1 -0]   [--1 -0 -0]   [--1 -1 -0]
    ::     [-0 --1 -0]             [-0 -1 -0]
    ::     [-1 --1 -0]  [-1 -0 -0]  [-1 -1 -0]
    ::     ::
    ::     [--1 --1 -1]  [--1 -0 -1]   [--1 -1 -1]
    ::     [-0 --1 -1]   [-0 -0 -1]  [-0 -1 -1]
    ::     [-1 --1 -1]   [-1 -0 -1]  [-1 -1 -1]
    ::     ::
    ::     [--1 --1 --1]   [--1 -0 --1]   [--1 -1 --1]
    ::     [-0 --1 --1]  [-0 -0 --1]  [-0 -1 --1]
    ::     [-1 --1 --1]  [-1 -0 --1]  [-1 -1 --1]
    :: ==
  ::
  ++  get-borders
    |=  cubes=(set [x=@s y=@s z=@s])
    %+  roll  ~(tap in cubes)
    |=  [[x=@s y=@s z=@s] b=[x=[@s @s] y=[@s @s] z=[@s @s]]]
    :+  :-  ?:(=(--1 (cmp:si x -.x.b)) x -.x.b)
        ?:(=(-1 (cmp:si x +.x.b)) x +.x.b)
      :-  ?:(=(--1 (cmp:si y -.y.b)) y -.y.b)
      ?:(=(-1 (cmp:si y +.y.b)) y +.y.b)
    :-  ?:(=(--1 (cmp:si z -.z.b)) z -.z.b)
    ?:(=(-1 (cmp:si z +.z.b)) z +.z.b)
  --
::
++  part-two
  =/  cubes=(set [x=@s y=@s z=@s w=@s])
    =<  cubes
    %+  roll  puzzle-input
    |=  [entry=cord i=@ cubes=(set [x=@s y=@s z=@s w=@s])]
    |^
    =+  line=(trip entry)
    :-  +(i)
    (put-in-map (mul i (lent line)) line)
    ::
    ++  put-in-map
      |=  [offset=@ line=tape]
      ^+  cubes
      =<  set
      %+  roll  line
      |=  [=cord i=@ set=_cubes]
      =+  offset=(add offset i)
      =+  width=(lent line)
      :-  +(i)
      ?.  =(cord '#')
        set
      %-  ~(put in set)
      :^    (new:si | (div offset width))
          (new:si | (mod offset width))
        -0
      -0
    --
  ::
  |^
  %~  wyt  in
  =<  iter-cubes
  %+  roll  (gulf 0 5)
  |=  [iter=@ iter-cubes=_cubes borders=_(get-borders cubes)]
  =;  phase-cubes
    [phase-cubes (get-borders phase-cubes)]
  %+  roll  (range -.x.borders +.x.borders)
  |=  [x=@s new-cubes=_iter-cubes]
  ::
  %+  roll  (range -.y.borders +.y.borders)
  |=  [y=@s new-cubes=_new-cubes]
  ::
  %+  roll  (range -.z.borders +.z.borders)
  |=  [z=@s new-cubes=_new-cubes]
  ::
  %+  roll  (range -.w.borders +.w.borders)
  |=  [w=@s new-cubes=_new-cubes]
  =+  has-cube=(~(has in iter-cubes) [x y z w])
  =+  actives=(inspect-around [x y z w] iter-cubes)
  ?.  has-cube
    ?.  =(3 actives)
      new-cubes
    (~(put in new-cubes) [x y z w])
  ?:  |(=(2 actives) =(3 actives))
    new-cubes
  (~(del in new-cubes) [x y z w])
  ::
  ++  inspect-around
    |=  [[x=@s y=@s z=@s w=@s] cubes=(set [x=@s y=@s z=@s w=@s])]
    =|  actives=@
    =/  nabos=(list [x=@s y=@s z=@s w=@s])  around
    |-  ^-  @
    ?~  nabos  actives
    =+  op=i.nabos
    =/  nabo=[@s @s @s @s]
      :^    (sum:si x.op x)
          (sum:si y.op y)
        (sum:si z.op z)
      (sum:si w.op w)
    %_  $
      nabos    t.nabos
      actives  ?.((~(has in cubes) nabo) actives +(actives))
    ==
  ::
  ++  around
    %+  roll  (range -0 -0)
    |=  [x=@s vectors=(list [x=@s y=@s z=@s w=@s])]
    %+  roll  (range -0 -0)
    |=  [y=@s vectors=_vectors]
    %+  roll  (range -0 -0)
    |=  [z=@s vectors=_vectors]
    %+  roll  (range -0 -0)
    |=  [w=@s vectors=_vectors]
    ?:  &(=(x -0) =(y -0) =(z -0) =(w -0))
      vectors
    [[x y z w] vectors]
  ::
  ++  get-borders
    |=  cubes=(set [x=@s y=@s z=@s w=@s])
    %+  roll  ~(tap in cubes)
    |=  [[x=@s y=@s z=@s w=@s] b=[x=[@s @s] y=[@s @s] z=[@s @s] w=[@s @s]]]
    :^    :-  ?:(=(--1 (cmp:si x -.x.b)) x -.x.b)
          ?:(=(-1 (cmp:si x +.x.b)) x +.x.b)
        ::
        :-  ?:(=(--1 (cmp:si y -.y.b)) y -.y.b)
        ?:(=(-1 (cmp:si y +.y.b)) y +.y.b)
      ::
      :-  ?:(=(--1 (cmp:si z -.z.b)) z -.z.b)
      ?:(=(-1 (cmp:si z +.z.b)) z +.z.b)
    ::
    :-  ?:(=(--1 (cmp:si w -.w.b)) w -.w.b)
    ?:(=(-1 (cmp:si w +.w.b)) w +.w.b)
  --
::
++  range
  |=  [min=@s max=@s]
  ?>  ?|  =(--1 (cmp:si min max))
          =(--0 (cmp:si min max))
      ==
  =+  left=(sum:si min --1)
  =+  right=(sum:si max -1)
  =|  range=(list @s)
  =+  last=left
  |-  ^+  range
  ?:  =(last right)
    (snoc range last)
  $(last (sum:si last -1), range (snoc range last))
--
