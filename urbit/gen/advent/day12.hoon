::
/*  puzzle-input  %txt  /lib/advent/day12/txt
=/  max=@  (sub (lent ^-(wain puzzle-input)) 1)
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
::
++  convert-val
  |=  [act=@t val=@]
  ^-  @s
  ?:  |(=(act 'N') =(act 'E'))
    (new:si | val)
  ?.  |(=(act 'S') =(act 'W'))  *@s
  (new:si & val)
::
++  apply-direction
  |=  [direction=@t val=@s ship=[x=@s y=@s]]
  ^+  ship
  ?:  |(=(direction 'N') =(direction 'S'))
    ship(y (sum:si y.ship val))
  ?.  |(=(direction 'E') =(direction 'W'))  !!
  ship(x (sum:si x.ship val))
::
++  phase-to-grad
  |=  phase=@t
  ^-  @s
  ?:  =(phase 'N')  -90
  ?:  =(phase 'S')  -270
  ?:  =(phase 'E')  -0
  ?.  =(phase 'W')  !!
  -180
::
++  grad-to-phase
  |=  grad=@s
  ^-  @t
  ?:  |(=(grad -90) =(grad --270))
    'N'
  ?:  |(=(grad -270) =(grad --90))
    'S'
  ?:  ?|  =(grad -0)
          =(grad --0)
          =(grad --360)
          =(grad -360)
      ==
    'E'
  ?.  |(=(grad -180) =(grad --180))  !!
  'W'
::
++  change-direction
  |=  [act=@t phase=@t val=@]
  ^-  @t
  ?:  =(val 360)  phase
  =+  grad=(phase-to-grad phase)
  :: ~&  [act phase val grad]
  %-  grad-to-phase
  ?:  =(act 'R')
    (rem:si (dif:si grad (new:si | val)) -360)
  ?.  =(act 'L')  !!
  (rem:si (sum:si grad (new:si | val)) -360)
::
++  apply-action
  |=  [ship=[x=@s y=@s] act=@t val=@ phase=@t]
  ^+  [ship phase]
  ?:  =(act 'F')
    :_  phase
    (apply-direction phase (convert-val phase val) ship)
  =+  s-val=(convert-val act val)
  ?:  |(=(act 'N') =(act 'S'))
    [ship(y (sum:si y.ship s-val)) phase]
  ?:  |(=(act 'E') =(act 'W'))
    [ship(x (sum:si x.ship s-val)) phase]
  [ship (change-direction act phase val)]
::
++  get-distance
  |=  [x=@s y=@s]
  ^-  @
  (add (abs:si x) (abs:si y))
::
++  part-one
  =|  distance=@
  =<  distance
  %+  roll  puzzle-input
  |=  [e=@t i=@ distance=@ ship=[@s @s] phase=_'E']
  =/  [act=@t val=@]  (rash e ;~(plug aln dem))
  =/  [new-ship=[@s @s] new-phase=@t]
    (apply-action ship act val phase)
  :^    +(i)
      ?.  =(i max)
        distance
      (get-distance new-ship)
    new-ship
  new-phase
::
++  part-two
  =<  distance
  %+  roll  puzzle-input
  |=  $:  e=@t
          i=@
          distance=@
          ship=[@s @s]
          waypoint=_[-10 -1]
      ==
  =/  [act=@t val=@]  (rash e ;~(plug aln dem))
  =/  [new-ship=[@s @s] new-waypoint=[@s @s]]
    (apply-action-2 ship waypoint act val)
  :*  +(i)
      ?.  =(i max)
        distance
      (get-distance new-ship)
      new-ship
      new-waypoint
  ==
::
++  apply-action-2
  |=  [ship=[x=@s y=@s] waypoint=[x=@s y=@s] act=@t val=@]
  ^+  [ship waypoint]
  ?:  =(act 'F')
    :_  waypoint
    (apply-direction-2 ship waypoint val)
  =+  s-val=(convert-val act val)
  ?:  |(=(act 'N') =(act 'S'))
    [ship waypoint(y (sum:si y.waypoint s-val))]
  ?:  |(=(act 'E') =(act 'W'))
    [ship waypoint(x (sum:si x.waypoint s-val))]
  :: R or L (change directions)
  ::
  [ship (change-waypoint waypoint act val)]
::
++  apply-direction-2
  |=  [ship=[x=@s y=@s] waypoint=[x=@s y=@s] val=@]
  ^+  ship
  =/  new-waypoint
    :-  x=(dif:si -0 (pro:si x.waypoint (new:si | val)))
    y=(dif:si -0 (pro:si y.waypoint (new:si | val)))
  %_  ship
    x  (sum:si x.ship x.new-waypoint)
    y  (sum:si y.ship y.new-waypoint)
  ==
::
++  change-waypoint
  |=  [waypoint=[x=@s y=@s] act=@t val=@]
  =/  rotation  (div val 90)
  ?:  =(rotation 4)  waypoint
  |-  ^+  waypoint
  ?:  =(rotation 0)  waypoint
  %_    $
      rotation
    (sub rotation 1)
  ::
      waypoint
    ?:  =(act 'R')
      waypoint(x y.waypoint, y (dif:si -0 x.waypoint))
    ?.  =(act 'L')  !!
      waypoint(x (dif:si -0 y.waypoint), y x.waypoint)
  ==
::
--
