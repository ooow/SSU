import Lab3

-- Первоначальный набор тестов для лабораторной работы №3 
-- по мере реализации решений заданий снимайте комментарий 
-- с тестов соответствующей функции и пополняйте их своими тестами
-- кроме того, снимайте комментарий соответствующих строк вывода 
-- результатов тестов в функции main в конце файла и пополняйте эту 
-- функцию своими строками

-- Для проведения тестов запустите этот файл и выполните запуск main

------  Задание 1 nat 
test_nat_1 = take 5 (drop 24 nat) == [25, 26, 27, 28, 29]
test_nat_2 = take 5 (drop 124 nat) == [125, 126, 127, 128, 129]
test_nat_3 = take 10 (drop 33 nat) == [34, 35, 36, 37, 38, 39, 40, 41, 42, 43]
test_nat_4 = take 3 (drop 11 nat) == [12, 13, 14]
test_nat_5 = take 2 (drop 444 nat) == [445,446]

------  Задание 2 fibonacci 
test_fibonacci_1 = take 8 fibonacci == [0,1,1,2,3,5,8,13]
test_fibonacci_2 = take 5 (drop 12 fibonacci) == [144,233,377,610,987]
test_fibonacci_3 = take 10 (drop 3 fibonacci) == [2,3,5,8,13,21,34,55,89,144]
test_fibonacci_4 = take 3 (drop 11 fibonacci) == [89,144,233]
test_fibonacci_5 = take 2 (drop 44 fibonacci) == [701408733,1134903170]
------ Задание 3 factorial 
test_factorial_1 = take 5 factorial == [1,1,2,6,24] 
test_factorial_2 = take 5 (drop 8 factorial) == [ 40320,362880,3628800,39916800
                                                , 479001600]
test_factorial_3 = take 10 (drop 3 factorial) == [6,24,120,720,5040,40320
                                                 ,362880,3628800,39916800
                                                 ,479001600]
test_factorial_4 = take 3 (drop 11 factorial) == [39916800,479001600
                                                 ,6227020800]
test_factorial_5 = take 2 (drop 14 factorial) == [87178291200,1307674368000]

------ Задание 4 powerSeq 
------ для вещественнозначного аргумента тесты не требуются
------ но при наличии тестов для вещественных чисел следует проверять ответ 
------ с некоторой точностью
------ точность epsilon для проверки вполне подходит
test_powerSeq_1 = take 5 (powerSeq 1) == [1,1,1,1,1] 
test_powerSeq_2 = abs (hd - 1.4641) <= epsilon
       where hd = (head (drop 4 (powerSeq 1.1)))   
test_powerSeq_3 = take 5 (powerSeq 2) == [1,2,4,8,16]
test_powerSeq_4 = take 9 (powerSeq 5) == [1,5,25,125,625,3125,15625
                                         ,78125,390625]
------  Задание 5 findCloseEnough 
------ тесты не требуются 

------ Задание 6 streamSum 
------ тесты не требуются 

------ Задание 7 expSummands 
------ тесты не требуются

------ Задание 8 expStream 
------ тесты не требуются

------  Задание 9 expAppr 
test_expAppr_1 = abs (expAppr epsilon'' 1 - exp 1) < epsilon
test_expAppr_2 = abs (expAppr epsilon'' 5 - exp 5) < epsilon
test_expAppr_3 = abs (expAppr epsilon'' 10 - exp 10) < epsilon
test_expAppr_4 = abs (expAppr epsilon'' 15 - exp 15) < epsilon
test_expAppr_5 = abs (expAppr epsilon'' 25 - exp 25) < epsilon

------ Задание 10 derivationAppr 
test_derivationAppr_1 = abs (derivationAppr sin epsilon'' x - cos x) < epsilon
  where x = pi
test_derivationAppr_2 = abs (derivationAppr sin epsilon'' x - cos x) < epsilon
  where x = 4.343
test_derivationAppr_3 = abs (derivationAppr sin epsilon'' x - cos x) < epsilon
  where x = 7.111
test_derivationAppr_4 = abs (derivationAppr sin epsilon'' x - cos x) < epsilon
  where x = 9.433
test_derivationAppr_5 = abs (derivationAppr sin epsilon'' x - cos x) < epsilon
  where x = 13.465
------ Задание 11 derivationStream 
------ тесты не требуются

------ Задание 12 derivation 
test_derivation_1 = abs (derivation sin x - cos x) < epsilon
  where x = pi
test_derivation_2 = abs (derivation sin x - cos x) < epsilon
  where x = 4.343
test_derivation_3 = abs (derivation sin x - cos x) < epsilon
  where x = 7.111
test_derivation_4 = abs (derivation sin x - cos x) < epsilon
  where x = 9.433
test_derivation_5 = abs (derivation sin x - cos x) < epsilon
  where x = 13.465

------ Задание 13 invF и funAkStream
------ для funAkStream тесты не требуются
test_invF_1 = abs (invF (\x -> x * x) 4.3 16 - 4) < epsilon
test_invF_2 = abs (invF (\x -> x * x * x) 4.7 125 - 5) < epsilon

------ Задание 14 average 
test_average_1 = (average 4 8) == 6
test_average_2 = (average 65 12) == 38.5
test_average_3 = (average 55 83) == 69
test_average_4 = (average 14 7) == 10.5
test_average_5 = (average 6.4 8.4) == 7.4

------ Задание 15 averageDump 
test_averageDump_1 = (averageDump (\x -> x + x) 8) == 12
test_averageDump_2 = (averageDump (\x -> x * x) 12) == 78
test_averageDump_3 = (averageDump (\x -> x) 85) == 85
test_averageDump_4 = (averageDump (\x -> sin x) 0) == 0
test_averageDump_5 = (averageDump (\x -> x + 5) 82) == 84.5

------ Задание 16 newtonTransform 
test_newtonTransform_1 = abs (newtonTransform (\x -> x * x / 2) 4 - 2) < epsilon
test_newtonTransform_2 = abs (newtonTransform sin 0) < epsilon
test_newtonTransform_3 = abs (newtonTransform cos 0 - 131072) < epsilon

------ Задание 17 eitken 
------ тесты не требуются

------ Задание 18 fixedPoint
------ тесты не требуются

------ Задание 19 fixedPointOfTransform 
------ тесты не требуются

------ Задание 20 sqrt1 
test_sqrt1_1 = abs (sqrt1 25 - 5) < epsilon
test_sqrt1_2 = abs (sqrt1 4 - 2) < epsilon
test_sqrt1_3 = abs (sqrt1 121 - 11) < epsilon
test_sqrt1_4 = abs (sqrt1 2025 - 45) < epsilon
test_sqrt1_5 = abs (sqrt1 100 - 10) < epsilon

------ Задание 21 sqrCube1 
test_sqrCube1_1 = abs (sqrCube1 125 - 5) < epsilon
test_sqrCube1_2 = abs (sqrCube1 27 - 3) < epsilon
test_sqrCube1_3 = abs (sqrCube1 8 - 2) < epsilon
test_sqrCube1_4 = abs (sqrCube1 343 - 7) < epsilon
test_sqrCube1_5 = abs (sqrCube1 1728 - 12) < epsilon

------ Задание 22 sqrt2 
test_sqrt2_1 = abs (sqrt2 25 - 5) < epsilon
test_sqrt2_2 = abs (sqrt2 4 - 2) < epsilon
test_sqrt2_3 = abs (sqrt2 121 - 11) < epsilon
test_sqrt2_4 = abs (sqrt2 2025 - 45) < epsilon
test_sqrt2_5 = abs (sqrt2 100 - 10) < epsilon

------ Задание 23 sqrCube2 
test_sqrCube2_1 = abs (sqrCube2 125 - 5) < epsilon
test_sqrCube2_2 = abs (sqrCube2 27 - 3) < epsilon
test_sqrCube2_3 = abs (sqrCube2 8 - 2) < epsilon
test_sqrCube2_4 = abs (sqrCube2 343 - 7) < epsilon
test_sqrCube2_5 = abs (sqrCube2 1728 - 12) < epsilon


------ Задание 24 extremum 
test_extremum_1 = abs (x - 0) < epsilon && str == "minimum"
  where (x, str) = extremum (\x -> x * x)
test_extremum_2 = abs (x - 1.57078) < epsilon && str == "maximum"
  where (x, str) = extremum sin
test_extremum_3 = abs x < epsilon && str == "maximum"
  where (x, str) = extremum cos

------ Задание 25 myPi 
test_myPi_1 = abs (myPi - pi) < epsilon 

main = do 
  putStrLn ("1 test_nat_1 " ++ (show test_nat_1))
  putStrLn ("1 test_nat_2 " ++ (show test_nat_2))
  putStrLn ("1 test_nat_3 " ++ (show test_nat_3))
  putStrLn ("1 test_nat_4 " ++ (show test_nat_4))
  putStrLn ("1 test_nat_5 " ++ (show test_nat_5))
  putStrLn ("2 test_fibonacci_1 " ++ (show test_fibonacci_1))
  putStrLn ("2 test_fibonacci_2 " ++ (show test_fibonacci_2))
  putStrLn ("2 test_fibonacci_3 " ++ (show test_fibonacci_3))
  putStrLn ("2 test_fibonacci_4 " ++ (show test_fibonacci_4))
  putStrLn ("2 test_fibonacci_5 " ++ (show test_fibonacci_5))
  putStrLn ("3 test_factorial_1 " ++ (show test_factorial_1))
  putStrLn ("3 test_factorial_2 " ++ (show test_factorial_2))
  putStrLn ("3 test_factorial_3 " ++ (show test_factorial_3))
  putStrLn ("3 test_factorial_4 " ++ (show test_factorial_4))
  putStrLn ("3 test_factorial_5 " ++ (show test_factorial_5))
  putStrLn ("4 test_powerSeq_1 " ++ (show test_powerSeq_1))
  putStrLn ("4 test_powerSeq_2 " ++ (show test_powerSeq_2))
  putStrLn ("4 test_powerSeq_3 " ++ (show test_powerSeq_3))
  putStrLn ("4 test_powerSeq_3 " ++ (show test_powerSeq_4))
  putStrLn ("9 test_expAppr_1 " ++ (show test_expAppr_1))
  putStrLn ("9 test_expAppr_2 " ++ (show test_expAppr_2))
  putStrLn ("9 test_expAppr_3 " ++ (show test_expAppr_3))
  putStrLn ("9 test_expAppr_4 " ++ (show test_expAppr_4))
  putStrLn ("9 test_expAppr_5 " ++ (show test_expAppr_5))
  putStrLn ("10 test_derivationAppr_1 " ++ (show test_derivationAppr_1))
  putStrLn ("10 test_derivationAppr_2 " ++ (show test_derivationAppr_2))
  putStrLn ("10 test_derivationAppr_3 " ++ (show test_derivationAppr_3))
  putStrLn ("10 test_derivationAppr_4 " ++ (show test_derivationAppr_4))
  putStrLn ("10 test_derivationAppr_5 " ++ (show test_derivationAppr_5))
  putStrLn ("12 test_derivation_1 " ++ (show test_derivation_1))
  putStrLn ("12 test_derivation_2 " ++ (show test_derivation_2))
  putStrLn ("12 test_derivation_3 " ++ (show test_derivation_3))
  putStrLn ("12 test_derivation_4 " ++ (show test_derivation_4))
  putStrLn ("12 test_derivation_5 " ++ (show test_derivation_5))
  putStrLn ("13 test_invF_1 " ++ (show test_invF_1))
  putStrLn ("13 test_invF_2 " ++ (show test_invF_2))
  putStrLn ("14 test_average_1 " ++ (show test_average_1))
  putStrLn ("14 test_average_2 " ++ (show test_average_2))
  putStrLn ("14 test_average_3 " ++ (show test_average_3))
  putStrLn ("14 test_average_4 " ++ (show test_average_4))
  putStrLn ("14 test_average_5 " ++ (show test_average_5))
  putStrLn ("15 test_averageDump_1 " ++ (show test_averageDump_1))
  putStrLn ("15 test_averageDump_2 " ++ (show test_averageDump_2))
  putStrLn ("15 test_averageDump_3 " ++ (show test_averageDump_3))
  putStrLn ("15 test_averageDump_4 " ++ (show test_averageDump_4))
  putStrLn ("15 test_averageDump_5 " ++ (show test_averageDump_5))
  putStrLn ("16 test_newtonTransform_1 " ++ (show test_newtonTransform_1))
  putStrLn ("16 test_newtonTransform_2 " ++ (show test_newtonTransform_2))
  putStrLn ("16 test_newtonTransform_3 " ++ (show test_newtonTransform_3))
  putStrLn ("20 test_sqrt1_1 " ++ (show test_sqrt1_1))
  putStrLn ("20 test_sqrt1_2 " ++ (show test_sqrt1_2))
  putStrLn ("20 test_sqrt1_3 " ++ (show test_sqrt1_3))
  putStrLn ("20 test_sqrt1_4 " ++ (show test_sqrt1_4))
  putStrLn ("20 test_sqrt1_5 " ++ (show test_sqrt1_5))
  putStrLn ("21 test_sqrCube1_1 " ++ (show test_sqrCube1_1))
  putStrLn ("21 test_sqrCube1_2 " ++ (show test_sqrCube1_2))
  putStrLn ("21 test_sqrCube1_3 " ++ (show test_sqrCube1_3))
  putStrLn ("21 test_sqrCube1_4 " ++ (show test_sqrCube1_4))
  putStrLn ("21 test_sqrCube1_5 " ++ (show test_sqrCube1_5))
  putStrLn ("22 test_sqrt2_1 " ++ (show test_sqrt2_1))
  putStrLn ("22 test_sqrt2_2 " ++ (show test_sqrt2_2))
  putStrLn ("22 test_sqrt2_3 " ++ (show test_sqrt2_3))
  putStrLn ("22 test_sqrt2_4 " ++ (show test_sqrt2_4))
  putStrLn ("22 test_sqrt2_5 " ++ (show test_sqrt2_5))
  putStrLn ("23 test_sqrCube2_1 " ++ (show test_sqrCube2_1))
  putStrLn ("23 test_sqrCube2_2 " ++ (show test_sqrCube2_2))
  putStrLn ("23 test_sqrCube2_3 " ++ (show test_sqrCube2_3))
  putStrLn ("23 test_sqrCube2_4 " ++ (show test_sqrCube2_4))
  putStrLn ("23 test_sqrCube2_5 " ++ (show test_sqrCube2_5))
  putStrLn ("24 test_extremum_1 " ++ (show test_extremum_1))
  putStrLn ("24 test_extremum_2 " ++ (show test_extremum_2))
  putStrLn ("24 test_extremum_3 " ++ (show test_extremum_3))
  putStrLn ("25 test_myPi_1 " ++ (show test_myPi_1))
  putStrLn "all tests done"







