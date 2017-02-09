(print 
  (let ((L ' (A (B) (C D (E X)) F G H)))
    (cadr
      (caddr
        (caddr L))))) 