
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
  --, mMapAddN
  --, fact
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
funName (Fun name x y) = name
funName e              = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " The expression e is not a function"
-- Задание 2 funArg 
funArg (Fun name x y) = x
funArg e              = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " The expression e is not a function"
-- Задание 3 funBody 
funBody (Fun name x y) = y
funBody e              = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " The expression e is not a function"
-- Задание 4 pairHead 
pairHead (Pair a b) = a
pairHead e              = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " The expression e is not a pair"
-- Задание 5 pairTail 
pairTail (Pair a b) = b
pairTail e          = error $ "The expression " 
                                 ++ show (e) 
                                 ++ " The expression e is not a pair"
-- Задание 6 closureFun 
closureFun (Closure l fun) = fun
closureFun e                          = error $ "The expression " 
                                        ++ show (e) 
                                        ++ "The expression e is not a closure"
-- Задание 7 closureEnv 
closureEnv (Closure l fun) = l
closureEvn e                          = error $ "The expression " 
                                        ++ show (e) 
                                        ++ "The expression e is not a closure"
-- Задание 8 convertListToMUPL 
convertListToMUPL [] = Unit
convertListToMUPL [x] = Pair x Unit
--convertListToMUPL [ll, ls] = Pair ll ls
convertListToMUPL l = Pair (head l) (convertListToMUPL (tail l))
-- Задание 9 convertListFromMUPL 
convertListFromMUPL Unit = []
convertListFromMUPL (Pair x Unit) = [x]
--convertListFromMUPL (Pair x y) = [x, y]
convertListFromMUPL (Pair x z) = x : convertListFromMUPL z

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
evalUnderEnv (Var name) env = envLookUp env name
evalUnderEnv (IntNum x) env = IntNum x
evalUnderEnv Unit env = Unit
--evalUnderEnv (Closure [] f) env = Closure [] f
evalUnderEnv (Add a b) env = IntNum ((valOfIntNum (evalUnderEnv a env)) + 
                             (valOfIntNum (evalUnderEnv b env)))
evalUnderEnv (IfGreater e1 e2 e3 e4) env 
           | (valOfIntNum (evalUnderEnv e1 env)) > 
             (valOfIntNum (evalUnderEnv e2 env)) = evalUnderEnv e3 env
           | otherwise                           = evalUnderEnv e4 env
evalUnderEnv (Pair e1 e2) env = Pair (evalUnderEnv e1 env) (evalUnderEnv e2 env)
evalUnderEnv (Head e) env = pairHead (evalUnderEnv e env)
evalUnderEnv (Tail e) env = pairTail (evalUnderEnv e env)
evalUnderEnv (IsAUnit e) env
           | (evalUnderEnv e env) == Unit = IntNum 1
           | otherwise                    = IntNum 0
evalUnderEnv (Let (str, e1) e2) env =
           evalUnderEnv e2 [(str, evalUnderEnv e1 env)]
evalUnderEnv (Fun name arg e) env 
        = Closure env (Fun name arg e)
evalUnderEnv (Call e1 e2) env = 
  let 
    temp = evalUnderEnv e1 env
    temp2 = evalUnderEnv e2 env
    name = funName (closureFun temp)
    env1 = if name == [] then []
                else [(name, temp)]
    env_new = env1 ++ [(funArg (closureFun temp), temp2)] ++ (closureEnv temp)
  in 
   evalUnderEnv (funBody (closureFun (evalUnderEnv (closureFun temp) env_new))) env_new

--------------------------------------------------------------------------------
-- Последующие решения связывают переменные Haskellа с выражениями на MUPL
-- (определяют макросы языка MUPL)

-- Задание 11 ifAUnit 
ifAUnit e1 e2 e3 = IfGreater (IsAUnit e1) (IntNum 1) e3 e2

-- Задание 12 mLet 
mLet [] e = e 
mLet (l : ns) e = Let l (mLet ns e)

-- Задание 13 ifEq 
ifEq e1 e2 e3 e4 = IfGreater e1 e2 e4 (IfGreater e2 e1 e4 e3)

-- Задание 14 mMap
mMap = Fun "mMap" "fun" (Fun "" "pair" (ifAUnit (Var "pair") (Var "pair") 
  (Pair (Call (Var "fun") (Head (Var "pair"))) 
  (Call (Call mMap (Var "fun")) (Tail (Var "pair"))))))

-- Задание 15 mMapAddN 

-- Задание 16 fact 



