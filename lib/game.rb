class Game

  attr_reader :player, :computer

  def initialize
    @player = Player.new("player")
    @computer = Player.new("computer")
    @computer.computer_player
    @pirate_mode = false
  end

  def welcome_message
    if pirate_mode?
      "Welcome aboard ye scallywag!\n" +
      "Type 'p' to set sail or 'q' to walk the plank!"
    else
      "Welcome to BATTLESHIP\n" +
      "Enter 'p' to play. Enter 'q' to quit."
    end
  end

  def start_game
    puts welcome_message
    user_input = gets.chomp.downcase

    if user_input == 'p'
      setup_game
      play_turns
      end_game
    elsif user_input == 'q'
      pirate_goodbyes = [
        "Fair winds to ye, coward of the coast!",
        "Turnin tail already? The sea ain't for the faint o' heart.",
        "Aye, best stay ashore then. The kraken thanks ye for leavin him be.",
        "Off with ye then. There be some grog waitin elsewhere, I reckon!"
      ]

      if pirate_mode?
        puts pirate_goodbyes.sample
      else
        puts "Goodbye!"
      end
      quit_game
    else
      if pirate_mode?
        puts "That be nonsense, matey! Try again with 'p' or 'q', savvy?"
      else
        puts "Invalid input. Please try again."
      end
      
      start_game
    end
  end

  def quit_game
    exit
  end

  def setup_game
    ship_options = {
      "1" => { name: "Cruiser", length: 3 },
      "2" => { name: "Submarine", length: 2 },
      "9" => { name: "Black Pearl", length: 4, hidden: true }
    }

    if pirate_mode?
      puts "Choose yer vessels, ye salty dog:\n\n"
    else
      puts "Choose the ships you'll play with:\n\n"
    end

    ship_options.each do |key, ship_info|
      next if ship_info[:hidden] && !pirate_mode?

      if pirate_mode?
        ship_name = pirate_ship_name(ship_info[:name])
      else
        ship_name = ship_info[:name]
      end

      puts "#{key}. #{ship_name} (#{ship_info[:length]} spaces)"
    end    

    if pirate_mode?
      puts "\nHow many ships be joinin' yer fleet?"
    else
      puts "\nHow many ships would you like to use?"
    end

    visible_ship_count = 0

    ship_options.each do |key, ship_info|
      visible_ship_count += 1 unless ship_info[:hidden]
    end
    ship_count = nil

    loop do
      print "Enter a number (1 to #{visible_ship_count}): "
      user_input = gets.chomp.to_i
      if user_input.between?(1, visible_ship_count)
        ship_count = user_input
        break
      else
        if pirate_mode?
          puts "That number ain't seaworthy! Pick between 1 and #{visible_ship_count}, matey!"
        else
          puts "Invalid number. Please choose a number between 1 and #{visible_ship_count}."
        end
      end
    end

    chosen_ships = []

    ship_count.times do |i|
      print "Enter the number for Ship #{i + 1}: "
      user_input = gets.chomp.strip
      ship_info = ship_options[user_input]

      if user_input.downcase == "9"
        @pirate_mode = true
        puts "Avast! Ye've summoned the Black Pearl. Prepare for a cursed voyage! Ahahahaaaa"
        
        next
      end

      if ship_info
        chosen_ships << Ship.new(ship_info[:name], ship_info[:length])
      else
        if pirate_mode?
          puts "Arrr, that ain't a proper command. Try again!"
        else
          puts "Invalid input. Please try again."
        end
        
        redo
      end

      if pirate_mode?
        puts "\nA fine fleet ye've chosen! The seas be awaitin':"
      else
        puts "\nGreat! For this game, you and the computer will both use:"
      end
      
      chosen_ships.each do |ship|
        puts "- #{ship.name} (#{ship.length})"
      end
    end

    if pirate_mode?
      black_pearl = Ship.new("Black Pearl", 4)
      @computer.place_ship([black_pearl])
    end

    @computer.place_ship(chosen_ships)
    
    if pirate_mode?
      puts "\nI've hidden me fleet across the briny deep. Yer move, landlubber!"
    else
      puts "\nI have placed my ships randomly on the board. Now it's your turn."
    end

    @player.place_ship(chosen_ships)
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer.board.render
    puts "==============PLAYER BOARD=============="
    puts @player.board.render(true)
  end

  def play_turns
    pirate_turns = [
      "Let the battle begin!",
      "Raise the anchor, we sail into fire!",
      "Prepare to board and bring the broadside!",
      "A storm brews — time to unleash the cannons!"
    ]

    if pirate_mode?
      puts pirate_turns.sample
    else
      puts "Let the battle begin!"
    end

    until @player.all_ships_sunk? == true || @computer.all_ships_sunk? == true
      display_boards
      
      if pirate_mode?
        puts "\nYer turn, swabbie:"
      else
        puts "\nYour turn:"
      end

      @player.take_turn(@computer.board)

    break if @computer.all_ships_sunk? == true

      if pirate_mode?
        puts "\nMe turn, prepare to be plundered!"
      else
        puts "\nComputer's turn:"
      end
      
      @computer.take_turn(@player.board)
    end
  end

  def end_game
    if pirate_mode?
      if @computer.all_ships_sunk?
        puts "\nCURSES!! Ye bested me and me crew. Surely yer name echoes through the ports now!"
      elsif @player.all_ships_sunk?
        puts "\nYe fought well, but I sent yer fleet to the briny deep! I win, ye scurvy dog!"
      end
    else
      if @computer.all_ships_sunk?
        puts "\nYou won!\n"
      elsif  @player.all_ships_sunk?
        puts "\nI won!\n"
      end
    end

    pirate_play_agains = [
      "\nHoist the sails — we be headin back to port...\n\n",
      "\nThe sea grows quiet... back to the map table, we go.\n\n",
      "\nA short rest 'fore we chart a new course. Back to the main menu!\n\n",
      "\nThe cannon smoke clears... returnin to safe harbors.\n\n"
    ]

    if pirate_mode?
      puts pirate_play_agains.sample
    else
      puts "\nReturning to main menu...\n\n"
    end
        
    play_again?
  end

  def play_again?
    if pirate_mode?
      puts "Wanna tempt fate again, ye sea dog? ('y' for aye, 'n' for nay)"
    else
      puts "Would you like to play again? ('y' or 'n')"
    end
      
    user_input = gets.chomp.strip.downcase
  
    if user_input == 'y'
      game = Game.new
      game.start_game
    else
      pirate_rematch = [
        "Ye fought bravely... or at least avoided sinkin yerself. Fare thee well!",
        "Weigh anchor and vanish then, ye lily-livered swab!",
        "I shall be waitin in the fog for our next skirmish. Until then, bilge rat.",
        "So ye surrender? Smart choice. I be the terror of the tides!"
      ]
      
      if pirate_mode?
        puts pirate_rematch.sample
      else
        puts "Thanks for playing! Goodbye!"
      end
      quit_game
    end
  end

  def pirate_mode?
    @pirate_mode == true
  end

  def pirate_ship_name(name)
    if name == "Cruiser"
       "Sea Serpent"
    elsif name == "Submarine"
       "Depth Crawler"
    elsif name == "Black Pearl"
       "The Black Pearl"
    else name
    end
  end
  

end