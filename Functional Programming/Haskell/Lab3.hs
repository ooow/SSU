
-- Шаблон для выполнения заданий Лабораторной работы №3 

-- ниеже перечисляются имена, доступные после загрузки данного модуля
-- (например в файле с тестами)
-- по мере реализации решений заданий снимайте комментарий 
-- с соответствующей функции
module Lab3 
  ( epsilon
  , epsilon'
  , epsilon''
  , nat
  , fibonacci
  , factorial
  , powerSeq
  , findCloseEnough
  , streamSum
  , expSummands
  , expStream
  , expAppr
  , derivationAppr
  , derivationStream
  , derivation
  , funAkStream 
  , invF
  , average
  , averageDump
  , newtonTransform
  , eitken
  , fixedPoint
  , fixedPointOfTransform
  , sqrt1
  , sqrCube1
  , sqrt2
  , sqrCube2
  , extremum
  , myPi
  ) where
--------------------------------------------------------------------------------
-- Вспомогательные определения
--------------------------------------------------------------------------------
import Data.List
epsilon  = 0.001
epsilon' = 0.00001
epsilon'' = 0.00000001
--------------------------------------------------------------------------------
-- Задание 1 nat 
nat = iterate (+1) 1

-- Задание 2 fibonacci 
fibonacci = [0, 1] ++ zipWith (+) fibonacci (tail fibonacci)

-- Задание 3 factorial 
factorial = [1] ++ zipWith (*) factorial nat

-- Задание 4 powerSeq 
powerSeq x = [1] ++ map (x*) (powerSeq x)

-- Задание 5 findCloseEnough
findCloseEnough eps stream =
  let
    valOf (Just a) = a
    second (_, a) = a
    cs = zipWith (,) stream (tail stream)
  in
    (second . valOf) (find (\(a, b) -> abs (a - b) <= eps) cs)

-- Задание 6 streamSum
streamSum stream = [head stream] ++ zipWith (+) (tail stream) (streamSum stream)

-- Задание 7 expSummands 
expSummands x = 
  zipWith (\a b -> a / fromIntegral b) 
    (powerSeq x) (factorial)

-- Задание 8 expStream 
expStream = streamSum . expSummands

-- Задание 9 expAppr 
expAppr eps x = findCloseEnough eps (expStream x)

-- Задание 10 derivationAppr 
derivationAppr f dx x = (f (x + dx) - f x) / dx

-- Задание 11 derivationStream 
derivationStream f x = map (\item -> derivationAppr f item x) (powerSeq (1 / 2))

-- Задание 12 derivation 
derivation f x = findCloseEnough epsilon' (derivationStream f x)

-- Задание 13 funAkStream и invF   
funAkStream g = 
  let
    fn item = \y -> derivation item y / g y
  in
    iterate fn (\z -> z)

invF f y0 x = 
  let
    secondList = expSummands (x - (f y0))
    firstList  = map (\f -> f y0) (funAkStream (derivation f))
    multi = zipWith (*) firstList secondList
    presum = streamSum multi
  in
    findCloseEnough epsilon presum

-- Задание 14 average 
average x y = (x + y) / 2.0

-- Задание 15 averageDump 
averageDump f x = average (f x) x

-- Задание 16 newtonTransform 
newtonTransform g x = x - (g x) / (derivation g x)

-- Задание 17 eitken 
eitken (a : b : c : cs) = (a * c - b * b) / (c - 2 * b + a) : eitken cs

-- Задание 18 fixedPoint
fixedPoint f x0 = iterate f x0

-- Задание 19 fixedPointOfTransform 
fixedPointOfTransform f transform x0 = 
  findCloseEnough epsilon' (fixedPoint (transform f) x0)

-- Задание 20 sqrt1 
sqrt1 x = fixedPointOfTransform (\y -> x / y) averageDump 0.1

-- Задание 21 sqrCube1 
sqrCube1 x = fixedPointOfTransform (\y -> x / (y * y)) averageDump 0.1

-- Задание 22 sqrt2 
sqrt2 x = fixedPointOfTransform (\y -> y * y - x) newtonTransform 0.1

-- Задание 23 sqrCube2 
sqrCube2 x = fixedPointOfTransform (\y -> y * y * y - x) newtonTransform 0.1

-- Задание 24 extremum
extremum f =
  let
    f' = derivation f
    x = fixedPointOfTransform f' newtonTransform 0.1
    f'' = derivation f'
  in
    if f'' x > epsilon then (x, "minimum") else 
      if f'' x < -epsilon then (x, "maximum") else
        (x, "inflection")

-- Задание 25 myPi
myPi =
  let
    numerator = iterate ((-1)*) 1
    denominator = iterate (+2) 1
    sequence = zipWith (/) numerator denominator
    presum = streamSum sequence
    newSeq = eitken presum
  in
    4 * (findCloseEnough epsilon'' newSeq)