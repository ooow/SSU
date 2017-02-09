(* Шаблон для выполнения заданий лабораторной работы №2 *)

(* Задание 1. get_nth *)
  fun get_nth ([], _) = raise List.Empty
    | get_nth (e :: ee, 0) = e
    | get_nth (e :: ee, n) = get_nth (ee, n - 1)

(* Задание 2. reverse_append *)
fun reverse_append ([], r) = r
  | reverse_append (e :: ee, r) = reverse_append (ee, e :: r)


(****************************************************************************** 
                    Вспомогательные функции и определения
 ******************************************************************************)
(* Выдает "случайное" целое число, на основе текущего времени *)
fun seed () = 
  IntInf.toInt (Time.toMilliseconds (Time.now ()) mod 1000) + 100

(* Превращает некаррированную функцию двух аргументов в каррированную *)
fun curry_2 f x y = f (x, y)

(* Тип данных color для цвета (масти) карт *)
datatype color = Red | Green | Blue | Yellow | Black

(* Тип данных rank для значения карт *)
datatype rank = Skip 
              | DrawTwo 
              | Reverse 
              | Wild 
              | WildDrawFour 
              | Num of int 

(* Тип данных card для карты *)
type card = color * rank

(* Тип данных move для состояния очередного хода *)
datatype move = Proceed | Execute | Give of color 

(* Тип strategy для функции, определяющей стратегию игрока *)
type strategy = move * card list * card * int list -> card * color

(* Тип данных player для игрока *)
type player = {name : string, cards : card list, strat : strategy}

(* Тип данных desk для конфигурации игры *)
type desk = { players : player list
            , pile    : card list
            , deck    : card list
            , state   : move
            }

(* Исключение "Недозволенная игра" *)
exception IllegalGame
(* Исключение "Недозволенный ход". Аргумент - имя игрока, сделавшего ход *)
exception IllegalMove of string 

(* Функции сравнения на равенство значений карт, мастей карт и карт *)
fun is_same_rank  (r1 : rank, r2 : rank) = r1 = r2
fun is_same_color (col1 : color, col2 : color) = col1 = col2
fun is_same_card  (c1 : card, c2 : card) = c1 = c2
(* Функции сравнения на равенство состояний *)
fun is_same_move  (m1 : move, m2 : move) = m1 = m2
(* Список всевозможных значений карт *)
val ranks = [ Num 0, Num 1, Num 2, Num 3, Num 4
            , Num 5, Num 6, Num 7, Num 8, Num 9
            , Skip, DrawTwo, Reverse, Wild, WildDrawFour 
            ]

(* Конструктор значения типа player (игрок) 
 * аргументы имя, список карт и функция стратегии *)
fun make_player (n, cs, f) : player = {name= n, cards = cs, strat = f}

(* Селекторы для игрока *)
fun get_player_name ({name = n, ...} : player) = n
fun get_player_cards ({cards = cs, ...} : player) = cs
fun get_player_strategy ({strat = f, ...} : player) = f 

(* Функция замены набора карт игрока *)
fun set_player_cards (p, new_cs) =
  make_player (get_player_name p, new_cs, get_player_strategy p)

(* Конструктор конфигурации игры *)
fun make_desk (ps, cs, ds, st) : desk = 
  {players = ps, pile = cs, deck = ds, state = st}

(* Селекторы для конфигурации игры *)
fun get_desk_players ({players = ps, ...} : desk) = ps
fun get_desk_pile ({pile = cs, ...} : desk) = cs
fun get_desk_deck ({deck = ds, ...} : desk) = ds
fun get_desk_state ({state = st, ...} : desk) = st

(* Функция замены списка игроков в конфигурации игры *)
fun set_desk_players (dsk, new_players) =
  make_desk ( new_players
            , get_desk_pile dsk
            , get_desk_deck dsk
            , get_desk_state dsk
            )

(* Функция замены состояния очередного хода в конфигурации игры *)
fun set_desk_state (dsk, new_state) =
  make_desk ( get_desk_players dsk
            , get_desk_pile dsk
            , get_desk_deck dsk
            , new_state
            )

(* Функция - фальшивая стратегия игрока: какой бы не был ход, всегда 
 * выкладывается первая карта из списка карт игрока и заказывается 
 * зеленый цвет.
 * Это вспомогательная функция для отладки и тестирования *)
fun false_strategy (_ : move, (c :: _) : card list, _ : card, _ : int list) = 
      (c, Green)
  | false_strategy _ = raise IllegalGame
(******************************************************************************
 ******************************************************************************)

(* Задание 3. card_value *)
fun card_value (e, Num n) = n
  | card_value (e, n) =
  case e of
    Black => 50
    | _ => 20

(* Задание 4. card_count *)
fun card_count (e, Num 0) = 1
  | card_count (Black, _) = 4
  | card_count (e, _) = 2

(* Задание 5. rank_colors *)
fun rank_colors e =
  case e of
    Wild => [Black]
    | WildDrawFour => [Black]
    | _ => [Red, Green, Blue, Yellow]

(* Задание 6. sum_cards *)
fun sum_cards l =
let
  fun gg_wp (l as (e::ee), it) = gg_wp (ee, card_value(e) + it)
    | gg_wp ([], it) = it
in
  gg_wp (l, 0)
end

(* Задание 7. remove_nth *)
fun remove_nth (l, n) =
  let
    fun gg_wp (l as (e :: ee), 0, lw) = reverse_append (lw, ee)
      | gg_wp (l as (e :: ee), n, lw) = gg_wp (ee, n-1, e :: lw)
      | gg_wp ([], n, lw) = raise List.Empty
  in
    gg_wp (l, n, [])
  end

(* Задание 8. remove_card *)
fun remove_card (cs, c, e) =
  let
    fun gg_wp (l as (rc :: cs), lw) =
      if is_same_card (rc, c) 
      then reverse_append (lw, cs)
      else gg_wp (cs, rc :: lw)
      | gg_wp ([], lw) = raise e
  in
    gg_wp (cs, [])
  end

(* Задание 9. insert_elem *)
fun insert_elem (cs, c, n) =
  let
    fun gg_wp (l as (e :: ee), 0, lw) = reverse_append (lw, c :: l)
      | gg_wp (l as (e :: ee), n, lw) = gg_wp (ee, n-1, e :: lw)
      | gg_wp ([], 0, lw) = reverse_append (c :: lw, [])
      | gg_wp ([], n, lw) = raise List.Empty
  in
    gg_wp (cs, n, [])
  end

(*** ШЕДЕВР Задание 10. interchange ШЕДЕВР ***)
fun interchange (cs, i, j) =
  let
    val cs1 = insert_elem (remove_nth (cs, j), get_nth (cs, i), j)
    val cs2 = insert_elem (remove_nth (cs1, i), get_nth (cs, j), i)
  in
    cs2
  end
 
(* Задание 11. shuffle_list *)
fun shuffle_list l =
  let
    val rnd = Random.rand (seed (), 0)
    val get_num = Random.randRange (0, length l - 1)
    fun gg_wp (0, acc) = acc
      | gg_wp (n, acc) = gg_wp (n-1, interchange (acc, n - 1, get_num rnd))
  in
    gg_wp (length l, l)
  end

(* Задание 12. all_rank_colors *)
fun all_rank_colors e =
  let
    fun gg_wp (r, n, l) =
      if n > ~1
      then gg_wp (r, n - 1, (get_nth (rank_colors(e), n), r) :: l)
      else l
  in
    gg_wp (e, length (rank_colors(e)) - 1, [])
  end

(* Задание 13. copy_card_n_times *)
fun copy_card_n_times c =
  let
    fun gg_wp (e, n, l) =
      if n > 0
      then gg_wp (e, n - 1, e :: l)
      else l
  in
    gg_wp (c, card_count c, [])
  end

(* Задание 14. deck *)
val deck = foldr (op @) [] (map copy_card_n_times
             (foldr (op @) [] (map all_rank_colors ranks)))

(*** Вспомогательная функция vозвращающая значение карты,
    второй элемент кортежа ***)
fun get_back (a, b) = b
(* Задание 15. get_same_rank *)
fun get_same_rank (r, cs) =
  List.filter (fn x => is_same_rank (get_back x, r)) cs

(*** Вспомогательная функция vозвращающая цвет карты,
    первый элемент кортежа ***)
fun get_first (a, b) = a
(* Задание 16. get_same_color *)
fun get_same_color (col, cs) =
  List.filter (fn x => is_same_color (get_first x, col)) cs

(* Задание 17. has_rank *)
fun has_rank (r, cs) =
  isSome (List.find (fn x => is_same_rank (get_back x, r)) cs)

(* Задание 18. has_color *)
fun has_color (col, cs) =
  isSome (List.find (fn x => is_same_color (get_first x, col)) cs)

(* Задание 19. has_card *)
fun has_card (c, cs) = isSome (List.find (fn x => is_same_card(x, c)) cs)

(* Задание 20. count_color *)
fun count_color (col, cs) = length (get_same_color(col, cs))

(* Задание 21. max_color *)
fun max_color cs =
  let
    fun max ((rr, a), (_, ~1), (_, ~1), (_, ~1)) = rr
      | max ((rr, a), (gg, b), (bb, c), (yy, d)) =
      if a < b
      then max ((gg, b), (bb, c), (yy, d), (rr, ~1))
      else max ((rr, a), (bb, c), (yy, d), (gg, ~1))
    fun gg_wp (r, g, b, y, []) =
      max ((Red, r), (Green, g), (Blue, b), (Yellow, y))
      | gg_wp (r, g, b, y, e :: ee) =
      case get_first e of
        Red => gg_wp (r + 1, g, b, y, ee)
        | Green => gg_wp (r, g + 1, b, y, ee)
        | Blue => gg_wp (r, g, b + 1, y, ee)
        | Yellow => gg_wp (r, g, b, y + 1, ee)
        | Black => gg_wp (r, g, b, y, ee)
  in
    gg_wp (0, 0, 0, 0, cs)
  end

(* Задание 22. deal *)
fun deal l =
  let
    val cs = shuffle_list (deck)

    fun make_players ([], t) = t
      | make_players (e :: ee, t) =
      make_players (ee, make_player (get_first e, [], get_back e) :: t)

    fun go_card (e :: ee, 0, c :: cc, re) = go_card (ee, 7, c :: cc, e :: re)
      | go_card ([], n, c :: cc, re) = (re, c, cc)
      | go_card (e :: ee, n, c :: cc, re) =
      go_card (set_player_cards (e, c :: get_player_cards e) :: ee,
                                                     n - 1, cc, re)
      (* Этот случай невозможен*)
      | go_card _ = ([], (Red, Skip), [])

    fun get_first3 (a, b, c) = a
    fun get_centre (a, b, c) = b
    fun get_back3 (a, b, c) = c

    val ps = get_first3 (go_card (make_players (l, []), 7, cs, []))
    val css = get_centre (go_card (make_players (l, []), 7, cs, [])) :: []
    val ds = get_back3 (go_card (make_players (l, []), 7, cs, []))
  in
    make_desk (ps, css, ds, Proceed)
  end

(* Задание 23. get_players_first *)
fun get_players_first dsk = get_nth (get_desk_players dsk, 0)

(* Задание 24. get_pile_top *)
fun get_pile_top dsk = get_nth (get_desk_pile dsk, 0)

(* Задание 25. next_player *)
fun next_player dsk =
  set_desk_players (dsk, List.drop (get_desk_players (dsk), 1)
                                @ get_players_first dsk :: [])

(* Задание 26. change_direction *)
fun change_direction dsk =
  set_desk_players (dsk, get_players_first dsk :: []
    @ reverse_append (List.drop (get_desk_players (dsk), 1),[]))

(* Задание 27. start *)
fun start dsk =
  let
    fun change_pile_desk dk =
      shuffle_list(get_desk_pile dk @ get_desk_deck dk)
    fun shuffle_stak (dk, e :: ee) =
      make_desk (get_desk_players dk, e :: [], ee, get_desk_state dk)
      | shuffle_stak (dk, []) = dk
    fun good_desk dk =
      if is_same_color (get_first (get_nth (get_desk_pile dk, 0)), Black)
      then good_desk (shuffle_stak (dk, change_pile_desk dk))
      else dk
    val g_desk = good_desk dsk
    fun desk_navigation dk =
      if is_same_rank (get_back (get_nth (get_desk_pile dk, 0)), Reverse)
      then change_direction dk
      else dk
    fun desk_state dk =
      case get_back (get_nth (get_desk_pile dk, 0)) of
        Skip => set_desk_state (dk, Execute)
        | DrawTwo => set_desk_state (dk, Execute)
        | _ => dk
    val g_desk = desk_navigation g_desk
    val g_desk = desk_state g_desk
  in
    if is_same_rank (get_back (get_nth (get_desk_pile dsk, 0)), Reverse)
    then g_desk
    else next_player g_desk
  end

(* Задание 28. take_1 *)
fun take_1 dsk =
  case dsk
    of {players = ps, pile = c :: cs, deck = [], state = move} => 
      take_1 (make_desk (ps, [c], shuffle_list cs, move)) 
    |  {players = p :: ps, pile = cs, deck = d :: ds, state = move} => 
      make_desk ( set_player_cards (p, d :: get_player_cards p) :: ps
                , cs, ds, move )
    |  _ => raise IllegalGame

(* Задание 29. take_2 *)
val take_2 = take_1 o take_1

(* Задание 30. take_4 *)
val take_4 = take_2 o take_2

(* Задание 31. pass *)
fun pass dsk =
  case get_back (get_pile_top dsk) of
     Skip => if is_same_move (get_desk_state dsk, Execute)
             then next_player (set_desk_state (dsk, Proceed))
             else next_player dsk
    | DrawTwo => if is_same_move (get_desk_state dsk, Execute)
                 then next_player (take_2 (set_desk_state (dsk, Proceed)))
                 else next_player dsk
    | _ => next_player dsk

(* Задание 32. required_color *)
fun required_color dsk =
  case get_desk_state dsk of
    Give col => col
    | _ => get_first (get_pile_top dsk)

(* Задание 33. playable_cards *)
fun playable_cards dsk =
  case get_desk_state dsk of
    Give col => get_same_color (col, get_player_cards (get_players_first dsk))
    @ get_same_color (Black, get_player_cards (get_players_first dsk))

    | Execute => List.filter (fn x => is_same_card(x, get_pile_top dsk)
      orelse is_same_rank (get_back x, get_back (get_pile_top dsk))) 
                            (get_player_cards (get_players_first dsk))
    | Proceed => List.filter (fn x => 
      is_same_rank (get_back x, get_back (get_pile_top dsk)) 
      orelse is_same_color (get_first x, Black)
      orelse is_same_color (get_first x, get_first (get_pile_top dsk))) 
      (get_player_cards (get_players_first dsk))

(* Задание 34. count_cards *)
fun count_cards dsk = map (fn x => length (get_player_cards x)) (get_desk_players dsk)

(* Задание 35. has_no_cards *)
fun has_no_cards e = (null o get_player_cards) e

(* Задание 36. count_loss *)
fun count_loss e =
  map (fn x => (get_player_name x, sum_cards ((get_player_cards x)))) e

(* Задание 37. naive_strategy *)
fun naive_strategy (move, cs, c as (col, r), is) =
  let 
    val black = get_same_color (Black, cs)
    val max_col = max_color cs
    fun greatest (c1, c2) =
      if card_value c1 > card_value c2 then c1 else c2
    fun max_card (c :: cs) = foldl greatest c cs
      | max_card _ = raise Empty
  in
    case move
      of Give col' => 
          let val same_color  = get_same_color (col', cs)
          in
            if null same_color 
            then if has_rank (WildDrawFour, black)
                 then ((Black, WildDrawFour), max_col)
                 else ((Black, Wild), max_col)
            else if not (is_same_color (max_col, col'))
                    andalso has_rank (Wild, black)
                 then ((Black, Wild), max_col)
                 else (max_card same_color, col)
          end
      |  Execute  => 
           let val (first_same :: _) = get_same_rank (r, cs)
           in (first_same, col)
           end
      |  Proceed  => 
          let 
            val same_col_r = get_same_color (col, cs) @ get_same_rank (r, cs)
          in
            if not (null same_col_r)
            then (max_card same_col_r, col)
            else if has_rank (WildDrawFour, black)
                 then ((Black, WildDrawFour), max_col)
                 else ((Black, Wild), max_col)
          end
  end

(* Задание 38. play *)
fun play (dsk, play_cards) =
  let 
    val {players = p :: ps, pile = cs as (c :: _), deck = ds, state = m} = dsk
    val name = get_player_name p
    val (play_card, want_col) = 
          (get_player_strategy p) (m, get_player_cards p, c, count_cards dsk)
    val _ = remove_card (play_cards, play_card, IllegalMove name)
    val new_player_cards = 
        remove_card (get_player_cards p, play_card, IllegalMove name )
    val new_players = set_player_cards (p, new_player_cards) :: ps
    val new_pile = play_card :: cs
    val new_desk = make_desk (new_players, new_pile, ds, Give want_col)
  in
    case play_card 
      of (_, WildDrawFour) => 
          if has_color (required_color dsk, play_cards)
          then next_player (take_4 new_desk)
          else next_player (take_4 (next_player new_desk))
      |  (Black, _)   => next_player new_desk
      |  (_, Num _)   => next_player (set_desk_state (new_desk, Proceed))
      |  (_, Reverse) => next_player (change_direction 
                            (set_desk_state (new_desk, Proceed)))
      |  _            => next_player (set_desk_state (new_desk, Execute))
  end

(* Задание 39. game_step *)
fun game_step dsk =
  let
    val play_cards = playable_cards dsk
  in
    case (play_cards, get_desk_state dsk)
      of (_ :: _, _)   => play (dsk, play_cards)
      |  ([], Execute) => pass dsk
      |  _ => let
                val dsk = take_1 dsk
                val play_cards = playable_cards dsk
              in
                if null play_cards
                then pass dsk
                else play (dsk, play_cards)
              end
  end 

(* Задание 40. game *)
fun game dsk =
  let
    val desk = start dsk
    fun game_iter dsk =
      let 
        val pls = get_desk_players dsk
        val winner = List.find has_no_cards pls 
      in
        case winner
          of SOME p => (get_player_name p, count_loss pls)
          |  NONE   => game_iter (game_step dsk)
      end
  in game_iter desk
  end

(* Стратегия *)
fun tirkiya_strategy (move, cs, c as (col, r), is) =
  let 
    val black = get_same_color (Black, cs)
    val max_col = max_color cs
    fun greatest (c1, c2) =
      if card_value c1 > card_value c2 then c1 else c2
    fun max_card (c :: cs) = foldl greatest c cs
      | max_card _ = raise Empty
    fun max_carta (css, i, n, max) = 
      if n > 1
      then if i = n
           then max
           else if card_value (get_nth (css, i)) >= card_value (max)
                  andalso not (get_first (get_nth(css,i)) = Black)
                then max_carta (css, i + 1, n, get_nth(css,i))
                else max_carta (css, i + 1, n, max)
      else get_nth (css, 0)
    val max_card_col = get_first (max_carta(cs, 0, length cs, (Red, Num 0)));
  in
    case move
      of Give col' => 
          let val same_color  = get_same_color (col', cs)
          in
            if null same_color
            then if has_rank (WildDrawFour, black)
                 then ((Black, WildDrawFour), max_col)
                 else ((Black, Wild), max_card_col)
            else if has_rank (Wild, black)
                 then ((Black, Wild), max_card_col)
                 else (max_card same_color, col)
          end
      |  Execute  => 
           let val (first_same :: _) = get_same_rank (r, cs)
           in (first_same, max_col)
           end
      |  Proceed  => 
          let 
            val same_col_r = get_same_color (col, cs) @ get_same_rank (r, cs)
            val same_draw = get_same_rank (DrawTwo, cs) @ get_same_rank (Skip, cs)
            val same_draw = get_same_color (col, same_draw)
          in
            if get_nth (is, 1) <= 2 andalso not (null same_draw)
            then (get_nth(same_draw, 0), get_first (get_nth(same_draw, 0)))
            else
              if has_rank (Wild, black)
              then ((Black, Wild), max_card_col)
              else if not (null same_col_r)
                   then (max_card same_col_r, col)
                   else ((Black, WildDrawFour), max_card_col)
          end
  end

(*****************************************************
**********Функция для тестирования 2-x игроков********
**************со своими стратегиями*******************
******из списка L = (string * strategy), N - раз******
******************************************************)
fun test_strategy (L, N) =
  let
    val s = get_first (get_nth (L, 0));
    val s2 = get_first (get_nth (L, 1));
    fun gg_wp (ls, 0, m, m2) = if m < m2 then (s2, m2) else (s, m)
      | gg_wp (ls, n, m, m2) =
      if #1 (game (deal ls)) = s
      then gg_wp (ls, n - 1, m + 1, m2)
      else gg_wp (ls, n - 1, m, m2 + 1)
  in
    gg_wp (L, N, 0, 0)
  end

(****************************************************************
 Запустить тестирующую функцию можно так:
val l = [("Goga", tirkiya_strategy), ("Anton", naive_strategy)];
test_strategy (l, 100);
test_strategy (l, 1000);
*****************************************************************)

(*500*)
(******************************Thank 4 using******************************)