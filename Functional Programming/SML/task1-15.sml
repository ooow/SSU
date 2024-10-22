(******************************
  Функция вещественного типа, так
  как в вычисляемом выражении
  присутствует операция деления
  ****************************)

fun f (x : int) : real =
  let
    val A = x + 5
    val B = x * x + 5 * x - 1
    val C = x + 1
  in
    real A * real B / real C + real B / real A + 1.0
  end;
