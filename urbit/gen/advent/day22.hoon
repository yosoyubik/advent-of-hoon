:: --- Day 22: Crab Combat ---
::
/*  puzzle-input  %txt  /lib/advent/day22/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 ~] [%2 part-two]]
|%
++  part-one
  =/  [* player-a=(list @) player-b=(list @)]
    (parse-decks puzzle-input)
  %-  reduce-deck
  |-  ^-  (list @)
  :: play!
  ::
  ?~  player-a  player-b
  ?~  player-b  player-a
  =*  a  i.player-a
  =*  b  i.player-b
  =*  loop  $
  |^
  ?:  (gth a b)
    player-a-wins
  player-b-wins
  ::
  ++  player-a-wins
    %_  loop
      player-a  (weld t.player-a ~[a b])
      player-b  t.player-b
    ==
  ::
  ++  player-b-wins
    %_  loop
      player-b  (weld t.player-b ~[b a])
      player-a  t.player-a
    ==
  --
::
++  reduce-deck
  |=  deck=(list @)
  %+  roll  deck
  |=  [num=@ i=_(lent deck) total=@]
  :-  (sub i 1)
  (add total (mul num i))
::
++  parse-decks
  |=  puzzle-input=(list cord)
  %+  roll  puzzle-input
  |=  [e=cord who=@ player-a=(list @) player-b=(list @)]
  ?:  =('' e)  [who player-a player-b]
  =/  new=(unit @)
     (rush e (ifix [(jest 'Player ') col] dem))
  ?^  new
    [u.new player-a player-b]
  =/  num=@  (rash e dem)
  :-  who
  ?:  =(who 1)
    [(snoc player-a num) player-b]
  [player-a (snoc player-b num)]
::
++  part-two
  =/  [* player-a=(list @) player-b=(list @)]
    (parse-decks puzzle-input)
  =|  played=(set [(list @) (list @)])
  ~&  "playing!"
  %-  reduce-deck
  =<  deck
  |-  ^-  [winner=term deck=(list @)]
  :: play!
  ::
  ?~  player-a  [%b player-b]
  ?~  player-b  [%a player-a]
  =*  a  i.player-a
  =*  b  i.player-b
  =*  loop  $
  ::  if there was a previous round in this game that had exactly
  ::  the same cards in the same order in the same players' decks
  ::
  ?:  (~(has in played) [player-a player-b])
    [%a player-a]
  |^
  =.  played  (~(put in played) [player-a player-b])
  =/  winner=term
    ::  If both players have at least as many cards remaining in their deck
    ::  as the value of the card they just drew, the winner of the round
    ::  is determined by playing a new game of Recursive Combat
    ::
    ?:  &((lte a (lent t.player-a)) (lte b (lent t.player-b)))
      ::  sub-game
      ::
      =<  winner
      %_  loop
        player-a  (scag i.player-a t.player-a)
        player-b  (scag i.player-b t.player-b)
      ==
    ?:((gth a b) %a %b)
  ?:(=(%a winner) player-a-wins player-b-wins)
  ::
  ++  player-a-wins
    %_  loop
      player-a  (weld t.player-a ~[a b])
      player-b  t.player-b
    ==
  ::
  ++  player-b-wins
    %_  loop
      player-b  (weld t.player-b ~[b a])
      player-a  t.player-a
    ==
  --
--
