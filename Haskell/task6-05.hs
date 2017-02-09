-- функция, выдающая последовательность
seqnce x = x : (x * 2) : (x * x)
  : zipWith next1 (zipWith next (seqnce x) (tail (seqnce x)))
                  (tail(tail(seqnce x)))
                  where next a b = gg_wp a 0 + gg_wp b 0
                        next1 a b = a + (gg_wp b 0)

-- вспомогательная функция для подсчета суммы чисел двух чисел
gg_wp z t =
  if (z < 10)
  then (t + z)
  else gg_wp (div z 10) (t + (mod z 10))

-- примеры работы программы 
main = do
  print $ take 15 $ seqnce 1
  print $ take 15 $ seqnce 5
  print $ take 15 $ seqnce 3