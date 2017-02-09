{- Функция удаления каждлго k - го элемента, обычная рекурсия-}
gg_wp x y =
  let
    find_f_y [] n i rez = reverse rez
    find_f_y [x] n i rez =
      if i == n 
      then reverse (rez)
      else reverse (x : rez)
    find_f_y (x : z) n i rez
      | i == n      = find_f_y z n (i - n) rez
      | otherwise = find_f_y z n (i + 1) (x : rez)
  in
    find_f_y x (y - 1) 0 []

main = do
  let l = [1, 2, 3, 4, 5, 6, 7]
  putStrLn ((show l) ++ " -> " ++ (show (gg_wp l 2)))
  let l = [1..20]
  putStrLn ((show l) ++ " -> " ++ (show (gg_wp l 5)))
  let l = [1]
  putStrLn ((show l) ++ " -> " ++ (show (gg_wp l 1)))
  let l = [1]
  putStrLn ((show l) ++ " -> " ++ (show (gg_wp l 4)))
  let l = [3, 1, 3, 2, 3, 5, 4, 4, 7, 9, 6, 6]
  putStrLn ((show l) ++ " -> " ++ (show (gg_wp l 4)))