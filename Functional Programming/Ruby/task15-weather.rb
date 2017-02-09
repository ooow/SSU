# подгружаются вспомогательные определения
require_relative './task15-timemachine'

# кондиционер (устройство охлаждения)
class Conditioner < TimeMachine
  def initialize home 
    @home = home # объект, в котором кондиционер установлен
    reset        # установка начальных параметров
    set_off      # установка в режим ожидания
  end

  # метод установки начальных параметров
  def reset
    @cold_per_tact = 2  # степень охлаждения (изменение температуры) 
                        # за один такт работы
    @tact = 0.4         # длительность такта
    @change = 0         # накопленное изменение температуры
  end

  # метод перевода в режим ожидания
  def set_off
    @status = false  # перевести в режим ожидания
  end

  # метод перевода в режим работы
  def set_on
    @status = true   # перевести в режим работы
  end

  # метод изменения температуры за один такт
  def check_and_change
    if @status then             # если в режиме работы
      @change += @cold_per_tact # то температура изменяется 
    end

  end

  # метод выдает процесс работы кондиционера
  def get_runner
    repeat_every @tact do # каждый такт (каждый отрезок времени)
      check_and_change    # изменяется температура
    end
  end

  # селектор (getter) изменения температуры
  def change
    @change
  end

  # селектор (getter) статуса кондиционера 
  def status
    @status
  end
end

# Обогреватель
class Heater < TimeMachine
  def initialize home 
    @home = home  # объект, в котором установлен обогреватель
    reset         # установка начальных параметров
    set_off       # перевод в режим ожидания
  end

  #  метод установки начальных параметров
  def reset
    @heat_per_tact = 1 # степень обогрева (изменение температуры) 
                       # за один такт работы
    @tact = 0.3        # длительность такта
    @change = 0        # суммарное изменение температуры
  end

  # метод перевода в режим ожидания
  def set_off
    @status = false
  end

  # метод перевода в режим работы
  def set_on
    @status = true
  end

  # метод изменения температуры за один такт
  def check_and_change
    if @status then             # если в режиме работы
      @change += @heat_per_tact # то температура изменяется 
    end
  end  

  # метод выдает процесс работы обогревателя
  def get_runner
    repeat_every @tact do # каждый такт (каждый отрезок времени)
      check_and_change    # изменяется температура
    end
  end  

  # селектор (getter) изменения температуры
  def change
    @change
  end

  # селектор (getter) статуса обогревателя 
  def status
    @status
  end
end

# Климат-контроль - устройство слежения за изменениями температуры
# следит за включением/выключением кондиционера и обогревателя
class ClimateControl < TimeMachine
  def initialize (home, heater_start, cond_start)
    @home = home                    # объект, в котором установлено устройство
    reset(heater_start, cond_start) # установка начальных параметров
  end

  # метод установки начальных параметров
  def reset (heater_start, cond_start)
    @tact = 0.7                  # длительность такта работы устройства
    @heater_start = heater_start # температурный барьер, при котором
                                 # включается/выключается обогреватель
    @cond_start = cond_start     # температурный барьер, при котором
                                 # выключается/включается кондиционер
  end

  # запуск/отключение обогревателя
  def check_heater
    if @home.temperature > @heater_start # если превышен темп. барьер
      @home.heater.set_off               # перевести в режим ожидания
    else
      @home.heater.set_on                # перевести в режим работы
    end
  end

  # запуск/отключение кондиционера
  def check_conditioner
    if @home.temperature > @cond_start # если превышен темп. барьер
      @home.conditioner.set_on         # перевести в режим работы
    else
      @home.conditioner.set_off        # перевести в режим ожидания
    end
  end

  # метод выдает процесс работы обогревателя
  def get_runner
    repeat_every @tact do # каждый такт (каждый отрезок времени)
      check_heater        # проверка обогревателя
      check_conditioner   # проверка кондиционера
    end
  end
end

# Метеостанция (наблюдает и выводит текущие параметры среды)
class Reporter < TimeMachine
  def initialize home
    @home = home # объект, в котором установлено устройство
    reset        # установка начальных параметров
  end

  # метод установки начальных параметров
  def reset
    @tact = 0.5 # длительность такта работы устройства
  end

  # формирование строки с текущим временем
  def time_s
    "time: #{Time.now.to_i}" 
  end

  # формирование строки с текущей температурой
  def temp_s
    "t: " + @home.temperature.to_s
  end

  # формирование строки с текущим статусом кондиционера
  def cond_status_s
    "conditioner: " + bool_to_on_off_s(@home.conditioner.status)
  end

  # формирование строки с текущим статусом обогревателя
  def heater_status_s
    "heater: " + bool_to_on_off_s(@home.heater.status)
  end

  # формирование статуса устройства (из булевского типа в "on"/"off")
  def bool_to_on_off_s val
    if val then
      "on "
    else
      "off"
    end
  end

  # формирование строки общего статуса для вывода
  def message
    "Status: #{time_s} #{temp_s} #{heater_status_s} #{cond_status_s}"
  end

  # вывод статуса на экран, а в случае нажатия клавиши - останов системы
  def check_and_display
    k = GetKey.getkey # получить код символа (нажатой клавиши), если нажата клавиша
    puts message      # вывод строки статуса
    if k then         # если была нажата клавиша
      stop_machine    # остановить систему
      puts "STOP"     # вывести на экран сообщение об останове
    end      
  end

  # метод выдает процесс работы метеостанции
  def get_runner
    repeat_every @tact do # каждый такт (каждый отрезок времени)
      check_and_display   # проверка на останов и выдача сообщения на экран
    end
  end 
end

# Симулятор погоды
class Weather < TimeMachine
  def initialize
    @tact = 0.1       # период возможных изменений
    @temperature = 15 # температура в начальный момент времени
    @cyclons = []     # список активных циклонов
  end

  # метод увеличения температуры на t
  def change t
    @temperature += t
  end

  # селектор (getter) температуры
  def temperature
    @temperature
  end

  # селектор списка циклонов
  def cyclons
    @cyclons
  end

  # создать новый циклон
  def new_cyclon
    Cyclon.new_cyclon self # запустить метод класса Cyclon для создания циклона,
                           # self передается как параметр 
  end

  # пересмотр списка циклонов
  def cyclons_review
    if @cyclons.size < 2   # если количество активных циклонов меньше 2-х
      @cyclons.push(new_cyclon.get_runner) if rand(10) > 6
                           # то с вероятностью 3/10 возникает 
                           # (добавляется) новый циклон (его процесс)
    end
  end

  # метод выдает процесс функционирования симулятора погоды
  def get_runner
    repeat_every @tact do                # каждый период (такт)
      3.times { cyclons_review }         # 3 раза пересмотреть список циклонов
      @cyclons.each { |proc| proc.join } # запустить все процессы (все циклоны)
         # продолжение работы симулятора после завершения работы всех циклонов
    end
  end
end

# Циклон
class Cyclon < TimeMachine
  def initialize(change_array, weather)
    @weather = weather   # симулятор погоды, в котором изменяется температура
    @possible_changes = change_array # список возможных изменений температуры за 1 такт
    @tact = 0.1            # длительность одного такта
  end  

  # возможные списки изменений температуры для разных циклонов
  Cyclons = 
    [[-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2],
     [-1.5, -1, -0.5, 0, 0, 0],
     [0, 0, 0, 0.5, 1, 1.5],
     [-1, -0.5, 0, 0, 0, 0.5, 1],
     [-0.5, 0, 0.5]
    ] 
  # создать новый циклон для симулятора погоды weather 
  def self.new_cyclon weather
    # берется случайный представитель списка Cyclons 
    # и с ним создается новый циклон
    Cyclon.new(Cyclons.sample, weather)
  end

  # генерация изменения температуры
  def get_temp_change
    @possible_changes.sample # берется случайный представитель из возможных
  end

  # возможное окончание действия циклона
  def dry_out
    if rand(20) > 18               # с шансом 1/20
      wh = @weather.cyclons.shift # из списка активных циклонов в симуляторе 
                                   # погоды выкидывается первый
      wh.exit if not wh.nil?       # и завершить его работу
    elsif rand(20) < 1             # иначе, с шансом 1/20
      wh = @weather.cyclons.pop   # из списка активных циклонов в симуляторе 
      wh.exit if not wh.nil?       # и завершить его работу
    end
  end

  # метод выдает процесс функционирования циклона
  def get_runner
    repeat_every @tact do              # 1 раз в период времени
      @weather.change get_temp_change # изменить температуру в симуляторе погоды
      dry_out     # возможно, завершить функционирование одного циклона 
    end
  end  
end

# Теплица
class Glasshouse < TimeMachine
  def initialize
    set_weather    # установка начальных параметров симулятора погоды
    set_glasshouse  # установка начальных параметров теплицы
  end

  # метод установки начальных параметров погоды
  def set_weather
    @weather = Weather.new  # создание нового симулятора погоды
  end

  # метод установки параметров теплицы
  def set_glasshouse
    @conditioner = Conditioner.new self # прикрепить новый кондиционер
    @heater = Heater.new self           # прикрепить новый обогреватель
    @climate_control = ClimateControl.new(self, 15, 25)
                                        # прикрепить систему климат-контроля
    @reporter = Reporter.new self       # прикрепить метеостацию
  end

  # получение списков процессов всех устройств
  def list_of_processes
    all_system = [@weather, @conditioner, @heater, @climate_control, @reporter]
    all_system.map { |syst| syst.get_runner }
  end

  # запуск всех процессов теплицы
  def start
    processes = list_of_processes
    processes.each { |proc| proc.join }
  end

  # селектор (getter) кондиционера теплицы
  def conditioner
    @conditioner
  end

  # селектор (getter) обогревателя теплицы
  def heater
    @heater
  end

  # селектор (getter) устройства климат-контроля теплицы
  def climate_control
    @climate_control
  end

  # селектор (getter) симулятора погоды теплицы
  def weather
    @weather
  end

  # селектор (getter) температуры теплицы
  def temperature
    # складывается как изменение температуры, вследствие погоды
    # минус изменение, сгенерированное кондиционером
    # плюс изменение, сгенерированное обогревателем
    @weather.temperature - @conditioner.change + @heater.change
  end
end

# первоначальная установка датчика случайных чисел
srand


