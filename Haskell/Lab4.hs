
-- Шаблон для выполнения заданий Лабораторной работы №4 
-- ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
-- предыдущее замечание относится к тем комментариям, которые
-- не предполагают раскомментирование
-- НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
-- решения заданий должны быть вписаны в отведенные для этого позиции 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab4(
  Expr ( Var, IntNum, Add, IfGreater, Fun, Call, Let
       , Pair, Head, Tail, Unit, IsAUnit, Closure )
  , valOfIntNum
  , funName
  , funArg
  , funBody
  , pairHead
  , pairTail
  , closureFun
  , closureEnv
  , convertListToMUPL
  , convertListFromMUPL
  , envLookUp
  , evalExp
  , evalUnderEnv
  , ifAUnit
  , mLet
  , ifEq
  , mMap
  , mMapAddN
  , fact
  )
  where
--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
data Expr = Var String
          | IntNum Integer
          | Add Expr Expr
          | IfGreater Expr Expr Expr Expr
          | Fun String String Expr
          | Call Expr Expr
          | Let (String, Expr) Expr
          | Pair Expr Expr
          | Head Expr
          | Tail Expr
          | Unit 
          | IsAUnit Expr
          | Closure [(String, Expr)] Expr
  deriving (Show, Eq) 

valOfIntNum (IntNum n) = n
valOfIntNum e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " is not a number"
--------------------------------------------------------------------------------
-- Задание 1 funName 
funName (Fun name _ _) = name
funName e = error $ "The expression " ++ show (e) ++ " is not a function"
-- Задание 2 funArg 
funArg (Fun _ arg _) = arg
funArg e = error $ "The expression " ++ show (e) ++ " is not a function"
-- Задание 3 funBody 
funBody (Fun _ _ body) = body
funBody e = error $ "The expression " ++ show (e) ++ " is not a function"
-- Задание 4 pairHead 
pairHead (Pair e1 _) = e1
pairHead e = error $ "The expression " ++ show (e) ++ " is not a pair"
-- Задание 5 pairTail 
pairTail (Pair _ e2) = e2
pairTail e = error $ "The expression " ++ show (e) ++ " is not a pair"
-- Задание 6 closureFun 
closureFun (Closure _ f) = f
closureFun e = error $ "The expression " ++ show (e) ++ " is not a closure"
-- Задание 7 closureEnv 
closureEnv (Closure env _) = env
closureEnv e = error $ "The expression " ++ show (e) ++ " is not a closure"
-- Задание 8 convertListToMUPL 
convertListToMUPL l = foldr Pair Unit l
-- Задание 9 convertListFromMUPL 
convertListFromMUPL Unit = []
convertListFromMUPL (Pair x xs) = x : convertListFromMUPL xs
--------------------------------------------------------------------------------
-- Вспомогательные определения
-- нельзя вносить изменения в следующий блок
--------------------------------------------------------------------------------
envLookUp [] str = error $ "Unbound variable " ++ str
envLookUp ((var, expr) : xs) str 
  | var == str = expr
  | otherwise  = envLookUp xs str

evalExp e = evalUnderEnv e []
--------------------------------------------------------------------------------
-- Задание 10 evalUnderEnv 
-- Заданную строку определения изменять нельзя
-- необходимо дополнить определение функции
evalUnderEnv (Add e1 e2) env             =
  IntNum ((valOfIntNum (evalUnderEnv e1 env) )
          + (valOfIntNum (evalUnderEnv e2 env) )
         )
evalUnderEnv (IfGreater e1 e2 e3 e4) env
  | (valOfIntNum (evalUnderEnv e1 env) )
    > (valOfIntNum (evalUnderEnv e2 env) ) = evalUnderEnv e3 env
  | otherwise                           = evalUnderEnv e4 env
evalUnderEnv (Pair e1 e2) env            =
    Pair (evalUnderEnv e1 env) (evalUnderEnv e2 env)
evalUnderEnv (Head e) env                = pairHead (evalUnderEnv e env)
evalUnderEnv (Tail e) env                = pairTail (evalUnderEnv e env)
evalUnderEnv (IsAUnit e) env             =
  if evalUnderEnv e env == Unit
    then IntNum 1
    else IntNum 0
evalUnderEnv (Let (str, e1) e2) env      =
  evalUnderEnv e2 ( (str, evalUnderEnv e1 env) : env)
evalUnderEnv (Fun name arg e) env        = Closure env (Fun name arg e)
evalUnderEnv (Call e1 e2) env            =
  let
    v1          = evalUnderEnv e1 env
    fun         = closureFun v1
    name        = funName fun
    envWithArg  = (funArg fun, evalUnderEnv e2 env) : (closureEnv v1)
    completeEnv = if name /= []
      then (name, v1) : envWithArg
      else envWithArg
  in
    evalUnderEnv (funBody fun) completeEnv
evalUnderEnv (Var name) env              = envLookUp env name
evalUnderEnv (IntNum num) env            = IntNum num
evalUnderEnv Unit env                    = Unit
evalUnderEnv (Closure envC f) env        = Closure envC f
--------------------------------------------------------------------------------
-- Последующие решения связывают переменные Haskellа с выражениями на MUPL
-- (определяют макросы языка MUPL)
-- Задание 11 ifAUnit 
ifAUnit e1 e2 e3 =
  IfGreater (IsAUnit e1) (IntNum 0) e2 e3
-- Задание 12 mLet 
mLet [] e2 = e2
mLet (x : xs) e2 = Let x (mLet xs e2)
-- Задание 13 ifEq
ifEq e1 e2 e3 e4 =
  mLet [("_x", e1), ("_y", e2)]
       (IfGreater (Var "_x") (Var "_y") 
                  e4
                  (IfGreater (Var "_y") (Var "_x")
                             e4
                             e3))
-- Задание 14 mMap 
mMap =
  Fun "" "f"
    (Fun "loop" "l"
       (ifAUnit (Var "l")
                Unit
                (Pair (Call (Var "f")
                            (Head (Var "l")))
                      (Call (Var "loop")
                            (Tail (Var "l"))))))
-- Задание 15 mMapAddN 
mMapAddN n =
  Call mMap (Fun "" "x" (Add (Var "x") n))

-- Задание 16 fact 
fact =
  mLet [ ("sub1", Fun "sub1" "x" 
                   (Call (Fun "loop" "y" 
                            (Let ("z", Add (IntNum 1) (Var "y"))
                              (ifEq (Var "z") (Var "x")
                                    (Var "y")
                                    (Call (Var "loop") (Var "z")))))
                         (IntNum 0)))
       , ("mult", Fun "mult" "x"
                   (Fun "loop" "y"
                      (ifEq (Var "y") (IntNum 0)
                            (IntNum 0)
                            (Add (Var "x") 
                                 (Call (Var "loop") 
                                       (Call (Var "sub1") (Var "y")))))))
       ]
    (Fun "fact" "n"
       (IfGreater (IntNum 2) (Var "n")
                  (IntNum 1)
                  (Call (Call (Var "mult") (Var "n"))
                        (Call (Var "fact") 
                              (Call (Var "sub1") 
                                    (Var "n"))))))