
-- Точка (вектор) в трехмерном пространстве
-- (с реализацией аффинных преобразований, операций над векторами)
data Vector = V Double Double Double

epsilon = 0.0000001

class Vec a where
  dlina :: a -> Double
  vnanum :: Double -> a -> a
  vscal :: a -> a -> Double
  move :: a -> (Double, Double, Double) -> a
  rotate :: a -> Double -> a -> a
  norm :: a -> a
  uToX :: a -> Double
  uToY :: a -> Double
  uToZ :: a -> Double

instance Eq Vector where
  (==) (V x1 y1 z1) (V x2 y2 z2) = (x1 == x2) && (y1 == y2) && (z1 == z2)
  (/=) a b = not (a == b)

instance Show Vector where
  show (V x y z) = 
    let
      xx = if abs x < epsilon then 0.0 else x
      yy = if abs y < epsilon then 0.0 else y
      zz = if abs z < epsilon then 0.0 else z
    in
      "(" ++ show xx ++ ", " ++ show yy ++ ", " ++ show zz ++ ")"
  
instance Num Vector where 
  (+) (V x1 y1 z1) (V x2 y2 z2) = V (x1 + x2) (y1 + y2) (z1 + z2)
  (-) (V x1 y1 z1) (V x2 y2 z2) = V (x1 - x2) (y1 - y2) (z1 - z2)
  negate (V x y z) = V (negate x) (negate y) (negate z)
  
instance Vec Vector where

  -- Длина вектора
  dlina (V x y z) = sqrt (x * x + y * y + z * z)

  -- Умножение вектора на число
  vnanum c (V x y z) = V (x * c) (y * c) (z * c)
  -- Скалярное умножение
  vscal (V x1 y1 z1) (V x2 y2 z2) = x1 * x2 + y1 * y2 + z1 * z2
  -- Перемещение вектора
  move (V x y z) (iX, iY, iZ) = V (x + iX) (y + iY) (z + iZ)

  -- Поворот вектора относительно вектора( либо лубой точки,
  -- записанной в виде вектора)
  rotate (V x y z) phi (V nx ny nz) =
    V ((cos(phi) + (nx * nx * (1 - cos(phi)))) * x
    + (nx * ny * (1 - cos(phi)) - nz * sin(phi)) * y
    + (nx * nz * (1 - cos(phi)) + ny * sin(phi)) * z)

    ((nx * ny * (1 - cos(phi)) + nz * sin(phi)) * x
    + (cos(phi) + ny * ny * (1 - cos(phi))) * y
    + (ny * nz * (1 - cos(phi)) - nx * sin(phi)) * z)

    ((nx * nz * (1 - cos(phi)) - ny * sin(phi)) * x
    + (ny * nz * (1 - cos(phi)) + nx * sin(phi)) * y
    + (cos(phi) + nz * nz * (1 - cos(phi))) * z)

  -- Нормализация вектора
  norm (V x y z) = V (x / sqrt(x * x + y * y + z * z))
                     (y / sqrt(x * x + y * y + z * z))
                     (z / sqrt(x * x + y * y + z * z))

  -- Нахождение углов наклона к осям
  uToX (V x y z) = atan (x / y)
  uToY (V x y z) = atan (y / x)
  uToZ (V x y z) = atan (y + x / z)

-- Примеры
v1 = V 7.5 4.0 2
v2 = V 1.2 5.3 3.1
v3 = V 7.5 4 2
v4 = V 9 0 8
vx = V 1 0 0
vy = V 0 1 0
vz = V 0 0 1

main = do
  print $ v1
  print $ v2
  print $ v3
  print $ v4
  print $ v1 == v2
  print $ v1 == v3
  print $ move v1 (1, 1, 1)
  print $ dlina v2
  print $ uToX v3
  print $ v1 - v2
  print $ vnanum 5 v1
  print $ vscal v1 v4
  print $ norm v4
--Поворот векттора относительно осей x, y, z
  print $ rotate v4 pi vx
  print $ rotate v4 pi vy
  print $ rotate v4 pi vz --                                         [100 lines]