class BottleMachine
  RowCount = 10						            #количество рядов
  PlaceNumber = 8					            #количество едениц товара в каждом ряду
  Banknotes = [100, 50, 10, 5, 2, 1]  #наменалы принимаемых купюр
  Value = 10				     	            #объем одной касеты для купюр


  def initialize 	# создание автомата
    @goods     		= Array.new(RowCount){[nil, 0, 0]}				       # список товаров
    @bills    		= Hash[Banknotes.map { |nominal| [nominal, 0] }] # список купюр находящихся в автомате
    @capacity 		= Hash[Banknotes.map { |nominal| [nominal, 0] }] # емкость с общей денежной массой
    @sale       	= Hash.new {} 							                     # проданные товары
    @cache     		= 0												                       # кэш автомата
    puts "Автомат установлен"
  end


  def empty 		# опустошение автомата
    @goods     		= Array.new(RowCount){[nil, 0, 0]}
    @bills      	= Hash[Banknotes.map { |nominal| [nominal, 0] }]
    @capacity   	= Hash[Banknotes.map { |nominal| [nominal, 0] }]
    @sale       	= Hash.new {}
    @cache     		= 0
    puts "Автомат опустошен"
  end

#цену менять, дозагружать в ряды..
  def load (addHash)	# загрузка товаров в автомат
    rest     = Array.new(){[nil, 0]}		# список непоместившихся товаров
    
    addHash.each do |product, count|    
      if count[1] > 0
        @goods.each_with_index do |oneRow, index|
          if @goods[index][0] == nil &&
              count[1] > 0
            n = count[1] <= PlaceNumber ? count[1] : PlaceNumber
            @goods[index] = [product, count[0], n]
            count[1] -= n
          end
        end
      end

      if count[1] > 0
          rest.push(product, count[1])
      end
    end
    puts ["Не поместились напитки: ", rest]
    self
  end


  def deposit (addHash) 		# внесение денег в автомат
    balance = 0

    addHash.each do |banknote, number|
      if @bills.has_key? banknote
      	empty = Value - @bills[banknote]		# узнаем кол-во свободных ячеек для данной купюры

      	if empty >= number
          @bills[banknote] += number
          newMoney       	  = banknote * number
          @cache   	  	   += newMoney
          balance 	  	   += newMoney
        else
          @bills[banknote] 	  += empty
          @capacity[banknote] += number   - empty
          newMoney       	     = banknote * number
          @cache   	  		    += newMoney
          balance 	  		    += newMoney
        end
      else
        puts "Автомат не принимает данную купюру: #{banknote}"
      end
    end
    puts "Ваш счёт увеличен на #{balance}"
    self
  end



  def order (name) 		# покупка товра
    @goods.each_with_index do |oneRow, index|
      if  @goods[index][0] == name &&
          @goods[index][2] > 0

           order = @goods[index][1]
        if order <= @cache
          @cache -= order
          @goods[index][2] -= 1
          # свернуть до проходу по Bancnotes
          if @bills.include?(order)
             @bills[@goods[index][1]] -= 1
           else
            if @bills[100] > order.div(100)
              @bills[100] -= order.div(100)
              order = order % 100
            end
            if @bills[50] > order.div(50)
              @bills[50] -= order.div(50)
              order = order % 50
            end
            if @bills[10] > order.div(10)
            @bills[10] -= order.div(10)
            order = order % 10
            end
            if @bills[5] > order.div(5)
            @bills[5] -= order.div(5)
            order = order % 5
            end
            if @bills[2] > order.div(2)
            @bills[2] -= order.div(2)
            order = order % 2
            end
            if @bills[1] > order.div(1)
            @bills[1] -= order.div(1)
            end
            order = @goods[index][1]
          end

          if not @sale.has_key? name
            @sale[name] = [order, 1]
          else
            @sale[name] = [@sale[name][0] + order, @sale[name][1] + 1]
          end

          puts "Куплено #{name}"
        else
          puts "У Вас не хватает денег #{@goods[index][1]} для покупки #{name}"
        end

        if @goods[index][2] == 0
          @goods[index] = [nil, 0, 0]
        end

        return self
      end
    end
    puts "Напитка нет в наличии"
    self
  end


  def withdraw
  	money = 0
    if @cache > 0
      retryH = Hash[Banknotes.map { |nominal| [nominal, 0] }]

      @bills.sort.map do |banknote, number|
        while @cache >= banknote &&
               number > 0 do

          @cache -= banknote
          number -= 1
          @bills[banknote] -= 1
          retryH[banknote] += 1
        end
      end

      retryH.each do |banknote, number|
        money += banknote * number
      end
      puts "Автомат возвращает #{money} монет. На депозите #{@cache} монет"
      return retryH
    else
      puts "Error! На вашем депозите нет средств"
      return Hash.new
    end
    self
  end


  def status
    bankInfo = Hash[Banknotes.map { |x| [x, @bills[x]] }]
    notEmpty = Array.new
    @goods.each do |inRow|
      notEmpty << inRow if inRow[0]
    end
    puts ["Напитки:", @goods, "Депозит:", @cache, "Банкноты:", bankInfo, "Емкость:", @capacity]
    self
  end


  def stat
    @sale
  end
  self
end

nm = BottleMachine.new
#nm.empty
nm.load({'Sprite' => [50,10], 'Fanta' => [10, 10], 'Coca-Cola' => [25, 10]})
nm.deposit({100 => 50, 50 => 5, 10 => 3, 2 => 5, 1 => 7})
#nm.order('Sprite')
#nm.order('Coca-Cola')
#nm.order('Coca-Cola')
#puts nm.stat
#nm.status
#puts nm.withdraw
#puts nm.stat