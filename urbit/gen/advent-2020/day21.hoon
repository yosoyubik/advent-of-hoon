:: --- Day 21: Allergen Assessment ---
::
/*  puzzle-input  %txt  /lib/advent-2020/day21/txt
::
:-  %say
|=  *
=<  :-  %noun
    [[%1 part-one] [%2 part-two]]
|%
++  part-one
  =/  [allergens=(map @t (set tape)) ingredients=(map tape @)]
    parse-food
  ::
  :: ~&  ingredients
  :: ~&  allergens
  =/  all-ingredients=(set tape)
    %+  roll  ~(val by allergens)
    |=  [ingredients=(set tape) all=(set tape)]
    (~(uni in all) ingredients)
  :: ~&  all-ingredients
  %+  roll  ~(tap by ingredients)
  |=  [[ingredient=tape count=@] total=@]
  ?:  (~(has in all-ingredients) ingredient)
    total
  (add total count)
::
++  part-two
  =/  [allergens=(map @t (set tape)) ingredients=(map tape @)]
    parse-food
  =/  sort-allergens=(list [allergen=@t ingredients=(set tape)])
    (sort-allergens-by-count allergens)
  :: =/  all-allergens=(set tape)
  ::   %+  roll  ~(tap by allergens)
  ::   |=  [[allerg=@t *] all=(set tape)]
  ::   (~(put in all) allerg)
  :: %+  roll  sort-allergens
  ~&  allergens
  =|  allergens-copy=_sort-allergens
  =|  dangerous=(map @t tape)
  =|  founds=(set tape)
  |-  ::^-  (map @t tape)
  ?:  =(0 ~(wyt by allergens))
    (produce-dangerous-list dangerous)
  ?~  sort-allergens
    :: we have some left
    ~&  "again"
    ~&  ~(wyt by allergens)
    $(sort-allergens (sort-allergens-by-count allergens))
  :: ?:  =(0 (lent allergens-copy))
  ::   :: done!
  ::   ~&  "done"
  ::   :: ~&  founds
  ::   :: ~&  dangerous
  ::   (sort-allergens-by-name dangerous)
  =*  allergen  allergen.i.sort-allergens
  =*  ingredients  ingredients.i.sort-allergens
  :: ~&  [allergen ingredients]
  :: ~&  founds
  =+  diff=(~(dif in ingredients) founds)
  :: ~&  ~(wyt in diff)
  ?.  =(~(wyt in diff) 1)
    $(sort-allergens t.sort-allergens)
  ::
  =/  ingredient=tape  -:~(tap in diff)
  %_    $
      sort-allergens  t.sort-allergens
      dangerous  (~(put by dangerous) [allergen ingredient])
      founds     (~(put in founds) ingredient)
      allergens  (~(del by allergens) allergen)
  ==
::
++  sort-allergens-by-count
  |=  allergens=(map @t (set tape))
  %+  sort  ~(tap by allergens)
  |=  [[* a=(set tape)] [* b=(set tape)]]
  (lth ~(wyt in a) ~(wyt in b))
::
++  produce-dangerous-list
  |=  allergens=(map @t tape)
  =+  sorted=(sort-allergens-by-name allergens)
  %+  roll  sorted
  |=  [[allergen=@t ingredient=tape] danger=tape]
  (weld danger (weld ingredient ","))
::
++  sort-allergens-by-name
  |=  allergens=(map @t tape)
  %+  sort  ~(tap by allergens)
  |=  [[a=@t *] [b=@t *]]
  (lth -:(trip a) -:(trip b))
::
++  parse-food
  %+  roll  puzzle-input
  |=  [e=cord allergens=(map @t (set tape)) total=(map tape @)]
  =/  [ingredients=(set tape) contains=(list tape)]
    (extract (trip e))
  |^  [populate-allergens populate-ingredients]
  ::
  ++  populate-allergens
    %+  roll  contains
    |=  [allergen=tape allergens=_allergens]
    =+  allerg=(crip allergen)
    %+  ~(put by allergens)
      allerg
    ?.  (~(has by allergens) allerg)
      ingredients
    %-  ~(int in ingredients)
    (~(got by allergens) allerg)
  ::
  ++  populate-ingredients
    %+  roll  ~(tap by ingredients)
    |=  [ingredient=tape total=_total]
    %+  ~(put by total)
      ingredient
    ?.  (~(has by total) ingredient)
      1
    +((~(got by total) ingredient))
  --
::
++  extract
  |=  =tape
  ^-  [(set ^tape) (list ^tape)]
  ::  'mxmxvkd kfcds sqjhc nhms (contains dairy, fish)'
  ::
  =/  sep=@  -:(fand " (contains" tape)
  |^  [ingredients allergens]
  ::
  ++  ingredients
    %-  sy
    (scan (scag sep tape) (more ace (star aln)))
  ::
  ++  allergens
    %+  scan
      (slag (add sep (lent " (contains ")) tape)
    ;~(sfix (more ;~(plug com ace) (star aln)) par)
  --
--
