module GetKey
 
  # Check if Win32API is accessible or not
  USE_STTY = begin
      require 'Win32API'
      KBHIT = Win32API.new('crtdll', '_kbhit', [ ], 'I')
      GETCH = Win32API.new('crtdll', '_getch', [ ], 'L')
      false
    rescue LoadError
      # Use Unix way
      true
    end
 
  # Return the ASCII code last key pressed, or nil if none
  #
  # Return::
  # * _Integer_: ASCII code of the last key pressed, or nil if none
  def self.getkey
    if USE_STTY
      char = nil
      begin
        system('stty raw -echo') # => Raw mode, no echo
        char = (STDIN.read_nonblock(1).ord rescue nil)
      ensure
        system('stty -raw echo') # => Reset terminal mode
      end
      return char
    else
      return KBHIT.Call.zero? ? nil : GETCH.Call
    end
  end
 
end

# устройство, функционирующее потактно
class TimeMachine
  @@stop = false

  # процесс, повторяющий выполнение блока через каждый интервал времени
  def repeat_every interval
    Thread.start do
      loop do
        break if @@stop
        start_time = Time.now
        yield
        elapsed = Time.now - start_time
        sleep([interval - elapsed, 0].max)
      end
    end
  end

  # останов всех процессов, созданных с помощью repeat_every 
  def stop_machine
    @@stop = true
  end
end

