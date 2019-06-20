require 'pry'

  def welcome
    system('clear')
    puts "Welcome to NYSE Watch!"
  end

  def get_input(rerun = 0)
    welcome
    if rerun == 1
      puts "Please enter a valid command!".red
    end
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
      system('clear')
      puts "Please enter your username:"
      user_name = gets.chomp
      puts "Please enter your pin:"
      while pin_input = gets.chomp.to_i
        $CurrentUser = User.all.find_by(name: user_name, pin: pin_input)
        if !$CurrentUser || pin_input != Integer(pin_input)
          puts "Please enter valid pin or create an account."
          puts
        else
        puts "Welcome back, #{$CurrentUser.name}!"
        show_menu
        end
      end

    else selection == 2
      system('clear')
      invalid = true
      while invalid = true
        puts "Please enter a username:"
        username = gets.chomp
        if User.all.find_by name: username
          puts "The username that you entered is already taken."
        else
          invalid = false
          break
        end
      end
      system('clear')
      while true
        puts "Please enter a 4 digit pin:"
        new_pin = gets.chomp
        if new_pin != Integer(new_pin) && new_pin.length != 4
          puts "Please enter a vaild pin"
        else
          $CurrentUser = User.create(name: username, pin: new_pin)
          puts "Welcome #{$CurrentUser.name}!"
          show_menu
          break
        end
      end
    end
  end

################################# Stock Options Menu #########################################

def show_menu
  system('clear')
  if $CurrentUser.stocks.count > 0
    puts
    x = $CurrentUser.stocks
    rows = []
    x.each do |stock|
        if stock.day_change >= 0
            rows << ["#{stock.name}".blue, "(#{stock.symbol})".magenta, "$#{stock.price}".green," #{stock.day_change}".green ]
        else
            rows << ["#{stock.name} ".blue,"(#{stock.symbol})".magenta,"$#{stock.price}".red,"#{stock.day_change}".red]
        end
    end
    table = Terminal::Table.new :headings => ["Stock Name", "Symbol", "Current Price", "Day Change"], :rows => rows
    puts table
    end
  puts
  puts "Welcome, #{$CurrentUser.name}!"
  puts
  puts "Select an option from the list below:"
  puts "1) Edit my portfolio          2) Search stocks"
  puts "3) See trending stocks        4) Exit"


  selection = gets.chomp.to_i

  while selection != 1 && selection != 2 && selection != 3 && selection != 4
    puts "Please select a valid option."
    puts
    selection = gets.chomp.to_i
  end

  if selection == 1
    edit_portfolio
  elsif selection == 2
    user_stock_research_menu
  elsif selection == 3
    trending_stocks
  elsif selection == 4
    exit
    #exit back to main menu
  end
end

###################### Trending Stocks ##############################################
  def trending_stocks
    system('clear')
    puts "Here are today's biggest postive movers:".black
    puts
    biggest_positive_movers.each do |mover|
    puts "#{mover['companyName']}".blue + " Percent Increase:".black + " #{mover['changesPercentage']}".green
    puts
    end
    puts "--------------------------------------------------------------------------"
    puts "Here are today's biggest negative movers:".black
    puts
    biggest_negative_movers.each do |mover|
      mover["companyName"]
      puts "#{mover['companyName']}".blue + " #{mover['changesPercentage']}".red
      puts
    end
    puts "What you you like to do next?"
    puts
    puts "1) Edit my portfolio          2) Search stocks"
    puts "3) Exit"

    selection = gets.chomp.to_i
    if selection == 1
      edit_portfolio
    elsif selection == 2
      user_stock_research_menu
    elsif selection == 3
      show_menu
    end
  end
