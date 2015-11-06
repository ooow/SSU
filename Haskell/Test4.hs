-- Первоначальный набор тестов для лабораторной работы №4
-- по мере реализации решений заданий снимайте комментарий 
-- с тестов соответствующей функции и пополняйте их своими тестами
-- кроме того, снимайте комментарий соответствующих строк вывода 
-- результатов тестов в функции main в конце файла и пополняйте эту 
-- функцию своими строками

-- Для проведения тестов запустите этот файл и выполните запуск main

import Lab4
--------------------------------------------------------------------------------
-- Блок вспомогательных определений
-- Не вносите изменения в этот блок
--------------------------------------------------------------------------------
import Control.Exception

-- вспомогательная функция, для вывода на экран True, когда 
-- возникает сообщение об ошибке
handler1 = (\_ -> putStrLn "True") :: Exception -> IO ()

-- вспомогательная функция, для вывода на экран False, когда 
-- возникает сообщение об ошибке
handler2 = (\_ -> putStrLn "True") :: Exception -> IO ()
--------------------------------------------------------------------------------

------ Задание 1 funName 
test_funName_1 = funName (Fun "" "a" Unit) == []
test_funName_2 = funName Unit == []

------ Задание 2 funArg 
test_funArg_1 = funArg (Fun "" "a" Unit) == "a"
test_funArg_2 = funArg Unit == []

------ Задание 3 funBody 
test_funBody_1 = funBody (Fun "" "a" Unit) == Unit
test_funBody_2 = funBody Unit == Unit

------ Задание 4 pairHead 
test_pairHead_1 = pairHead (Pair (Var "a") Unit) == Var "a"
test_pairHead_2 = pairHead Unit == Unit

------ Задание 5 pairTail 
test_pairTail_1 = pairTail (Pair (Var "a") Unit) == Unit
test_pairTail_2 = pairTail Unit == Unit

------ Задание 6 closureFun 
test_closureFun_1 = closureFun (Closure [] (Fun "" "a" Unit)) 
                    == (Fun "" "a" Unit)
test_closureFun_2 = closureFun Unit == Unit 

------ Задание 7 closureEnv 
test_closureEnv_1 = closureEnv (Closure [] (Fun "" "a" Unit)) == []
test_closureEnv_2 = closureEnv Unit == [("a", IntNum 5)]

------ Задание 8 convertListToMUPL 
test_convertListToMUPL_1 = convertListToMUPL [] == Unit
test_convertListToMUPL_2 = convertListToMUPL [Unit] == Pair Unit Unit

------ Задание 9 convertListFromMUPL 
test_convertListFromMUPL_1 = convertListFromMUPL Unit == []
test_convertListFromMUPL_2 = convertListFromMUPL (Pair Unit Unit) == [Unit]

------ Задание 10 evalUnderEnv 
test_evalUnderEnv_1 = evalUnderEnv (Var "a") [("a", IntNum 5)] == IntNum 5
test_evalUnderEnv_2 = evalUnderEnv (IntNum 5) [] == IntNum 5

------ Задание 11 ifAUnit 
test_ifAUnit_1 = (evalExp $ ifAUnit Unit (IntNum 5) (IntNum 6)) == IntNum 5
test_ifAUnit_2 = (evalExp $ ifAUnit (IntNum 5) (IntNum 6) Unit) == Unit

------ Задание 12 mLet 
test_mLet_1 = 
  mLet [ ("a", IntNum 5)
       , ("b", IntNum 6)
       , ("c", Unit)
       , ("d", Pair Unit Unit)
       ]
    (IfGreater (Var "a") (Var "b") (Var "d") (Var "c"))
  == Let ("a", IntNum 5)
       (Let ("b", IntNum 6)
         (Let ("c", Unit)
           (Let ("d", Pair Unit Unit) 
             (IfGreater (Var "a") (Var "b") (Var "d") (Var "c")))))

------ Задание 13 ifEq 
test_ifEq_1 = 
  ( evalExp 
    $ ifEq (IntNum 5) (IntNum 6) Unit (Pair Unit Unit) )
  == Pair Unit Unit

------ Задание 14 mMap 
test_mMap_1 = 
  ( evalExp 
    $ Call 
        (Call mMap (Fun "" "x" 
                     (Add (Var "x") (IntNum 5)))) 
        (Pair (IntNum 1) (Pair (IntNum 2) (Pair (IntNum 3) Unit))) )
  == Pair (IntNum 6) (Pair (IntNum 7) (Pair (IntNum 8) Unit))


------ Задание 15 mMapAddN 
--test_mMapAddN_1 = 
--  ( evalExp 
--    $ Call (mMapAddN (IntNum 5))
--           (Pair (IntNum 1) (Pair (IntNum 2) (Pair (IntNum 3) Unit))) )
--  == Pair (IntNum 6) (Pair (IntNum 7) (Pair (IntNum 8) Unit))

------ Задание 16 fact 
--test_fact_1 = ( evalExp $ Call fact (IntNum 5) ) == IntNum 120

---- Запуск всех тестов
---- На каждый тест 2 строки main
main = do      
  putStr ("1 test_funName_1 ")
  Control.Exception.catch (putStrLn $ show test_funName_1) handler2 
  putStr ("1 test_funName_2 ")
  Control.Exception.catch (putStrLn $ show test_funName_2) handler1
  putStr ("2 test_funArg_1 ")
  Control.Exception.catch (putStrLn $ show test_funArg_1) handler2 
  putStr ("2 test_funArg_2 ")
  Control.Exception.catch (putStrLn $ show test_funArg_2) handler1 
  putStr ("3 test_funBody_1 ")
  Control.Exception.catch (putStrLn $ show test_funBody_1) handler2 
  putStr ("3 test_funBody_2 ")
  Control.Exception.catch (putStrLn $ show test_funBody_2) handler1 
  putStr ("4 test_pairHead_1 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_1) handler2 
  putStr ("4 test_pairHead_2 ")
  Control.Exception.catch (putStrLn $ show test_pairHead_1) handler1 
  putStr ("5 test_pairTail_1 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_1) handler2 
  putStr ("5 test_pairTail_2 ")
  Control.Exception.catch (putStrLn $ show test_pairTail_2) handler1 
  putStr ("6 test_closureFun_1 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_1) handler2 
  putStr ("6 test_closureFun_2 ")
  Control.Exception.catch (putStrLn $ show test_closureFun_2) handler1 
  putStr ("7 test_closureEnv_1 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_1) handler2 
  putStr ("7 test_closureEnv_2 ")
  Control.Exception.catch (putStrLn $ show test_closureEnv_2) handler1 
  putStr ("8 test_convertListToMUPL_1 ")
  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_1) handler2 
  putStr ("8 test_convertListToMUPL_2 ")
  Control.Exception.catch (putStrLn $ show test_convertListToMUPL_2) handler2 
  putStr ("9 test_convertListFromMUPL_1 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_1) handler2 
  putStr ("9 test_convertListFromMUPL_2 ")
  Control.Exception.catch (putStrLn $ show test_convertListFromMUPL_2) handler2 
  putStr ("10 test_evalUnderEnv_1 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_1) handler2 
  putStr ("10 test_evalUnderEnv_2 ")
  Control.Exception.catch (putStrLn $ show test_evalUnderEnv_2) handler2 
  putStr ("11 test_ifAUnit_1 ")
  Control.Exception.catch (putStrLn $ show test_ifAUnit_1) handler2 
  putStr ("11 test_ifAUnit_2 ")
  Control.Exception.catch (putStrLn $ show test_ifAUnit_2) handler2 
  putStr ("12 test_mLet_1 ")
  Control.Exception.catch (putStrLn $ show test_mLet_1) handler2 
  putStr ("13 test_ifEq_1 ")
  Control.Exception.catch (putStrLn $ show test_ifEq_1) handler2 
  putStr ("14 test_mMap_1 ")
  Control.Exception.catch (putStrLn $ show test_mMap_1) handler2 
  --putStr ("15 test_mMapAddN_1 ")
  --Control.Exception.catch (putStrLn $ show test_mMapAddN_1) handler2 
  --putStr ("16 test_fact_1 ")
  --Control.Exception.catch (putStrLn $ show test_fact_1) handler2 
  putStrLn "all tests done"


