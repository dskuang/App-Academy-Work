require_relative 'keypad'
require 'byebug'

class KeypadTester
  attr_accessor :num, :array, :counter
  attr_reader :length
  def initialize(length, mode_keys)
    @length = length
    @keypad = Keypad.new(length, mode_keys)
    @num = -1
    reset_array
    @counter = 0
  end

  def run
    #debugger
    until @keypad.all_codes_entered?
      if array.empty?
        @counter += 1
        @keypad.press(1)
        reset_array
        reset_array if @keypad.code_bank.keys.includes? @array.join('')
      else
        @counter += 1
        @keypad.press(@array.shift)
      end
      puts @keypad.code_bank.length
    end

  end

  def reset_array
    @num += 1
    @array = @num.to_s.rjust(4, "0").split("")
    # zeroes = length - @num.to_s.length
    # (["0"] * zeroes).each { |x| @array << x}
    # num.to_s.chars.each {|y| @array << y}

  end
end

k = KeypadTester.new(4,[1,2,3])
k.run
puts k.counter
