b = [100, 50, 10, 5, 2, 1]
i = 3
bills = {100 => 3, 50 => 8, 10 => 5, 2 => 2, 1 => 3}
i = bills[i]
puts bills.max_by{ |a, b|  a * b}[0]
