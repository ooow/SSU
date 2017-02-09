(* Задание 1. get_nth *)
val test_get_nth_1 = get_nth ([0, 1, 2, 3, 4], 2) = 2
val test_get_nth_2 = get_nth (["0", "1", "2", "3", "4"], 2) = "2"
val test_get_nth_3 = get_nth ([0, 1, 2, 3, 4], 5) = 5
                        handle List.Empty => true
val test_get_nth_4 = get_nth ([7, 6, 8, 2, 4], 0) = 7
val test_get_nth_5 = get_nth ([], 0) = 7
                        handle List.Empty => true
(* Задание 2. reverse_append *)
val test_reverse_append_1 = reverse_append ([0, 1, 2, 3], [4, 5, 6]) 
                            = [3, 2, 1, 0, 4, 5, 6]
val test_reverse_append_2 = reverse_append (["0", "1", "2"], [ "3", "4"]) 
                            = ["2", "1", "0", "3", "4"]
val test_reverse_append_3 = reverse_append ([0, 1, 2, 3], []) 
                            = [3, 2, 1, 0]
val test_reverse_append_4 = reverse_append ([], [4, 5, 6]) 
                            = [4, 5, 6]
val test_reverse_append_5 = reverse_append ([], []) 
                            = []

(* Задание 3. card_value *)
val test_card_value_1 = card_value (Red, Num 9) = 9
val test_card_value_2 = card_value (Black, WildDrawFour) = 50
val test_card_value_3 = card_value (Red, Num 0) = 0
val test_card_value_4 = card_value (Black, Wild) = 50
val test_card_value_5 = card_value (Red, Skip) = 20

(* Задание 4. card_count *)
val test_card_count_1 = card_count (Red, Num 0) = 1
val test_card_count_2 = card_count (Black, WildDrawFour) = 4
val test_card_count_3 = card_count (Red, Num 5) = 2
val test_card_count_4 = card_count (Black, Wild) = 4
val test_card_count_5 = card_count (Red, Skip) = 2

(* Задание 5. rank_colors *)
val test_rank_colors_1 = rank_colors Wild = [Black]
val test_rank_colors_2 = rank_colors Skip = [Red, Green, Blue, Yellow]
val test_rank_colors_3 = rank_colors Reverse = [Red, Green, Blue, Yellow]
val test_rank_colors_4 = rank_colors WildDrawFour = [Black]
val test_rank_colors_5 = rank_colors (Num 2) = [Red, Green, Blue, Yellow]

(* Задание 6. sum_cards *)
val test_sum_cards_1 = sum_cards [(Black, Wild), (Red, Num 0)] = 50
val test_sum_cards_2 = sum_cards [(Blue, Num 2), (Red, Num 0)] = 2
val test_sum_cards_3 = sum_cards [ (Red, Num 5) 
                                 , (Black, Wild)
                                 , (Green, Num 0)] = 55
val test_sum_cards_4 = sum_cards [ (Red, Num 7)
                                 , (Green, DrawTwo)
                                 , (Red, Num 5)
                                 , (Black, Wild)] = 82
val test_sum_cards_5 = sum_cards [ (Black, Wild)
                                 , (Red, Num 5)
                                 , (Green, DrawTwo)
                                 , (Red, Num 7)
                                 , (Blue, Skip) ] = 102

(* Задание 7. remove_nth *)
val test_remove_nth_1 = remove_nth ([0, 1, 2, 3, 4], 2) = [0, 1, 3, 4]
val test_remove_nth_2 = remove_nth (["0", "1", "2", "3", "4"], 2) 
                     = ["0", "1", "3", "4"]
val test_remove_nth_3 = remove_nth ([0, 1, 2, 3, 4], 5) = []
                          handle List.Empty => true
val test_remove_nth_4 = remove_nth ([7], 0) = []
val test_remove_nth_5 = remove_nth ([], 0) = [7]
                        handle List.Empty => true

(* Задание 8. remove_card *)
val test_remove_card_1 = remove_card ([], (Blue, Num 2), List.Empty) = []
                            handle List.Empty => true
val test_remove_card_2 = 
    remove_card ([(Blue, Num 2)], (Blue, Num 2), List.Empty) = []
val test_remove_card_3 = 
    remove_card ([(Blue, Num 2), (Red, Num 0)], (Blue, Num 2), List.Empty) = [(Red, Num 0)]
val test_remove_card_4 = 
    remove_card ([ (Red, Num 7)
                 , (Green, DrawTwo)
                 , (Red, Num 5)
                 , (Red, Num 7)], (Red, Num 7), List.Empty) = [ (Green, DrawTwo)
                                                              , (Red, Num 5)
                                                              , (Red, Num 7)]
val test_remove_card_5 = 
    remove_card ([ (Black, Wild)
                 , (Red, Num 7)
                 , (Green, DrawTwo)
                 , (Red, Num 7)
                 , (Blue, Skip) ], (Red, Num 7), List.Empty) = [ (Black, Wild)
                                                               , (Green, DrawTwo)
                                                               , (Red, Num 7)
                                                               , (Blue, Skip) ]

(* Задание 9. insert_elem *)
val test_insert_elem_1 = insert_elem ([], 2, 0) = [2]
val test_insert_elem_2 = insert_elem ([], 2, 1) = [2]
                            handle List.Empty => true
val test_insert_elem_3 = insert_elem ([1,4,8,5], 99, 3) = [1,4,8,99,5]
val test_insert_elem_4 = insert_elem ([8,6,5,4,3], 23, 0) = [23,8,6,5,4,3]
val test_insert_elem_5 = insert_elem ([5,6,7], 76, 3) = [5,6,7,76]

(* Задание 10. interchange *)
val test_interchange_1 = interchange ([0, 1, 2, 3], 1, 3) = [0, 3, 2, 1]
val test_interchange_2 = interchange ([0, 1, 2, 3], 3, 1) = [0, 3, 2, 1]
val test_interchange_3 = interchange ([1,4,8,5], 1, 1) = [1,4,8,5]
val test_interchange_4 = interchange ([8,6,5,4,3], 0, 0) = [8,6,5,4,3]
val test_interchange_5 = interchange ([5,6,7], 0, 2) = [7,6,5]

(* Задание 11. shuffle_list *)
(* ТЕСТЫ НЕ ТРЕБУЮТСЯ *)

(* Задание 12. all_rank_colors *)
val test_all_rank_colors_1 = all_rank_colors Wild = [(Black, Wild)]
val test_all_rank_colors_2 = all_rank_colors WildDrawFour = [(Black, WildDrawFour)]
val test_all_rank_colors_3 = all_rank_colors Skip = [ (Red, Skip)
                                                    , (Green, Skip)
                                                    , (Blue, Skip)
                                                    , (Yellow, Skip)]
val test_all_rank_colors_4 = all_rank_colors (Num 4) = [ (Red, Num 4)
                                                       , (Green, Num 4)
                                                       , (Blue, Num 4)
                                                       , (Yellow, Num 4)]
val test_all_rank_colors_5 = all_rank_colors Reverse = [ (Red, Reverse)
                                                       , (Green, Reverse)
                                                       , (Blue, Reverse)
                                                       , (Yellow, Reverse)]

(* Задание 13. copy_card_n_times *)
val test_copy_card_n_times_1 = 
      copy_card_n_times (Red, Num 0) = [(Red, Num 0)]
val test_copy_card_n_times_2 = 
      copy_card_n_times (Blue, Num 3) = [(Blue,Num 3),(Blue,Num 3)]
val test_copy_card_n_times_3 = 
      copy_card_n_times (Red, Skip) = [(Red,Skip),(Red,Skip)]
val test_copy_card_n_times_4 = 
      copy_card_n_times (Black, WildDrawFour) =[ (Black,WildDrawFour)
                                               , (Black,WildDrawFour)
                                               ,(Black,WildDrawFour)
                                               , (Black,WildDrawFour) ]
val test_copy_card_n_times_5 = 
      copy_card_n_times (Yellow, Reverse) = [(Yellow,Reverse),(Yellow,Reverse)]

(* Задание 14. deck *)
(* Опишите свой тест *)
val test_deck = length deck = 108

(* Задание 15. get_same_rank *)
val test_get_same_rank_1 = 
      get_same_rank (Wild, [(Black, Wild), (Green, Num 0)]) = [(Black, Wild)]
val test_get_same_rank_2 = 
      get_same_rank (DrawTwo, [ (Black, Wild)
                              , (Green, DrawTwo)
                              , (Red, Num 7)
                              , (Blue, Skip) ]) = [(Green,DrawTwo)]
val test_get_same_rank_3 = 
      get_same_rank (Num 5, [ (Red, Num 5)
                           , (Green, DrawTwo)
                           , (Red, Num 5)
                           , (Black, Wild)]) = [(Red,Num 5),(Red,Num 5)] 
val test_get_same_rank_4 = 
      get_same_rank (Wild, [ (Black, Wild)
                           , (Red, Num 5)
                           , (Green, DrawTwo)
                           , (Red, Num 7)
                           , (Black, Wild) ]) = [(Black, Wild), (Black, Wild)]
val test_get_same_rank_5 = 
      get_same_rank (Skip, [(Green, Num 0)]) = []

(* Задание 16. get_same_color *)
val test_get_same_color_1 = 
      get_same_color (Black, [(Black, Wild), (Green, Num 0)]) = [(Black, Wild)]
val test_get_same_color_2 = 
      get_same_color (Green, [ (Black, Wild)
                             , (Green, DrawTwo)
                             , (Red, Num 7)
                             , (Blue, Skip) ]) = [(Green,DrawTwo)]
val test_get_same_color_3 = 
      get_same_color (Red, [ (Red, Num 5)
                           , (Green, DrawTwo)
                           , (Red, Num 5)
                           , (Black, Wild)]) = [(Red,Num 5),(Red,Num 5)] 
val test_get_same_color_4 = 
      get_same_color (Black, [ (Black, Wild)
                           , (Red, Num 5)
                           , (Green, DrawTwo)
                           , (Red, Num 7)
                           , (Black, Wild) ]) = [(Black, Wild), (Black, Wild)]
val test_get_same_color_5 = 
      get_same_color (Yellow, [(Green, Num 0)]) = []

(* Задание 17. has_rank *)
val test_has_rank_1 = 
      has_rank (Wild, [(Black, Wild), (Green, Num 0)]) = true
val test_has_rank_2 = 
      has_rank (Num 5, [(Black, Wild), (Green, Num 0)]) = false
val test_has_rank_3 = 
      has_rank (Num 5, [ (Red, Num 5)
                       , (Green, DrawTwo)
                       , (Red, Num 5)
                       , (Black, Wild)]) = true
val test_has_rank_4 = 
      has_rank (Wild, [ (Black, Wild)
                      , (Red, Num 5)
                      , (Green, DrawTwo)
                      , (Red, Num 7)
                      , (Black, Wild) ]) = true
val test_has_rank_5 = 
      has_rank (Skip, [(Green, Num 0)]) = false


(* Задание 18. has_color *)
val test_has_color_1 = 
      has_color (Black, [(Black, Wild), (Green, Num 0)]) = true
val test_has_color_2 = 
      has_color (Red, [(Black, Wild), (Green, Num 0)]) = false
val test_has_color_3 = 
      has_color (Red, [ (Red, Num 5)
                      , (Green, DrawTwo)
                      , (Red, Num 5)
                      , (Black, Wild)]) = true
val test_has_color_4 = 
      has_color (Black, [ (Black, Wild)
                        , (Red, Num 5)
                        , (Green, DrawTwo)
                        , (Red, Num 7)
                        , (Black, Wild) ]) = true
val test_has_color_5 = 
      has_color (Yellow, [(Green, Num 0)]) = false

(* Задание 19. has_card *)
val test_has_card_1 = 
      has_card ((Black, Wild), [(Black, Wild), (Green, Num 0)]) = true
val test_has_card_2 = 
      has_card ((Red, Num 5), [(Black, Wild), (Green, Num 0)]) = false
val test_has_card_3 = 
      has_card ((Red, Num 5), [ (Red, Num 5)
                              , (Green, DrawTwo)
                              , (Red, Num 5)
                              , (Black, Wild)]) = true
val test_has_card_4 = 
      has_card ((Green, DrawTwo), [ (Black, Wild)
                                  , (Red, Num 5)
                                  , (Green, DrawTwo)
                                  , (Red, Num 7)
                                  , (Black, Wild) ]) = true
val test_has_card_5 = 
      has_card ((Black, Wild), []) = false

(* Задание 20. count_color *)
val test_count_color_1 = 
      count_color (Black, [(Red, Num 5), (Black, Wild), (Green, Num 0)]) = 1
val test_count_color_2 = 
      count_color (Red, [(Red, Num 5), (Black, Wild), (Red, Num 1)]) = 2
val test_count_color_3 = 
      count_color (Black, [ (Black, Wild)
                          , (Red, Num 5)
                          , (Green, DrawTwo)
                          , (Red, Num 7)
                          , (Black, Wild) ]) = 2
val test_count_color_4 = 
      count_color (Green, [ (Red, Num 5)
                          , (Green, DrawTwo)
                          , (Red, Num 5)
                          , (Black, Wild)]) = 1
val test_count_color_5 = 
      count_color (Black, []) = 0

(* Задание 21. max_color *)
val test_max_color_1 = 
      max_color [(Green, Num 5), (Black, Wild), (Green, Num 0)] = Green
val test_max_color_2 = 
      max_color [(Red, Num 5), (Black, Wild), (Red, Num 1)] = Red
val test_max_color_3 = 
      max_color [ (Black, Wild)
                , (Green, Num 5)
                , (Green, DrawTwo)
                , (Red, Num 7)
                , (Black, Wild) ] = Green
val test_max_color_4 = 
      max_color [ (Yellow, Num 5)
                , (Green, DrawTwo)
                , (Red, Num 5)
                , (Black, Wild)] = Red
val test_max_color_5 = 
      max_color [] = Red
(* Задание 22. deal *)
(* ТЕСТЫ НЕ ТРЕБУЮТСЯ *)

(* Вспомогательная функция для сравнения двух игроков 
 * в элементе типа player присутствует функция, а функции 
 * на равенство не сравниваются, поэтому сравнивать на равенство 
 * двух игроков напрямую нельзя,
 * нужно сравнивать только сравнимые элементы *)
fun is_same_player ( { name = n1, cards = cs1, ...} : player
                   , { name = n2, cards = cs2, ...} : player ) =
      n1 = n2 andalso cs1 = cs2

(* Вспомогательная функция для тестирования
 * выдает true, когда элемент a присутствует в списке l 
 * иначе выдает false *)
fun member (_, []) = false
  | member (a, c :: cs) = (a = c) orelse member (a, cs)


(* Задание 23. get_players_first *)
val test_get_players_first_1 = 
  let 
    val tmp = get_players_first { players = [ { name = "Anton"
                                              , cards = []
                                              , strat = false_strategy 
                                              }
                                            , { name = "Andrew"
                                              , cards = []
                                              , strat = false_strategy 
                                              }
                                            ]
                                , pile = []
                                , deck = []
                                , state = Proceed
                                }
  in
    is_same_player (tmp, {name = "Anton", cards = [], strat = false_strategy})
  end

val test_get_players_first_2 = 
  let 
    val tmp = get_players_first { players = [ { name = "Vadim"
                                              , cards = []
                                              , strat = false_strategy 
                                              }
                                            , { name = "Anton"
                                              , cards = []
                                              , strat = false_strategy 
                                              }
                                            , { name = "Andrew"
                                              , cards = []
                                              , strat = false_strategy 
                                              }
                                            ]
                                , pile = []
                                , deck = []
                                , state = Proceed
                                }
  in
    is_same_player (tmp, {name = "Vadim", cards = [], strat = false_strategy})
  end

val test_get_players_first_3 = 
  let 
    val tmp = get_players_first { players = [ { name = "Andrew"
                                              , cards = []
                                              , strat = false_strategy 
                                              }
                                            ]
                                , pile = []
                                , deck = []
                                , state = Proceed
                                }
  in
    is_same_player (tmp, {name = "Andrew", cards = [], strat = false_strategy})
  end

(* Задание 24. get_pile_top *)
val test_get_pile_top_1 = 
      get_pile_top { players = []
                   , pile = [(Black, Wild), (Red, Num 0)]
                   , deck = []
                   , state = Proceed
                   }
      = (Black, Wild)

val test_get_pile_top_2 = 
      get_pile_top { players = []
                   , pile = [(Yellow, Skip)]
                   , deck = []
                   , state = Proceed
                   }
      = (Yellow, Skip)

val test_get_pile_top_3 = 
      get_pile_top { players = []
                   , pile = [(Yellow, Skip), (Black, Wild), (Red, Num 0)]
                   , deck = []
                   , state = Proceed
                   }
      = (Yellow, Skip)


(* Задание 25. next_player *)
val test_next_player_1 = 
  let 
    val tmp = next_player { players = [ { name = "Anton"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Andrew"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      ]
                          , pile = []
                          , deck = []
                          , state = Proceed
                          }
    val tmp1 = get_players_first tmp
  in
    is_same_player (tmp1, {name = "Andrew", cards = [], strat = false_strategy})
  end

val test_next_player_2 = 
  let 
    val tmp = next_player { players = [ { name = "Anton"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Tod"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Alexey"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      ]
                          , pile = []
                          , deck = []
                          , state = Proceed
                          }
    val tmp1 = get_players_first tmp
  in
    is_same_player (tmp1, {name = "Tod", cards = [], strat = false_strategy})
  end

val test_next_player_3 = 
  let 
    val tmp = next_player { players = [ { name = "Alina"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Persey"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Pepsi"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Lunge"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Vinni"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      , { name = "Arkashka"
                                        , cards = []
                                        , strat = false_strategy 
                                        }
                                      ]
                          , pile = []
                          , deck = []
                          , state = Proceed
                          }
    val tmp1 = get_players_first tmp
  in
    is_same_player (tmp1, {name = "Persey", cards = [], strat = false_strategy})
  end
(* Задание 26. change_direction *)
val test_change_direction_1 = 
  let 
    val tmp = change_direction { players = [ { name = "Anton"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           , { name = "Andrew"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           , { name = "Alexey"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           ]
                               , pile = []
                               , deck = []
                               , state = Proceed
                               }
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp2player
                   , {name = "Andrew", cards = [], strat = false_strategy})
  end

val test_change_direction_2 = 
  let 
    val tmp = change_direction { players = [ { name = "Vadim"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           , { name = "Maksim"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           ]
                               , pile = []
                               , deck = []
                               , state = Proceed
                               }
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
  in
    is_same_player ( tmp1player
                   , {name = "Maksim", cards = [], strat = false_strategy} )
  end

val test_change_direction_3 = 
  let 
    val tmp = change_direction { players = [ { name = "Alina"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           , { name = "Persey"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           , { name = "Pepsi"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           , { name = "Lunge"
                                             , cards = []
                                             , strat = false_strategy 
                                             }
                                           ]
                               , pile = []
                               , deck = []
                               , state = Proceed
                               }
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
    val tmp3 = next_player tmp2
    val tmp3player = get_players_first tmp3
  in
    is_same_player ( tmp1player
                   , {name = "Lunge", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp2player
                   , {name = "Pepsi", cards = [], strat = false_strategy})    
    andalso
    is_same_player ( tmp3player
                   , {name = "Persey", cards = [], strat = false_strategy})

  end
(* Задание 27. start *)
(* ДЛЯ СЛУЧАЯ, когда первая карта в колоде pile 
 * - черная карта, ТЕСТЫ НЕ ТРЕБУЮТСЯ *)
val test_start_1 =
  let 
    val tmp = start { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                ]
                    , pile = [(Red, Reverse)]
                    , deck = []
                    , state = Proceed
                    }
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp2player
                   , {name = "Andrew", cards = [], strat = false_strategy})
  end

val test_start_2 =
  let 
    val tmp = start { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                ]
                    , pile = [(Red, Num 2)]
                    , deck = []
                    , state = Proceed
                    }
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp2player
                   , {name = "Anton", cards = [], strat = false_strategy})
    andalso (get_desk_state (start tmp) = Proceed)
  end

val test_start_3 =
  let 
    val tmp = start { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                ]
                    , pile = [(Red, Skip)]
                    , deck = []
                    , state = Proceed
                    }
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp2player
                   , {name = "Anton", cards = [], strat = false_strategy})
    andalso (get_desk_state (start tmp) = Execute)
  end
(* Задание 28. take_1 *)
val test_take_1_1 =
  let 
    val tmp = take_1 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [(Black, Wild)]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [(Black, Wild)]
                     , strat = false_strategy } )
    andalso null tmpdeck
  end

val test_take_1_2 =
  let 
    val tmp = take_1 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [(Yellow, Skip), (Red, Num 9),(Black, Wild)]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [(Yellow, Skip)]
                     , strat = false_strategy } )
    andalso tmpdeck = [(Red,Num 9),(Black,Wild)]
  end

val test_take_1_3 =
  let 
    val tmp = take_1 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse) ,(Yellow, Skip), (Red, Num 9)]
                     , deck = [(Red, Num 9), (Black, Wild)]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [(Red, Num 9)]
                     , strat = false_strategy } )
    andalso tmpdeck = [(Black,Wild)]
  end


(* Задание 29. take_2 *)
val test_take_2_1 =
  let 
    val tmp = take_2 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [(Black, Wild), (Red, Num 5), (Green, DrawTwo)]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp    
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [(Red, Num 5), (Black, Wild)]
                     , strat = false_strategy } )
    andalso tmpdeck = [(Green, DrawTwo)]
  end

val test_take_2_2 =
  let 
    val tmp = take_2 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [(Black, Wild), (Red, Num 5)]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp    
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [(Red, Num 5), (Black, Wild)]
                     , strat = false_strategy } )
    andalso null tmpdeck
  end

val test_take_2_3 =
  let 
    val tmp = take_2 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [ (Black, Wild), (Red, Num 5), (Green, DrawTwo)
                              , (Red, Num 7), (Blue, Skip) ]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp 
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [(Red, Num 5), (Black, Wild)]
                     , strat = false_strategy } )
    andalso tmpdeck = [ (Green, DrawTwo)
                      , (Red, Num 7), (Blue, Skip) ]
  end
(* Задание 30. take_4 *)
val test_take_4_1 =
  let 
    val tmp = take_4 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [ (Black, Wild), (Red, Num 5), (Green, DrawTwo)
                              , (Red, Num 7), (Blue, Skip) ]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp    
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [ (Red, Num 7), (Green, DrawTwo), (Red, Num 5)
                               , (Black, Wild)]
                     , strat = false_strategy } )
    andalso tmpdeck = [(Blue, Skip)]
  end

val test_take_4_2 =
  let 
    val tmp = take_4 { players = [ { name = "Anton"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [ (Black, Wild), (Red, Num 5), (Blue, DrawTwo)
                              , (Red, Num 4), (Blue, Skip)
                              , (Black, Wild), (Red, Num 1), (Yellow, DrawTwo)
                              , (Red, Num 7), (Blue, Skip) ]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp    
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [ (Red, Num 4), (Blue, DrawTwo), (Red, Num 5)
                               , (Black, Wild)]
                     , strat = false_strategy } )
    andalso tmpdeck = [ (Blue, Skip), (Black, Wild), (Red, Num 1), (Yellow, DrawTwo)
                      , (Red, Num 7), (Blue, Skip) ]
  end

val test_take_4_3 =
  let 
    val tmp = take_4 { players = [ { name = "Anton"
                                   , cards = [(Red, Num 7), (Red, Num 1)]
                                   , strat = false_strategy 
                                   }
                                 , { name = "Andrew"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 , { name = "Alexey"
                                   , cards = []
                                   , strat = false_strategy 
                                   }
                                 ]
                     , pile = [(Red, Reverse)]
                     , deck = [ (Red, Num 1), (Yellow, DrawTwo)
                              , (Red, Num 7), (Blue, Skip) ]
                     , state = Proceed
                     }
    val tmpplayer = get_players_first tmp
    val tmpdeck = get_desk_deck tmp    
  in
    is_same_player ( tmpplayer
                   , { name = "Anton"
                     , cards = [ (Blue, Skip), (Red, Num 7)
                               , (Yellow, DrawTwo), (Red, Num 1)
                               , (Red, Num 7), (Red, Num 1) ]
                     , strat = false_strategy } )
    andalso null tmpdeck
  end

(* Задание 31. pass *)
val test_pass_1 =
  let 
    val tmp = pass { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                ]
                    , pile = [(Red, Reverse)]
                    , deck = []
                    , state = Proceed
                    }
    val tmpplayer = get_players_first tmp
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmpplayer
                   , {name = "Andrew", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy})
    andalso
    is_same_player ( tmp2player
                   , {name = "Anton", cards = [], strat = false_strategy})    
  end

val test_pass_2 =
  let 
    val tmp = pass { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                ]
                    , pile = [(Blue, Skip)]
                    , deck = []
                    , state = Execute
                    }
    val tmpplayer = get_players_first tmp
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmpplayer
                   , {name = "Andrew", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy})
    andalso
    is_same_player ( tmp2player
                   , {name = "Anton", cards = [], strat = false_strategy})    
    andalso get_desk_state (pass tmp) = Proceed
  end

val test_pass_3 =
  let 
    val tmp = pass { players = [ { name = "Anton"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Andrew"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                , { name = "Alexey"
                                  , cards = []
                                  , strat = false_strategy 
                                  }
                                ]
                    , pile = [(Blue, DrawTwo)]
                    , deck = [(Red, Skip),(Blue, Num 2)]
                    , state = Execute
                    }
    val tmpplayer = get_players_first tmp
    val tmp1 = next_player tmp
    val tmp1player = get_players_first tmp1
    val tmp2 = next_player tmp1
    val tmp2player = get_players_first tmp2
  in
    is_same_player ( tmpplayer
                   , {name = "Andrew", cards = [], strat = false_strategy} )
    andalso
    is_same_player ( tmp1player
                   , {name = "Alexey", cards = [], strat = false_strategy})
    andalso
    is_same_player ( tmp2player
                   , {name = "Anton", cards = [(Blue, Num 2), (Red, Skip)]
                   , strat = false_strategy})    
    andalso get_desk_state (pass tmp) = Proceed
  end

(* Задание 32. required_color *)
val test_required_color_1 = required_color { players = []
                                           , pile = [(Red, Reverse)]
                                           , deck = []
                                           , state = Proceed
                                           }
                            = Red
val test_required_color_2 = required_color { players = []
                                           , pile = [(Blue, Skip)]
                                           , deck = []
                                           , state = Give Yellow
                                           }
                            = Yellow
val test_required_color_3 = required_color { players = []
                                           , pile = [(Yellow, DrawTwo)]
                                           , deck = []
                                           , state = Execute
                                           }
                            = Yellow


(* Задание 33. playable_cards *)
val test_playable_cards_1 =
  let 
    val tmp = playable_cards { players = [ { name = "Anton"
                                           , cards = [ (Black, Wild)
                                                     , (Red, Num 5)
                                                     , (Green, DrawTwo)
                                                     , (Red, Num 7)
                                                     , (Blue, Skip) ]
                                           , strat = false_strategy 
                                           }
                                         ]
                             , pile = [(Red, Reverse)]
                             , deck = []
                             , state = Proceed
                             }
  in
    member ((Black, Wild), tmp)
    andalso member ((Red, Num 5), tmp)
    andalso member ((Red, Num 7), tmp)
    andalso length tmp = 3
  end

val test_playable_cards_2 =
  let 
    val tmp = playable_cards { players = [ { name = "Anton"
                                           , cards = [ (Black, Wild)
                                                     , (Red, Num 5)
                                                     , (Green, DrawTwo)
                                                     , (Red, Num 7)
                                                     , (Blue, Skip) ]
                                           , strat = false_strategy 
                                           }
                                         ]
                             , pile = [(Red, Reverse)]
                             , deck = []
                             , state = Give Green
                             }
  in
    member ((Black, Wild), tmp)
    andalso member ((Green, DrawTwo), tmp)
    andalso length tmp = 2
  end

val test_playable_cards_3 =
  let 
    val tmp = playable_cards { players = [ { name = "Anton"
                                           , cards = [ (Black, Wild)
                                                     , (Red, Num 2)
                                                     , (Green, DrawTwo)
                                                     , (Green, Num 2)
                                                     , (Blue, Skip) ]
                                           , strat = false_strategy 
                                           }
                                         ]
                             , pile = [(Red, Num 2)]
                             , deck = []
                             , state = Execute
                             }
  in
    member ((Red, Num 2), tmp)
    andalso member ((Green, Num 2), tmp)
    andalso length tmp = 2
  end

(* Задание 34. count_cards *)
val test_count_cards_1 =
  count_cards { players = [ { name = "Anton"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 5)
                                      , (Green, DrawTwo)
                                      , (Red, Num 7)
                                      , (Blue, Skip) ]
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 5) ]
                            , strat = false_strategy 
                            }
                          ]
         , pile = []
         , deck = []
         , state = Proceed
         }
  = [0, 5, 2]

val test_count_cards_2 =
  count_cards { players = [ { name = "Anton"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = false_strategy 
                            }
                          ]
         , pile = []
         , deck = []
         , state = Proceed
         }
  = [0, 0]

val test_count_cards_3 =
  count_cards { players = [ { name = "Anton"
                            , cards = [(Red, Num 5)
                                      , (Green, DrawTwo)
                                      , (Red, Num 7)
                                      , (Blue, Skip) ]
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 5)
                                      , (Green, DrawTwo)
                                      , (Red, Num 7)
                                      , (Blue, Skip) 
                                      , (Red, Num 5)
                                      , (Green, DrawTwo)
                                      , (Red, Num 7)
                                      , (Blue, Skip) ]
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 5) ]
                            , strat = false_strategy 
                            }
                          ]
         , pile = []
         , deck = []
         , state = Proceed
         }
  = [4, 9, 2]

(* Задание 35. has_no_cards *)
val test_has_no_cards_1 =
  has_no_cards {name = "Anton", cards = [], strat = false_strategy} = true
val test_has_no_cards_2 = has_no_cards { name = "Alexey"
                                       , cards = [ (Black, Wild)
                                                 , (Red, Num 5) ]
                                       , strat = false_strategy 
                                       } = false
val test_has_no_cards_3 = has_no_cards { name = "Rediska"
                                       , cards = [(Black, Wild)]
                                       , strat = false_strategy
                                       } = false
(* Задание 36. count_loss *)
val test_count_loss_1 =
  count_loss [ { name = "Anton"
               , cards = []
               , strat = false_strategy 
               }
             , { name = "Andrew"
               , cards = [ (Black, Wild)
                         , (Red, Num 5)
                         , (Green, DrawTwo)
                         , (Red, Num 7)
                         , (Blue, Skip) ]
               , strat = false_strategy 
               }
             , { name = "Alexey"
               , cards = [ (Black, Wild)
                         , (Red, Num 5) ]
               , strat = false_strategy 
               }
             ]
  = [("Anton", 0), ("Andrew", 102), ("Alexey", 55)]

val test_count_loss_2 =
  count_loss [ { name = "Shaurma"
               , cards = [(Red, Num 5)]
               , strat = false_strategy 
               }
             , { name = "Ruby"
               , cards = [ (Red, Num 7)
                         , (Blue, Skip) ]
               , strat = false_strategy 
               }
             , { name = "Java"
               , cards = [ (Black, Wild)
                         , (Red, Num 5) ]
               , strat = false_strategy 
               }
             ]
  = [("Shaurma", 5), ("Ruby", 27), ("Java", 55)]

val test_count_loss_3 =
  count_loss [ { name = "Misha"
               , cards = []
               , strat = false_strategy 
               }
             , { name = "Goga"
               , cards = []
               , strat = false_strategy 
               }
             ]
  = [("Misha", 0), ("Goga", 0)]

(* Задание 37. naive_strategy *)
val test_naive_strategy_1 = naive_strategy ( Execute
                                           , [ (Black, Wild)
                                             , (Red, Num 5)
                                             , (Green, DrawTwo)
                                             , (Red, Num 7)
                                             , (Blue, Skip) ]
                                           , (Red, Skip)
                                           , [] )
                            = ((Blue, Skip), Red)
val test_naive_strategy_2 = 
  let 
    val tmp = naive_strategy ( Give Red
                             , [ (Black, Wild)
                               , (Red, Num 5)
                               , (Green, DrawTwo)
                               , (Red, Num 7)
                               , (Blue, Skip) ]
                             , (Black, WildDrawFour)
                             , [] )
  in #1 tmp = (Red, Num 7)
  end
val test_naive_strategy_3 = 
  let 
    val tmp = naive_strategy ( Proceed
                             , [ (Black, Wild)
                               , (Red, Num 5)
                               , (Green, DrawTwo)
                               , (Red, Num 7)
                               , (Blue, Skip) ]
                             , (Red, Num 1)
                             , [] )
  in #1 tmp = (Red, Num 7)
  end
val test_naive_strategy_4 = 
  let 
    val tmp = naive_strategy ( Give Yellow
                             , [ (Black, Wild)
                               , (Red, Num 5)
                               , (Green, DrawTwo)
                               , (Red, Num 7)
                               , (Blue, Skip) ]
                             , (Red, Num 1)
                             , [] )
  in #1 tmp = (Black, Wild)
  end

val test_naive_strategy_5 = 
  let 
    val tmp = naive_strategy ( Proceed
                             , [ (Black, Wild)
                               , (Green, Num 5)
                               , (Black, WildDrawFour)
                               , (Green, Num 7)
                               , (Blue, Skip) ]
                             , (Yellow, Num 1)
                             , [] );
  in #1 tmp = (Black,WildDrawFour)
  end
(* Задание 38. play *)
val test_play_1 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(Green, Num 5)]
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = false_strategy 
                            }
                          ]
              , pile = [(Green, Num 9)]
              , deck = [(Blue, Num 4)]
              , state = Proceed
              }
    val playcards = playable_cards dsk
    val tmp = play (dsk, playcards)
    val tmpplayer = get_players_first tmp
    val tmppile = get_desk_pile tmp
    val tmpstate = get_desk_state tmp
  in 
    is_same_player (tmpplayer, { name = "Andrew"
                               , cards = []
                               , strat = false_strategy })
    andalso tmppile = [(Green, Num 5), (Green, Num 9)]
    andalso tmpstate = Proceed
  end
val test_play_2 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(Green, Num 5)]
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = false_strategy 
                            }
                          ]
              , pile = [(Blue, Num 9)]
              , deck = [(Blue, Num 4)]
              , state = Proceed
              }
    val playcards = playable_cards dsk
    val tmp = play (dsk, playcards)
  in 
    false
  end
  handle IllegalMove "Anton" => true

val test_play_3 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [ (Black, Wild)
                            , (Red, Num 2)
                            , (Green, DrawTwo)
                            , (Green, Num 2)
                            , (Blue, Skip) ]
                            , strat = false_strategy 
                                           }
                          , { name = "Andrew"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = false_strategy 
                            }
                          ]
              , pile = [(Black, WildDrawFour)]
              , deck = [(Blue, Num 4),(Yellow, Num 1),(Red, Num 2),(Blue, Num 5)]
              , state = Proceed
              }
    val playcards = playable_cards dsk
    val tmp = play (dsk, playcards)
    val tmpplayer = get_players_first tmp
    val tmppile = get_desk_pile tmp
    val tmpstate = get_desk_state tmp
  in 
    is_same_player (tmpplayer, { name = "Andrew"
                               , cards = []
                               , strat = false_strategy })
    andalso tmppile = [(Black,Wild),(Black,WildDrawFour) ]
    andalso tmpstate = Give Green
  end

(* Задание 39. game_step *)
val test_game_step_1 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [(Green, Num 5)]
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = false_strategy 
                            }
                          ]
              , pile = [(Green, Num 9)]
              , deck = [(Blue, Num 4)]
              , state = Proceed
              }
    val tmp = game_step dsk
    val tmpplayer = get_players_first tmp
    val tmppile = get_desk_pile tmp
    val tmpstate = get_desk_state tmp
  in 
    is_same_player (tmpplayer, { name = "Andrew"
                               , cards = []
                               , strat = false_strategy })
    andalso tmppile = [(Green, Num 5), (Green, Num 9)]
    andalso tmpstate = Proceed
  end

val test_game_step_2 =
  let 
    val dsk = { players = [ { name = "Anton"
                            , cards = [ (Blue, Num 7)
                            , (Yellow, Num 2)
                            , (Blue, Skip) ]
                            , strat = false_strategy 
                                           }
                          , { name = "Andrew"
                            , cards = []
                            , strat = false_strategy 
                            }
                          , { name = "Alexey"
                            , cards = []
                            , strat = false_strategy 
                            }
                          ]
              , pile = [(Red, Num 3)]
              , deck = [ (Red, Skip)
                       , (Yellow, Num 1)
                       , (Red, Num 2)
                       ,(Blue, Num 5)]
              , state = Proceed
              }
    val tmp = game_step dsk
    val tmpplayer = get_players_first tmp
    val tmppile = get_desk_pile tmp
    val tmpstate = get_desk_state tmp
  in 
    is_same_player (tmpplayer, { name = "Andrew"
                               , cards = []
                               , strat = false_strategy })
    andalso tmppile = [(Red,Skip), (Red,Num 3)]
    andalso tmpstate = Execute
  end

(* Задание 40. game *)
val test_game_1 =
  let 
    val dsk = { players = [ { name = "Alexey"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 5) ]
                            , strat = false_strategy 
                            }
                          , { name = "Anton"
                            , cards = [(Green, Num 5)]
                            , strat = false_strategy 
                            }
                          , { name = "Andrew"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 5)
                                      , (Green, DrawTwo)
                                      , (Red, Num 7)
                                      , (Blue, Skip) ]
                            , strat = false_strategy 
                            }
                          ]
              , pile = [(Green, Num 9)]
              , deck = [(Blue, Num 4)]
              , state = Proceed
              }
    val tmp = game dsk
  in 
    tmp = ("Anton", [("Andrew", 102), ("Alexey", 55), ("Anton", 0)])
  end
val test_game_2 =
  let 
    val dsk = { players = [ { name = "PUGOVKA"
                            , cards = [ (Black, Wild)
                                      , (Red, Num 3)
                                      , (Green, Skip)
                                      , (Blue, Num 9)
                                      , (Green, Num 4)
                                      , (Yellow, Num 8)
                                      , (Green, Reverse)]
                            , strat = naive_strategy 
                            }
                          , { name = "GOGA"
                            , cards = [ (Black, Wild)
                                      , (Yellow, Num 8)
                                      , (Yellow, Skip)
                                      , (Red, Num 3)
                                      , (Green, Num 5)
                                      , (Yellow, Reverse)
                                      , (Blue, Num 8)]
                            , strat = tirkiya_strategy 
                            }
                          ]
              , pile = [(Blue, Reverse)]
              , deck = [(Blue, Num 4), (Red, Num 0), (Blue, Skip), (Blue, Reverse)
              , (Yellow, Num 0), (Green, Num 1)]
              , state = Proceed
              }
    val tmp = game dsk
  in 
    tmp = ("Anton", [("Alexey", 55), ("Andrew", 102), ("Anton", 0)])
  end