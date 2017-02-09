(* Шаблон для выполнения заданий лабораторной работы №1 *)

(* Задание 1 is_leap_year *)
fun is_leap_year (n) =
  if n mod 4 = 0 andalso n mod 100 <> 0 orelse n mod 400 = 0
  then true
  else false

(* Задание 2 is_correct_date *)
fun is_correct_date (date : int * int * int) : bool =
  if #3 date >= 2 andalso #3 date <= 6999
                  andalso #2 date >= 1 andalso #2 date <= 12
                  andalso #1 date >= 1 andalso #1 date <= 31
  then if #2 date mod 2 <> 0 andalso #2 date > 8
                             andalso #1 date >= 31
       then false
       else if #2 date mod 2 = 0 andalso #2 date < 8
                                  andalso #2 date <> 2
                                  andalso #1 date >= 31
            then false
            else if #2 date = 2
                 then if is_leap_year(#3 date) andalso #1 date <= 29
                      then true
                      else false
                 else true
  else false

(* Задание 3 new_style_correction *)
fun new_style_correction (date : int * int * int) : int =
  let
    fun d100 (a, n) =
      if n mod 100 = 0 andalso n mod 400 <> 0
      then d100(a + 1, n - 1)
      else if n > 99
           then d100 (a, n - 1)
           else a
  in
    if #2 date >= 3
    then d100 (~2, #3 date)
    else d100 (~2, #3 date - 1)
  end

  (* Задание 4 get_nth_real *)
  fun get_nth_real (L : real list, n : int) : real =
    if n = 0
    then hd L
    else get_nth_real(tl L, n - 1)

(* Задание 5 get_nth_str *)
fun get_nth_str (L : string list, n : int) : string =
    if n = 0
    then hd L
    else get_nth_str (tl L, n - 1)

(* Задание 6 last_smaller *)
fun last_smaller (amount : real, L : real list) : real =
  let
    fun gg (rez : real, l : real list) =
      if null l orelse hd l >= amount
      then rez
      else gg (hd l, tl l)
  in
    gg (0.0, L)
  end

(* Списки для выполнения задания 8 (списки поправок) *)
(* поправка на тысячи года *)
val thousand_correction = [  0.0, 13.9, 27.7, 12.1, 25.9, 10.3, 24.2 ]
(* поправка на сотни года *)
val hundred_correction  = [  0.0,  4.3,  8.7, 13.0, 17.4
                          , 21.7, 26.0,  0.8,  5.2,  9.5 ]
(* поправка на десятки года *)
val decade_correction   = [  0.0,  9.3, 18.6, 27.9,  7.6
                          , 16.9, 26.2,  6.0, 15.3, 24.6 ]
(* поправка на единицы года *)
val year_correction     = [  0.0, 18.6,  7.8, 26.4, 15.5
                          ,  4.6, 23.3, 12.4,  1.5, 20.2 ]
(* поправка на месяц *)
val month_correction    = [ 13.4, 11.9, 24.2, 22.6, 22.0, 20.6
                          , 20.0, 18.4, 17.0, 16.6, 15.1, 14.8 ]
(* календарная поправка *)
val calendar_correction = [0.0, 0.2, 0.5, 0.8]
(* поправка для нормализации дня месяца *)
val reductions = [29.5, 59.1, 88.6, 118.1]

(* Задание 7 first_new_moon_real *)
fun first_new_moon_real (date : int * int * int) : real option =
  let
  fun ggwp (god : int, mesec : int, den : int) : real=
    let
        val rez = real (new_style_correction (den, mesec, god))
        val iter = god mod 10
        val rez = rez + get_nth_real (year_correction, iter)
        val iter = god div 10 mod 10
        val rez = rez + get_nth_real (decade_correction, iter)
        val iter = god div 100 mod 10
        val rez = rez + get_nth_real (hundred_correction, iter)
        val iter = god div 1000 mod 10
        val rez = rez + get_nth_real (thousand_correction, iter)
        val rez = rez + get_nth_real (month_correction, mesec - 1)
        val rez = rez + get_nth_real (calendar_correction, god mod 4)
        val rez = rez - last_smaller (rez - 1.0, reductions)
    in rez
    end
  in
    if #2 date <= 2
    then if #2 date = 2
         then if ggwp (#3 date - 1, #2 date, #1 date) < 29.0
              then SOME (ggwp (#3 date - 1, #2 date, #1 date))
              else NONE
         else SOME (ggwp (#3 date - 1, #2 date, #1 date))
    else SOME (ggwp (#3 date, #2 date, #1 date))
  end

(* Задание 8 first_new_moon *)
fun first_new_moon (date : int * int * int) : (int * int * int) option =
  let
    val rez = first_new_moon_real (#1 date, #2 date, #3 date)
  in
    if isSome rez
     then SOME (trunc(valOf(rez)), #2 date, #3 date)
    else NONE
  end

(* Задание 9 date_to_string *)
fun date_to_string (date : int * int * int) : string =
  let
    val L = ["January", "February", "March", "April", "May",
             "June", "July", "August", "September", "October",
             "November", "December"] : string list
    fun get_month (i : int, n : int) : string =
      if i = n
      then get_nth_str (L, i) ^ " " ^
        Int.toString (#1 date) ^ ", " ^ Int.toString(#3 date)
      else get_month (i + 1, n)
  in
    get_month(0, #2 date - 1)
  end
 
(* Задание 10 is_older *)
fun is_older (date : int * int * int, date2 : int * int * int) : bool =
  if #3 date < #3 date2
  then true
  else if #3 date = #3 date2
       then if #2 date < #2 date2
            then true
            else if #2 date = #2 date2
                 then if #1 date < #1 date2
                      then true
                      else false
                 else false
       else false

(* Задание 11 winter_solstice *)
fun winter_solstice (n : int) : int =
  let
    fun gg (i : real, r : int) : int =
      if r <= n
      then if is_leap_year(r)
           then gg (i - 0.7578, r + 1)
           else gg (i + 0.2422, r + 1)
      else trunc i
  in
    gg (22.5, 1)
  end

(* Задание 12 chinese_new_year *)
fun chinese_new_year (god : int) : (int * int * int) =
  let
    val m1 = 12
    val d1 = winter_solstice (god)
    val d2 = valOf(first_new_moon_real (d1, m1, god - 1))
    val d3 = d2 + 59.1 - 61.0
    val d4 = d2 + 29.5 - 30.0
  in
    if d2 <= real d1
    then (trunc (d3), 2, god)
    else (trunc (d4), 1, god)
  end

(* Списки для выполнения задания 13 *)
(* список небесных стихий (по-китайски) *)
val celestial_chi   = [ "Jia", "Yi", "Bing", "Ding", "Wu"
                      , "Ji", "Geng", "Xin", "Ren", "Gui" ] 
(* список небесных стихий (по-английски) *)
val celestial_eng   = [ "Growing wood", "Cut timber", "Natural fire"
                      , "Artificial fire", "Earth", "Earthenware"
                      , "Metal", "Wrought metal", "Running water"
                      , "Standing water" ]
(* цвета, соответствующие небесным стихиям *)
val celestial_color = ["Green", "Red", "Brown", "White", "Black"] 
(* список земных стихий (по-китайски) *)
val terrestrial_chi = [ "Zi", "Chou", "Yin", "Mao"
                      , "Chen", "Si", "Wu", "Wei"
                      , "Shen", "You", "Xu", "Hai" ]
(* список земных стихий (по-английски) *)
val terrestrial_eng = [ "Rat", "Cow", "Tiger", "Rabbit"
                      , "Dragon", "Snake", "Horse", "Sheep"
                      , "Monkey", "Chicken", "Dog", "Pig" ]

(* Задание 13 chinese_year *)
fun chinese_year (god : int) : (string * string * string * string) =
  let
    val chi_god = (god + 2396) mod 60
    val chi1 = chi_god mod 10
    val chi2 = chi1 div 2
    val chi3 = chi_god mod 12
  in
    (get_nth_str (celestial_chi, chi1) ^ "-" ^
      get_nth_str (terrestrial_chi, chi3),
      get_nth_str (celestial_color, chi2),
      get_nth_str (terrestrial_eng, chi3),
      get_nth_str (celestial_eng, chi1))
  end

(* Задание 14 date_to_chinese_year *)
fun date_to_chinese_year (date : int * int * int) :
  (string * string * string * string) =
  let
    val god = #3 date
    val god1 = #3 date - 1
  in
    if is_older ((#1 date, #2 date, #3 date), (chinese_new_year (#3 date)))
    then chinese_year god1
    else chinese_year god
  end

(* Задание 15 date_to_animal *)
fun date_to_animal (date : int * int * int) : string =
  #3 (date_to_chinese_year (#1 date, #2 date, #3 date))

(* Задание 16 animal *)
fun animal (string, date: int * int * int) : string =
  date_to_animal (#1 date, #2 date, #3 date)

(* Задание 17 extract_animal *)
fun extract_animal ((L : (string * (int * int * int)) list), S : string) :
  (string * (int * int * int)) list =
  let
    fun ng ((L2 : (string * (int * int * int)) list),
            (L3 : (string * (int * int * int)) list), S1: string) =
                if null L2
                then L3
                else if animal (hd L2) = S1
                     then ng (tl L2, hd L2 :: L3, S1)
                     else ng (tl L2, L3, S1)
  in
    ng(L, [], S)
  end

(* Задание 18 extract_animals *)
fun extract_animals ((L : (string * (int * int * int)) list), S : string list) :
  (string * (int * int * int)) list =
  let
    fun ng ((L2 : (string * (int * int * int)) list),
            (L3 : (string * (int * int * int)) list), S1: string list) =
            if null S1
            then L3
            else ng (L2, extract_animal (L2, hd S1) @ L3, tl S1)
  in
    ng(L, [], S)
  end

(* Задание 19 oldest *)
fun oldest (L : (string * (int * int * int)) list) : string option=
  let
    fun get_nth_list ((L1 : (string * (int * int * int)) list), n : int) :
      string * (int * int * int) =
      if n = 0
      then hd L1
      else get_nth_list (tl L1, n - 1)

    fun big_boss ((L2 : (string * (int * int * int)) list),
      n1 : int, K : string * (int * int * int)) :
      string * (int * int * int) =
      if n1 < length L2
      then if is_older (#2 (get_nth_list (L2, n1)), #2 K)
           then big_boss (L2 , n1 + 1, get_nth_list (L2, n1))
           else big_boss (L2 , n1 + 1, K)
      else K
    in
      if null L
      then NONE
      else SOME (#1 (big_boss (L, 0, ("First",(12,12,9999)))))
    end

(* Задание 20 oldest_from_animals *)
fun oldest_from_animals ((L : (string * (int * int * int)) list),
  S : string list) : string option =
  oldest (extract_animals(L, S))

(******************************Thank 4 using******************************)