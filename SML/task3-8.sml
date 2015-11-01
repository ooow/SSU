fun y (_, _, 0) = 1.0          (* при N=0 - результат y0 *)
  | y (x, _, 1) = x * x / 5.0  (* при N=1 - результат y1 *)
  | y (x, e, N) =              (* иначе определим две вспомогательные функции *)
      let
        fun close_enough (a, b) = abs (a - b) < e
        (* функция y_next - функция вычисления i-го элемента последовательности
         * y_pred и y_predpred - i-1-й i-2-й элементы последовательности
         * соответственно *)
        fun y_next (y_pred, y_predpred, i) =
          if close_enough (y_pred, y_predpred)
          then y_pred
          else
            let
              (* вычисляется y_cur - i-й элемент последовательности *)
              val n = i - 1.0;
              val y_cur = (2.0 * n / n * n * y_pred + x * x * y_predpred)
            in
              (* если i достигло значения N то вернуть y_cur как результат
               * в противном случае запускается вычисление i+1-го элемента *)
              if i >= real N then y_cur
              else y_next (y_cur, y_pred, i + 1.0)
            end
      in
        (* запуск вычисления 2-го элемента последовательности *)
        y_next (y (x, e, 1), y (x, e, 0), 2.0)
      end;