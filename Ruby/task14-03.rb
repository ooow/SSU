class BottleMachine
  RowCount = 10						 #количество рядов
  PlaceNumber = 5					 #количество едениц товара в каждом ряду
  Banknotes = [100, 50, 10, 5, 2, 1] #наменалы принимаемых купюр
  CassetteV = 10				     #объем одной касеты для купюр

  def initialize
    @innerRows      = Array.new(RowCount){[nil, 0, 0]}
    @cassetStore    = Hash[Banknotes.map { |nominal| [nominal, 0] }]
    @cassetAddition = Hash[Banknotes.map { |nominal| [nominal, 0] }]
    @saleData       = Hash.new {[0, 0]}
    @deposCount     = 0
    puts "Автомат установлен"
  end


  def empty
    @innerRows      = Array.new(RowCount){[nil, 0, 0]}
    @cassetStore    = Hash[Banknotes.map { |nominal| [nominal, 0] }]
    @cassetAddition = Hash[Banknotes.map { |nominal| [nominal, 0] }]
    @saleData       = Hash.new {[0, 0]}
    @deposCount     = 0
    puts "Автомат опустошен"
  end


  def load (addHash)
    deletedProd     = Hash.new
    addHash.each do |product, info|

      if info[1] > 0
        @innerRows.each_with_index do |oneRow, index|
          if @innerRows[index][0] == nil &&
              info[1] > 0
            numForAdd = info[1] <= PlaceNumber ? info[1] : PlaceNumber
            @innerRows[index] = [product, info[0], numForAdd]
            info[1] -= numForAdd
          end
        end
      end

      @innerRows.each_with_index do |oneRow, index|
        if @innerRows[index][0] == product &&
            @innerRows[index][2] <  PlaceNumber &&
            info[1] > 0

          numForAdd = info[1] <= PlaceNumber ? info[1] : PlaceNumber
          @innerRows[index] = [product, info[0], numForAdd]
          info[1] -= numForAdd
        end
      end

      if info[1] > 0
        deletedProd[product] = info
      end
    end

    return deletedProd
  end


  def deposit (addHash)
    sizeOfDeposit = 0

    addHash.each do |banknote, number|
      if @cassetStore.has_key? banknote
        addedBank      = banknote * number
        @deposCount   += addedBank
        sizeOfDeposit += addedBank

        emptySlot  = CassetteV - @cassetStore[banknote]

        if emptySlot >= number
          @cassetStore[banknote] += number
        else
          @cassetStore[banknote] += emptySlot
          @cassetAddition += banknote * (number - emptySlot)
        end
      else
        puts "#Автомат не принимает данную купюру: {banknote}"
      end
    end
    puts "Ваш счёт увеличен на #{@total}"
    self
  end


  def order (name)
    @innerRows.each_with_index do |oneRow, index|
      if  @innerRows[index][0] == name &&
          @innerRows[index][2] > 0

           order = @innerRows[index][1]
        if order <= @deposCount
          @deposCount -= order
          @innerRows[index][2] -= 1

          if not @saleData.has_key? name
            @saleData[name] = [order, 1]
          else
            @saleData[name] = [@saleData[name][0] + order, @saleData[name][1] + 1]
          end

          puts "Куплено #{name}"
        else
          puts "У Вас не хватает денег #{@rows[index][1]} для покупки #{name}"
        end

        if @innerRows[index][2] == 0
          @innerRows[index] = [nil, 0, 0]
        end

        return self
      end
    end
    puts "Напиток не доступен"
    self
  end


  def withdraw
    if @deposCount > 0
      retryBank = Hash[Banknotes.map { |nominal| [nominal, 0] }]

      @cassetStore.sort.map do |banknote, number|
        while @deposCount >= banknote &&
               number > 0 do

          @deposCount -= banknote
          number -= 1
          @cassetStore[banknote] -= 1
          retryBank[banknote] += 1
        end
      end

      total_returned = 0
      retryBank.each do |banknote, number|
        total_returned += banknote * number
      end
      puts "#Автомат возвращает {total_returned} монет. На депозите #{@deposit_counter} монет"

      return retryBank
    else
      puts "Error! Ваш депозит пуст"
      return Hash.new
    end
  end


  def status
    money = 0
    bankInfo = Hash[Banknotes.map { |x| [x, @cassetAddition[x] + @cassetStore[x]] }]
    bankInfo.each do |banknote, number|
      money += banknote * number
    end

    notEmpty = Array.new
    @innerRows.each do |inRow|
      notEmpty << inRow if inRow[0]
    end

    [@innerRows, money, bankInfo]
  end


  def stat
    @saleData
  end
end

nm = BottleMachine.new
nm.empty
nm.load({'Sprite' => [50,8], 'Fanta' => [35, 12], 'Coca-Cola' => [40, 12]})
nm.deposit({100 => 5, 50 => 5, 10 => 3, 2 => 5, 1 => 7})
puts nm.status