{- Функция удаления каждлго k - го элемента, хвостовая рекурсия-}
gg_wp a k =
  let
    find_f_y [] n i = []
    find_f_y [x] n i =
      if i == n
      then []
      else [x]
    find_f_y (x : xs) n i
      | i == n    = find_f_y xs n (i - n)
      | otherwise = x : find_f_y xs n (i + 1)
  in
    find_f_y a (k - 1) 0

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