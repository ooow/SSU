## Шаблон для выполнения заданий Лабораторной работы №6 
## ВСЕ КОММЕНТАРИИ ПРИВЕДЕННЫЕ В ДАННОМ ФАЙЛЕ ДОЛЖНЫ ОСТАТЬСЯ НА СВОИХ МЕСТАХ
## НЕЛЬЗЯ ПЕРЕСТАВЛЯТЬ МЕСТАМИ КАКИЕ-ЛИБО БЛОКИ ДАННОГО ФАЙЛА
## решения заданий должны быть вписаны в отведенные для этого позиции 

################################################################################
# Задание 1 
################################################################################
class Array 
  # add b
  def add b
    self.each_with_index.map {|x, i| x += b[i]}
  end
end
# конец описания задания 1
################################################################################

################################################################################
# Задания 2-6 
# Класс Field
################################################################################
class Field 
  FieldSize = 10
  def initialize
    @field = Array.new(FieldSize){Array.new(FieldSize)}
  end
  # Задание 3 size (метод класса)
  def size
    @FieldSize
  end

  # Задание 4 set!(n, x, y, hor, ship)
  def set!(n, x, y, hor, ship = nil)
    i = 0
    j = 0
    hor == true ? i = n - 1 : j = n - 1
    while i >= 0 && j >= 0 do 
      @field[x + i][y + j] = ship
      i == 0 ? j-=1 : i-=1
    end
  end

  # Задание 5 print_field
  def print_field
    k = FieldSize
    str = "+"
    while k > 0 do
      str += "-"
      k -=1
    end
    str += "+"
    puts str
    str1 = ""
    @field.each do |i|
      str1 += "|"
      i.each do |j| 
        j != nil ? str1 += j.to_s : str1 += " "
      end
      str1 += "|\n"
    end
    puts str1
    puts str
  end

  # Задание 6 free_space?(n, x, y, hor, ship)
  def free_space?(n, x, y, hor, ship = nil)
    if hor == true
      if x < 0 || x + n - 1 >= FieldSize || y < 0 || y >= FieldSize
        return false
      else
        j = y - 1
        while j <= y + 1 do
          if j < 0 || j >= FieldSize
            j += 1
          else
            i = x - 1
            while i <= x + n do
              if i < 0 || i >= FieldSize
                i += 1
              else
                if @field[i][j] != nil && @field[i][j] != ship
                  return false
                else
                  i += 1
                end
              end             
            end 
            j += 1 
          end
        end
        return true
      end
    else
      if x < 0 || x >= FieldSize || y < 0 || y + n - 1 >= FieldSize
        return false
      else
        i = x - 1
        while i <= x + 1 do
          if i < 0 || i >= FieldSize
            i += 1
          else
            j = y - 1
            while j <= y + n do
              if j < 0 || j >= FieldSize
                j += 1
              else
                if @field[i][j] != nil && @field[i][j] != ship
                  return false
                else
                  j += 1
                end
              end             
            end 
            i += 1 
          end
        end
        return true
      end
    end
  end
end

f = Field.new
f.set!(4,3,3,false,1)
f.set!(3,5,4,true,2)
f.set!(1,9,9,true, 3)
f.print_field
puts f.free_space?(4,0,3,true,1)
puts f.free_space?(4,1,3,true,7)
puts f.free_space?(4,7,2,true,7)
# конец описания класса Field
################################################################################


################################################################################
# Задания 7-16 
# Класс Ship
################################################################################
class Ship 
  def initialize(field, len) 
    @len = len 
    @myfield = field 
    @maxhealth = 100 * @len
    @minhealth = 30 * @len
    @health = @maxhealth
  end 
  
  def len 
  @len 
  end 
  
  def coodr 
  @coodr 
  end
  
  def getFF
    @myfield
  end

  # Задание 8 to_s
  def to_s
    "X"
  end

  # Задание 9 clear
  def clear
    x1 = @coodr[0]
    y1 = @coodr[1]
    x2 = @coodr[2]
    y1 = @coodr[3]
    if @hor == true
      while x1 <= x2
        @myfield[x1][y1]  = nil
        x1 += 1
      end
    else 
      while y1 <= y2
        @myfield[x1][y1]  = nil
        y1 += 1
      end
    end
  end

  # Задание 10 set!(x, y, hor)
  def set!(x, y, hor)
    if @myfield.free_space?(@len, x, y, @hor, self)
      @myfield.set!(@len, x, y, hor, self)
      @hor = hor
      if @coodr == []
        @coodr[0] = x
        @coodr[1] = y
        if hor == true
          @coodr[2] = x + @len
          @coodr[3] = y
        else
          @coodr[2] = x
          @coodr[3] = y + @len
        end
      else
        clear
        @coodr[0] = x
        @coodr[1] = y
        if hor == true
          @coodr[2] = x + @len
          @coodr[3] = y
        else
          @coodr[2] = x
          @coodr[3] = y + @len
        end
      end
      return true
    else
      return false
    end
  end

  # Задание 11 kill
  def kill
    clear
    @coodr = nil
  end

  # Задание 12 explode
  def explode
    @health -= 70
    if @health <= @minhealth
      kill
      return @len
    end
  end 

  # Задание 13 cure
  def cure
    @health + 30 <= @maxhealth ? @health += 30 : @health = @maxhealth
  end

  # Задание 14 health
  def health
    (@health / @len * 100).to_i.to_f / 100
  end

  # Задание 15 move(forward)
  # Задание 16 rotate(n, k)
end
# конец описания класса Ship
################################################################################

################################################################################
# Задания 17-25
# Класс BattleField
################################################################################

  # Задание 18 fleet

  # Задание 19 place_fleet pos_list

  # Задание 20 remains

  # Задание 21 refresh

  # Задание 22 shoot c

  # Задание 23 cure

  # Задание 24 game_over?

  # Задание 25 move l_move

# конец описания класса BattleField
################################################################################


################################################################################
# Задания 26-31
# Класс Player
################################################################################

  # Задание 27 random_point

  # Задание 28 place_strategy ship_list

  # Задание 29 hit message
  #            miss

  # Задание 30 shot_strategy
  def shot_strategy
    if @manual
      @lastshots.each {|x| print(x, "\n")}
      puts "Make a shot. To switch off the manual mode enter -1 for any coordinate"
      while true
        print "x = "; x = gets.to_i; print x
        print " y = "; y = gets.to_i; puts y
        shot = [x,y]
        if shot.all? {|a| a.between?(-1, Field.size - 1)}
          break
        else
          puts "Incorrect input"
        end
      end
      if shot.any? {|a| a == -1}
        @manual = false
        shot_strategy
      else
        @shot = shot
      end
    else
      # Здесь необходимо разместить решение задания 30

      # конец решения задания 30
    end
  end

  # Задание 31 ship_move_strategy remains
  def ship_move_strategy remains
    if @manual
      puts "Ship health"
      tmp_field = Field.new
      names = ("0".."9").to_a + ("A".."Z").to_a + ("a".."z").to_a
      ship_hash = {}
      remains.each do |ship|
        name = names[ship[0]]
        x = ship[1][0]; y = ship[1][1]
        hor = (ship[1][1] == ship[1][3])
        ship_hash[name] = [ship[0], ship[2]]
        tmp_field.set!(ship[2], x, y, hor, name)
        print(name, " - ", ship[3], "%\n") 
      end
      puts "Your ships"
      tmp_field.print_field
      puts "Make a move. To switch off the manual mode enter an incorrect ship name"
      while true
        print "Choose ship: "; 
        name = gets.strip; puts name
        if !ship_hash[name] then break end
        move = 0
        begin
          print "Enter 0 to move, 1-3 to rotate: " 
          move = gets.to_i; puts move
        end until move.between?(0,3)
        if move == 0
          print "1 - forward/any - backward): "; dir = gets.to_i
          puts dir
        else
          dir = 0
          begin
            print "Choose a center point: (1..#{ship_hash[name][1]}): "
            dir = gets.to_i; puts dir
          end until dir.between?(1,ship_hash[name][1])
        end
        break
      end
      if !ship_hash[name]
        @manual = false
        ship_move_strategy remains
      else
        [ship_hash[name][0], move, dir]
      end
    else
      # Здесь необходимо разместить решение задания 31
      
      # конец решения задания 31
    end
  end 


# конец описания класса Player
################################################################################

################################################################################
# Задания 32-33 
# Класс Game
################################################################################

  # Задание 33 start

# конец описания класса Game
################################################################################

################################################################################
# Переустановка датчика случайных чисел
################################################################################
srand
################################################################################

#№ Пример запуска
# p1 = Player.new("Ivan",true)
# p2 = Player.new("Feodor")
# g = Game.new(p1,p2)
# g.start