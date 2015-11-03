(defun make (op initial start)
  (if (null start)
      initial
    (funcall op (car start)
         (make op initial (cdr start)))))

(defun flat (x)
  (make #'append '() x))

(defun permutations (L)
  (labels ((cycle (l r result)
                  (if (null r) result
                    (let ((l2 (append l (list (car r))))
                          (r2 (cdr r)))
                      (cycle l2 r2 (cons (append r2 l2)
                                                result))))))
  (cycle nil L nil)))

(defun cicle (L)
  (if (null L) (list nil)
    (flat (mapcar (lambda (permut)
                  (permutations permut))
            (flat (mapcar (lambda (cdr-perm)
                            (if (listp (car L))
                                (mapcar (lambda (car-perm)
                                          (cons car-perm
                                                cdr-perm))
                                (cicle (car L)))
                            (list (cons (car L) cdr-perm))))
                  (cicle (cdr L))))))))

(print (cicle '(1 9)))
(print (cicle '(X Y Z)))
(print (cicle '((A B)(C D))))