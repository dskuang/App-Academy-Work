require 'byebug'
class Ghost_Ai < Player
  attr_accessor :num_players, :dictionary, :word_endings, :possible_letters, :fragment
  attr_reader :name
  def initialize(num)
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @num_players = num
    @name = "AI"
    @fragment = ""
  end


  def next_possible_letter
    #  word_part = @fragment
    #  length = @fragment.length
    endings = []
    possibles = []
    impossible = []
    @dictionary.each do |word|
      next unless word.length > @fragment.length && word.start_with?(@fragment)
      ending = word[@fragment.length..-1]
      #  puts ending
      endings << ending
    end
    endings.each do |ending|
       if ending.length % num_players == 1 && ending.length != 1 && !impossible.include?(ending[0])
         possibles << ending[0]
       else
         impossible << ending[0]
      end
    end

      puts "word endings are #{endings.inspect}"
      puts "possible letters are ##{possibles.inspect}"

    if possibles.empty?
      #puts "I HAVE NO POSSIBLE LETTERS"
      possibles << endings[0][0]
    end
    possibles.first
  end

  def receive_fragment word
    #debugger
    self.fragment = word
  end

  def guess
    #debugger
    #puts "I AM GETTING A LETTER FOR THIS FRAGMENT: #{self.fragment}"
    letter = next_possible_letter
    puts "I CHOSE #{letter}"
    letter
  end

  def alert_invalid_guess
    debugger
    p "Please choose a valid letter "
  end



end
