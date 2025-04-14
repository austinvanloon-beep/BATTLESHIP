class Game

  attr_reader :player, :computer

  def initialize
   @player = Player.new
   @computer = Player.new("computer")
   @computer.computer_player
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
      play_turns
      end_game
    elsif user_input == 'q'
      puts "Goodbye!"
      quit_game
    else
      puts "Invalid input. Please try again."
      start_game
    end

  end

  def quit_game
    # refactor note do i need abort instead? not sure about what at_exit handlers are and if that's just a ruby on rails thing
    exit
  end

  def setup_game
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    ships = [cruiser, submarine]
  
    @player.place_ships(ships)
    @computer.place_ships(ships)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def play_turns
    until @player.all_ships_sunk? == true || @computer.all_ships_sunk? == true
      display_boards
      @player.take_turn(@computer.board)
      break if @computer.all_ships_sunk? == true
      @computer.take_turn(@player.board)
    end
  end

  def end_game
    if @player.all_ships_sunk? == true
      puts "You won!"
    elsif @computer.all_ships_sunk? == true
      puts "I won!"
    end
  end

  
end