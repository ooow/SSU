(************************************************
 N - целочисленный параметр, результатом функции
 "y" будет всегда являться целое число. Так как
 в решении производится вычисление факториала
 корректным будет вводить входные данные в формате
 1 <= N <= 12
************************************************)
fun y N =
  let
    (**fact - функция вычисления факториала**)
    fun fact (a, n) =
      if n = 0
      then a
      else fact (a * n, n - 1)
    (**summa - цикл для подсчета конечного результата**)
    fun summa (i, rezult) =
      if i > N
      then rezult
      else summa (i + 1, rezult + fact(1, i));
  in
    (**Запускается цикл по i (сумма) от 1**)
    summa (1, 0)
  end;