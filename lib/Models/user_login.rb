################ Welcome Screen ##################################################

  def welcome
    system('clear')
    puts "Welcome to NYSE Watch!"
  end

  def get_input
    welcome
    prompt = "Type 1) to enter your pin or type or 2) to create a new account."
    puts
    puts prompt
    selection = gets.chomp.to_i

    while selection != 1 && selection != 2
      puts "Please select an option from the main menu:"
      puts prompt
      selection = gets.chomp.to_i
    end
    if selection == 1
      puts "Please enter your pin:"
      while pin_input = gets.chomp.to_i
        returning = User.all.find_by(pin: pin_input)
        if !returning || pin_input != Integer(pin_input)
          puts "Please enter valid pin or create an account."
          puts
          puts prompt
      else
        puts "Welcome back, #{returning.name}!"
        show_menu
        end
      end

    else selection == 2
      puts "What's your name?"
      user_name = gets.chomp
      puts "Please enter a 4 digit pin:"
      while new_pin = gets.chomp.to_i
        if new_pin.is_a? Integer
          $CurrentUser = User.create(name: user_name, pin: new_pin)
          puts "Welcome #{$CurrentUser.name}!"
          show_menu
        else
          puts "Please enter a valid pin:"
          new_pin = gets.chomp
        end
      end
    end
  end

################################# Stock Options Menu #########################################

def show_menu
  system('clear')
  prompt = "Select an option from the list below:
          1) Look at my portfolio.
          2) Search stocks.
          3) See trending stocks.
          4) Exit."
  puts prompt

  selection = gets.chomp.to_i

  while selection != 1 && selection != 2 && selection != 3 && selection != 4
    puts "Please select a valid option."
    puts
    selection = gets.chomp.to_i
  end

  if selection == 1
    begin
    puts "Here are your stocks:"
    puts
    x = $CurrentUser.stocks
    y = x.collect do |stock|
      stock.name
    end
    puts y
    puts
    puts "What would you like to do next?"
    puts
    puts "1) Remove stock.
          2) Search stocks.
          3) See trending stocks.
          4) Exit."
    rescue
      puts "You currently have no stocks, please add through Research tab."
    end
  elsif selection == 2
    user_stock_research_menu
  elsif selection == 3
    trending_stocks
  elsif selection == 4
    #exit back to main menu

  end
end

###################### Trending Stocks ##############################################
  def trending_stocks
    puts "Here are today's biggest postive movers:"
    puts
    biggest_positive_movers.each do |mover|
    puts "#{mover['companyName']}".blue + " Percent Increase:".black + " #{mover['changesPercentage']}".green
    puts
    end
    puts "------------------------------------------"
    puts "Here are today's biggest negative movers:"
    puts
    biggest_negative_movers.each do |mover|
      mover["companyName"]
      puts "#{mover['companyName']}".blue + " #{mover['changesPercentage']}".red
      puts
    end
  end
