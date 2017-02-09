(* Вспомогательная функция *)
fun get_first (a, b) = a

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
          let
            val same_color  = get_same_color (col', cs)
          in
            if null same_color
            then if has_rank (WildDrawFour, black)
                 then ((Black, WildDrawFour), max_col)
                 else ((Black, Wild), max_card_col)
            else if has_rank (Wild, black)
                 then ((Black, Wild), max_card_col)
                 else (max_card same_color, col)
          end
      |  Execute =>
           let val (first_same :: _) = get_same_rank (r, cs)
           in (first_same, max_col)
           end
      |  Proceed =>
          let 
            val same_col_r = get_same_color (col, cs) @ get_same_rank (r, cs)
            val same_draw = get_same_rank (DrawTwo, cs)
                            @ get_same_rank (Skip, cs)
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