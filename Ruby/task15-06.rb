class MyConditioner < Conditioner
end
###################################################
class MyHeater < Heater 
# метод перевода в режим ожидания
  def reset
    @heat_per_tact = 0.5 # степень обогрева (изменение температуры) 
                       	 # за один такт работы
    @tact = 0.3        	 # длительность такта
    @change = 0        	 # суммарное изменение температуры
  end

  def set_off(step = 0.5)
    @status = false
    @heat_per_tact = step
  end

  # метод перевода в режим работы
  def set_on(step = 0.5)
    @status = true
    if step > @heat_per_tact
      @heat_per_tact = step
    end
  end

  # селектор (getter) статуса обогревателя 
  def status (tr = 0)
  	if tr > 0
  		if @status
  			" tact: " + @heat_per_tact.to_s #если обогреватель включен, выводим степень обогрева (от 0.5 до 4)
  		else
  			""
  		end
  	else
  		@status
  	end
  end
 end


class MyClimateControl < ClimateControl
# запуск/отключение обогревателя
  def check_heater
    if @home.temperature > @heater_start # если превышен темп. барьер
      @home.heater.set_off               # перевести в режим ожидания
    else
    	tac = @heater_start - @home.temperature	# от температурного порога включения обогревателя отнимаю температуру дома
      if tac < 2
        @home.heater.set_on 0.5
      elsif tac < 4
        @home.heater.set_on 1
         elsif tac < 6
        @home.heater.set_on 1.5
         elsif tac < 8
        @home.heater.set_on 2
         elsif tac < 10
        @home.heater.set_on 2.5
         elsif tac < 12
        @home.heater.set_on 3
         elsif tac < 14
        @home.heater.set_on 3.5
      else 
        @home.heater.set_on 4
      end
    end
  end
end


###################################################
class MyReporter < Reporter
  # формирование строки с текущим статусом обогревателя
  def heater_status_s
    "heater: " + bool_to_on_off_s(@home.heater.status) + @home.heater.status(1)
  end
  # формирование строки с текущей температурой
  def temp_s
    "t: " + ((@home.temperature * 10).to_i.to_f / 10).to_s
  end
end
###################################################
class MyWeather < Weather
# пересмотр списка циклонов
  def cyclons_review
    if @cyclons.size < 3   # если количество активных циклонов меньше 3-х
      @cyclons.push(new_cyclon.get_runner) if rand(10) > 6
                           # то с вероятностью 3/10 возникает 
                           # (добавляется) новый циклон (его процесс)
    end
  end
  # создать новый циклон
  def new_cyclon
    MyCyclon.new_cyclon self # запустить метод класса Cyclon для создания циклона,
                           # self передается как параметр 
  end
end
###################################################
class MyCyclon < Cyclon     
  MyCyclons = Cyclons + [[-2.1, -1.4, -0.7, 0, 0.7, 1.4, 2.1],[-3.9, -2.6, -1.3, 0, 1.3, 2.6, 3.9]]
   def self.new_cyclon weather
    # берется случайный представитель списка Cyclons 
    # и с ним создается новый циклон
    MyCyclon.new(MyCyclons.sample, weather)
  end
end
###################################################
class MyGlasshouse < Glasshouse
  # метод установки начальных параметров погоды
  def set_weather
    @weather = MyWeather.new  # создание нового симулятора погоды
  end

  # метод установки параметров теплицы
  def set_glasshouse
    @conditioner = MyConditioner.new self # прикрепить новый кондиционер
    @heater = MyHeater.new self           # прикрепить новый обогреватель
    @climate_control = MyClimateControl.new(self, 15, 25)
                                        # прикрепить систему климат-контроля
    @reporter = MyReporter.new self       # прикрепить метеостацию
  end
end
###################################################