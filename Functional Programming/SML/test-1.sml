(* Первоначальный набор тестов для лабораторной работы №1 *)

(* Задание 1 *)
val test_is_leap_year_1 = is_leap_year 2000 = true 
val test_is_leap_year_2 = is_leap_year 2015 = false
val test_is_leap_year_3 = is_leap_year 15 = false
val test_is_leap_year_4 = is_leap_year ~215 = false
val test_is_leap_year_5 = is_leap_year 244 = true

(* Задание 2 *)
val test_is_correct_date_1 = is_correct_date (1,9,2015) = true
val test_is_correct_date_2 = is_correct_date (21,13,1900) = false
val test_is_correct_date_3 = is_correct_date (~12,3,1857) = false
val test_is_correct_date_4 = is_correct_date (29,2,2004) = true
val test_is_correct_date_5 = is_correct_date (29,2,1900) = false
val test_is_correct_date_6 = is_correct_date (29,2,1100) = false
val test_is_correct_date_7 = is_correct_date (4,7,1100) = true
val test_is_correct_date_8 = is_correct_date (29,8,1100) = true
val test_is_correct_date_9 = is_correct_date (30,4,1100) = true
val test_is_correct_date_10 = is_correct_date (31,10,1100) = true

(* Задание 3 *)
val test_new_style_correction_1 = new_style_correction (1,3,2015) = 13
val test_new_style_correction_2 = new_style_correction (28,2,1700) = 10
val test_new_style_correction_3 = new_style_correction (12,3,1900) = 13
val test_new_style_correction_4 = new_style_correction (31,12,1899) = 12

(* Задание 4 *)
val test_get_nth_real_1 = 
  let val tmp = get_nth_real ([0.25, ~6.15, 8.34, 3e8, 0e0], 3)
  in tmp <= 3e8 andalso tmp >= 3e8
  end
  val test_get_nth_real_2 = 
  let val tmp = get_nth_real ([0.25, ~6.15, 8.34, 3e8, 0e0, 2.23], 2)
  in tmp <= 8.34 andalso tmp >= 8.34
  end

(* Задание 5 *)
val test_get_nth_str_1 = 
  get_nth_str (["hi", "there", "how", "are", "you"], 2) = "how"
val test_get_nth_str_2 = 
  get_nth_str (["hot", "cold", "ice", "scream"], 2) = "ice"

(* Задание 6 *)
(* вещественные числа нельзя сравнивать на равенство*)
val test_last_smaller_1 = 
  let val tmp = last_smaller (3e8, [0e0, 0.25, 8.34, 3e8])  
  in tmp <= 8.34 andalso tmp >= 8.34 
  end
val test_last_smaller_2 = 
  let val tmp = last_smaller (15.7, [2.7, 5.7, 8.9, 15.7])
  in tmp <= 8.9 andalso tmp >= 8.9
  end

(* Задание 7 *)
(* В решении важна только целая часть результата *)
val test_first_new_moon_real_1  = 
  let val tmp = first_new_moon_real (1,9,2015)
  in 
    isSome tmp andalso trunc (valOf tmp) = 13
  end
val test_first_new_moon_real_2  = 
  let val tmp = first_new_moon_real (1,6,2014)
  in 
    isSome tmp andalso trunc (valOf tmp) = 27
  end

(* Задание 8 *)
val test_first_new_moon_1  = first_new_moon (1,9,2015) = SOME (13, 9, 2015)
val test_first_new_moon_2  = first_new_moon (1,6,2014) = SOME (27, 6, 2014)

(* Задание 9 *)
val test_date_to_string_1  = date_to_string (5,5,1980) = "May 5, 1980"
val test_date_to_string_2  = date_to_string (1,9,2015) = "September 1, 2015"
val test_date_to_string_3  = date_to_string (27,8,1995) = "August 27, 1995"
val test_date_to_string_4  = date_to_string (1,1,2444) = "January 1, 2444"

(* Задание 10 *)
val test_is_older_1 = is_older ((1, 2, 3), (2, 3, 4)) = true
val test_is_older_2 = is_older ((2, 3, 4), (1, 2, 3)) = false
val test_is_older_3 = is_older ((12, 3, 224), (13, 3, 224)) = true
val test_is_older_4 = is_older ((13, 3, 224), (13, 3, 224)) = false

(* Задание 11 *)
val test_winter_solstice_1 = winter_solstice 0 = 22
val test_winter_solstice_2 = winter_solstice 2014 = 22
val test_winter_solstice_3 = winter_solstice 2 = 22

(* Задание 12 *)
val test_chinese_new_year_1 = chinese_new_year 1965 = (2,2,1965)
val test_chinese_new_year_2 = chinese_new_year 1962 = (5,2,1962)
val test_chinese_new_year_3 = chinese_new_year 1947 = (22,1,1947)

(* Задание 13 *)
val test_chinese_year_1 = 
  chinese_year 1980 = ("Geng-Shen","White","Monkey","Metal")
val test_chinese_year_2 = 
  chinese_year 2015 = ("Yi-Wei","Green","Sheep","Cut timber")
val test_chinese_year_3 = 
  chinese_year 1997 = ("Ding-Chou","Red","Cow","Artificial fire")

(* Задание 14 *)
val test_date_to_chinese_year_1 = 
  date_to_chinese_year (1, 9, 1980) = ("Geng-Shen","White","Monkey","Metal")
val test_date_to_chinese_year_2 = 
  date_to_chinese_year (1, 9, 2015) = ("Yi-Wei","Green","Sheep","Cut timber")
  val test_date_to_chinese_year_3 = 
  date_to_chinese_year (5, 4, 1997) = ("Ding-Chou","Red","Cow","Artificial fire")

  (* Задание 15 *)
val test_date_to_animal_1 = 
  date_to_animal (1, 9, 1980) = "Monkey"
val test_date_to_animal_2 = 
  date_to_animal (1, 9, 2015) = "Sheep"
  val test_date_to_animal_3 = 
  date_to_animal (5, 4, 1997) = "Cow"

(* Задание 16 *)
val test_animal_1 = 
  animal ("Ivan", (1, 9, 1980)) = "Monkey"
val test_animal_2 = 
  animal ("Svetlana", (1, 9, 2015)) = "Sheep"
  val test_animal_3 = 
  animal ("Daniil", (5, 4, 1997)) = "Cow"

(* Вспомогательная функция для тестирования заданий 17 и 18
 * выдает true, когда элемент a присутствует в списке l 
 * иначе выдает false *)
fun member ( a : string * (int * int * int)
           , l : (string * (int * int * int)) list
           ) : bool =
  if null l then false
  else a = hd l orelse member (a, tl l)

(* Задание 17 *)
val test_extract_animal_1 = 
  extract_animal ( [ ("Ivan", (1, 9, 1980))
                   , ("Svetlana", (1, 9, 2015)) ]
                 , "Monkey" ) 
  = [("Ivan", (1, 9, 1980))]
val test_extract_animal_2 = 
  let val tmp = extract_animal ( [ ("Ivan", (1, 9, 1980))
                                 , ("Svetlana", (1, 9, 2015))
                                 , ("Alex", (1, 9, 1955)) 
                                 ]
                               , "Sheep" )
  in
    member (("Svetlana", (1, 9, 2015)), tmp)
    andalso member (("Alex", (1, 9, 1955)), tmp)
    andalso length tmp = 2
  end
val test_extract_animal_3 = 
  let val tmp = extract_animal ( [ ("Daniil", (1, 9, 1980))
                                 , ("Svetlana", (11, 2, 2098))
                                 , ("Alex", (5, 4, 1955))
                                 , ("Ivan", (2, 6, 1992)) 
                                 ]
                               , "Monkey" )
  in
    member (("Daniil", (1, 9, 1980)), tmp)
    andalso member (("Ivan", (2, 6, 1992)), tmp)
    andalso length tmp = 2
  end

(* Задание 18 *)
val test_extract_animals_1 = 
  extract_animals ( [ ("Ivan", (1, 9, 1980))
                    , ("Svetlana", (1, 9, 2015)) ]
                  , ["Monkey"] ) 
  = [("Ivan", (1, 9, 1980))]
val test_extract_animals_2 = 
  let val tmp = extract_animals ( [ ("Ivan", (1, 9, 1980))
                                  , ("Svetlana", (1, 9, 2015)) 
                                  , ("Alex", (1, 9, 1955)) 
                                  ]
                                , ["Monkey", "Sheep"] )
  in
    member (("Svetlana", (1, 9, 2015)), tmp)
    andalso member (("Alex", (1, 9,1955)), tmp)
    andalso member (("Ivan", (1, 9, 1980)), tmp)
    andalso length tmp = 3
  end
val test_extract_animals_3 = 
  extract_animals ( [ ("Ivan", (1, 9, 1980))
                    , ("Svetlana", (1, 9, 2015)) ]
                  , ["Sheep"] ) 
  = [("Svetlana", (1, 9, 2015))]

(* Задание 19 *)
val test_oldest_1 = 
  oldest [ ("Ivan", (1, 9, 1980))
         , ("Svetlana", (1, 9, 2015))
         , ("Alex", (1, 9, 1955)) ] 
  = SOME "Alex"
val test_oldest_2 = 
  oldest [ ("Daniil", (5, 4, 1995))
         , ("Maksim", (3, 2, 2001))
         , ("Roman", (3, 4, 1955)) ] 
  = SOME "Roman"

(* Задание 20 *)
val test_oldest_from_animals_1 = 
  oldest_from_animals ( [ ("Ivan", (1, 9, 1980))
                        , ("Svetlana", (1, 9, 2015)) 
                        , ("Alex", (1, 9, 1955)) 
                        ]
                      , ["Monkey", "Sheep"] ) 
  = SOME "Alex"
val test_oldest_from_animals_2 = 
  oldest_from_animals ( [ ("Daniil", (5, 4, 1995))
                        , ("Maksim", (3, 2, 2001))
                        , ("Roman", (3, 4, 1955)) ]
                      , ["Monkey", "Sheep", "Tiger","Rat","Cow"] ) 
  = SOME "Roman"