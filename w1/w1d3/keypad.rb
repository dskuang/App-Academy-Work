class Keypad
  attr_accessor :code_bank, :key_history, :codes
  attr_reader :mode_keys, :code_length

  def initialize(code_length, mode_keys)
    @mode_keys = mode_keys
    @code_length = code_length
    @key_history = []
    @code_bank = Hash.new(0)
  end

  def press (value)
    @key_history << value
    check_code
  end

  def check_code
    if @mode_keys.include?(key_history[-1]) && @key_history.length > @code_length
      code = @key_history[(-1-@code_length)..-2].join
      @code_bank[code] += 1
    end
  end

  def all_codes
    if !@codes
      @codes = []
      (10**@code_length ).times do |num|
         @codes << num.to_s.rjust(@code_length, "0")
       end
    end
    @codes
  end

  def all_codes_entered?
    all_codes.all? do |code|
      @code_bank[code] > 0
    end
  end


  def run
    until code_bank.include? 1337
      press
    end
    puts "you win"
  end

end
