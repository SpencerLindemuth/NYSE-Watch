class UserLogin

  def run
    system('clear')
    get_input
    binding.pry
    show_menu
  end




################ Welcome Screen ##################################################

  def welcome
    puts "Welcome to NYSE Watch!"
  end

  def get_input
    welcome
    prompt = "Type 1) to enter your pin or type or 2) to create a new account."
    puts
    puts prompt
    selection = STDIN.gets.chomp.to_i

    while selection != 1 && selection != 2
      puts "Please select an option from the main menu:"
      puts prompt
      selection = STDIN.gets.chomp.to_i
    end
    if selection == 1
      puts "Please enter your pin:"
      while pin_input = STDIN.gets.chomp.to_i
        returning = User.all.find_by(pin: pin_input)
        @returning = returning
        if !returning || pin_input != Integer(pin_input)
          binding.pry
          puts "Please enter valid pin or create an account."
          puts
          puts prompt
      else
        puts "Welcome back, #{returning.name}!"
        show_menu
        #put next menu here
        end
      end

    else selection == 2
      puts "What's your name?"
      user_name = STDIN.gets.chomp
      puts "Please enter a 4 digit pin:"
      while new_pin = STDIN.gets.chomp.to_i
        if new_pin.is_a? Integer
          @user = User.create(name: user_name, pin: new_pin)
          puts "Welcome #{@user.name}!"
          show_menu
          #menu here
        else
          puts "Please enter a valid pin:"
          new_pin = STDIN.gets.chomp
        end
      end
    end
  end

################################# Stock Options Menu #########################################

def show_menu
  prompt = "Select an option from the list below:
          1) Look at my portfolio.
          2) Search stocks.
          3) See trending stocks.
          4) Exit."
  puts prompt

  selection = STDIN.gets.chomp.to_i

  while selection != 1 && selection != 2 && selection != 3 && selection != 4
    puts "Please select a valid option."
    puts
    selection = STDIN.gets.chomp.to_i
  end

  if selection == 1
    puts "Here are your stocks:"
    puts
    x = @returning.stocks
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
    ###
    binding.pry
    #link to user portfolio
  elsif selection == 2


    #research stocks by name
  elsif selection == 3
    #see trending stocks
  elsif selection == 4
    #exit back to main menu
  end
end



end
