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
      while pin_input = gets.chomp
        $CurrentUser = User.all.find_by(name: user_name, pin: pin_input)
        if pin_input == 0
          get_input
          break
        elsif !$CurrentUser || pin_input != Integer(pin_input)
          puts 'Please enter valid pin or enter "back" to create an account.'
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
  def trending_stocks(rerun = 0, p_cache = {}, n_cache = {})
    system('clear')
    if rerun == 1
      negative_movers = n_cache
      positive_movers = p_cache
      puts "Please enter a valid command".red.bold
    elsif rerun == 2
      puts "Please enter a valid symbol".red.bold
      negative_movers = n_cache
      positive_movers = p_cache
    elsif rerun == 3
      puts "Removed!".blue.bold
      negative_movers = n_cache
      positive_movers = p_cache
    elsif rerun == 4
      puts "Added!".green.bold
      negative_movers = n_cache
      positive_movers = p_cache
    else
    negative_movers = biggest_negative_movers
    positive_movers = biggest_positive_movers
    end
    puts
    puts "Here are today's biggest postive movers:".black
    puts
    rows = []
    positive_movers.each do |mover|
      if $CurrentUser.stocks.find_by symbol: mover['ticker']
        rows << ["** #{mover['companyName'].truncate(25)}".blue, "#{mover['ticker']}".magenta , "#{mover['price']}".green, "#{mover['changesPercentage']}".green]
      else
        rows << ["#{mover['companyName'].truncate(25)}".blue, "#{mover['ticker']}".magenta , "#{mover['price']}".green, "#{mover['changesPercentage']}".green]
      end
    end
    table = Terminal::Table.new :headings => ["Stock Name", "Symbol", "Current Price", "Percent Change"], :rows => rows, :style => {:width => 80}
    puts table
    puts
    puts
    puts "Here are today's biggest negative movers:".black
    puts
    rows = []
    negative_movers.each do |mover|
      if $CurrentUser.stocks.find_by symbol: mover['ticker']
        rows << ["** #{mover['companyName'].truncate(25)}".blue, "#{mover['ticker']}".magenta , "#{mover['price']}".red, "#{mover['changesPercentage']}".red]
      else
        rows << ["#{mover['companyName'].truncate(25)}".blue, "#{mover['ticker']}".magenta , "#{mover['price']}".red, "#{mover['changesPercentage']}".red]
      end
    end
    table = Terminal::Table.new :headings => ["Stock Name", "Symbol", "Current Price", "Percent Change"], :rows => rows, :style => {:width => 80}
    puts table
    puts ""
    puts "What you you like to do next?"
    puts "1) Add a stock to portfolio   2)Remove a stock from portfolio"
    puts "3) View Portfolio             4)Main menu"

    selection = gets.chomp.to_i
    case selection
    when 1
      add_stock_from_trending(positive_movers, negative_movers)
    when 2
      delete_stock_from_trending(positive_movers, negative_movers)
    when 3
      edit_portfolio
    when 4
      show_menu
    else
      trending_stocks(1, positive_movers, negative_movers)
    end
  end

  def delete_stock_from_trending(p_cache, n_cache)
    puts "Please enter symbol of stock to remove:"
    input = gets.chomp.upcase
    if valid_symbol?(input)
        remove_from_portfolio(input)
        trending_stocks(3, p_cache, n_cache)
    else
        trending_stocks(2, p_cache, n_cache)
    end
end

def add_stock_from_trending(p_cache, n_cache)
  puts "Please enter symbol of stock to add:"
  input = gets.chomp.upcase
  if valid_symbol?(input)
      add_to_portfolio(input)
      trending_stocks(4, p_cache, n_cache)
  else
      trending_stocks(2, p_cache, n_cache)
  end
end
