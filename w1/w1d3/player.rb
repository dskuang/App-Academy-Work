class Player
  attr_accessor :name, :fragment
  def initialize(name)
    @name = name
    @fragment = ''
  end

  def guess
    print "Enter your letter: "
    gets.chomp
  end

  def alert_invalid_guess
    p "Please choose a valid letter "
  end

  def receive_fragment word
    puts "Fragment is #{word}"
    self.fragment = word
  end


end
