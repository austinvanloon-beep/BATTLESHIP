class Game

  attr_reader :player, :computer

  def initialize
    @player = Player.new("player")
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
    # add sassy personality flair here for computer maybe?
    ship_options = {
      "1" => { name: "Cruiser", length: 3 },
      "2" => { name: "Submarine", length: 2 }
    }

    puts "Choose the ships you'll play with:\n\n"

    ship_options.each do |key, ship_info|
      puts "#{key}. #{ship_info[:name]} (#{ship_info[:length]} spaces)"
    end

    puts "\nHow many ships would you like to use?"

    max_ships = ship_options.length
    ship_count = nil

    loop do
      print "Enter a number (1 to #{max_ships}): "
      user_input = gets.chomp.to_i
      if user_input.between?(1, max_ships)
        ship_count = user_input
        break
      else
        puts "Invalid number. Please choose a number between 1 and #{max_ships}."
      end
    end

    chosen_ships = []

    ship_count.times do |i|
      print "Enter the number for Ship #{i + 1}: "
      user_input = gets.chomp
      ship_info = ship_options[user_input]

      if ship_info
        chosen_ships << Ship.new(ship_info[:name], ship_info[:length])
      else
        puts "Invalid input. Please try again."
        redo
      end

      puts "\nGreat! For this game, you and the computer will both use:"
      chosen_ships.each do |ship|
        puts "- #{ship.name} (#{ship.length})"
      end
    end

    # add personality flair here
    @computer.place_ship(chosen_ships)
    puts "\nI have placed my ships randomly on the board. Now it's your turn."

    @player.place_ship(chosen_ships)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def play_turns
    puts "Let the battle begin!"

    until @player.all_ships_sunk? == true || @computer.all_ships_sunk? == true
      display_boards
      
      puts "\nYour turn:"
      @player.take_turn(@computer.board)

      break if @computer.all_ships_sunk? == true

      puts "\nComputer's turn:"
      @computer.take_turn(@player.board)
    end
  end

  def end_game
    if @player.all_ships_sunk? == true
      puts "\nYou won!\n"
    elsif @computer.all_ships_sunk? == true
      puts "\nI won!\n"
    end

    puts "\nReturning to main menu...\n\n"
    play_again?
  end

  def play_again?
    puts "Would you like to play again? ('y' or 'n')"
    user_input = gets.chomp.strip.downcase
  
    if user_input == 'y'
      game = Game.new
      game.start_game
    else
      puts "Thanks for playing! Goodbye!"
      quit_game
    end
  end
  
end