(defun y (N)
  (labels 
    ((elem (i j) 
       (/ j (* i i)))
     (iter (i j prod prodd) 
       (cond ((> i N) prodd)
             ((> j N) (iter (+ i 1) 1 1 (* prodd prod)))
             (T (iter i (+ j 1) (* prod (elem i j)) prodd)))))
    (iter 1 1 1 1)))


(print (y 2))
(print (y 3))
(print (y 4))
(print (y 5))
(print (y 10))