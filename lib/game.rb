class Game

  # using placeholders until Austin confirms how he's initializing players
  # and differentiating between human and computer
  attr_reader :player, :opponent

  def initialize
   @player = Player.new
   @opponent = Player.new(is_computer? == true)
  end

  def welcome_message
    "Welcome to BATTLESHIP\n" +
    "Enter 'p' to play. Enter 'q' to quit."
  end
  
  def start_game
    puts welcome_message
    user_input = gets.chomp.downcase

    if user_input == 'p'
      setup_game
    elsif user_input == 'q'
      quit_game
    else
      puts "Invalid input. Please try again."
      start_game
    end

  end

  def quit_game
  
  end

  def setup_game
    def setup_game
      ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
      @player.place_ships(ships)
      @opponent.place_ships(ships)
    end
  end

  def end_game
    if @player.each {|ships| ships.sunk?}
      @player.ships.all?
      puts "You won!"
    elsif @opponent.each {|ships| ships.sunk?}
      @opponent.ships.all?
      puts "I won!"
    end
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @opponent.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end


end