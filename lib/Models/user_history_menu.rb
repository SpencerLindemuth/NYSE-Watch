def user_history_menu(symbol, cache = {})
    while true
        system('clear')
        puts "-----------------------------------------"
        puts "1) 1 Week          2) 1 Month"
        puts "3) 3 Months        4) 6 Months"
        puts "5) 1 Year          6) 5 Years"
        puts 'or type "back" to go back'
        puts
        input = gets.chomp
        if input == "back"
            user_stock_profile_menu(symbol, cache)
        else
            input = input.to_i
        end
        duration = 0

        case input
        when 1
            duration = 7
            print_history(symbol, duration)
        when 2
            duration = 30
            print_history(symbol, duration)
        when 3
            duration = 90
            print_history(symbol, duration)
        when 4
            duration = 180
            print_history(symbol, duration)
        when 5
            duration = 365
            print_history(symbol, duration)
        when 6
            duration = 2000
            print_history(symbol, duration)
        else
            puts "Please enter a valid command"
        end
    end
end


def print_history(symbol, duration)
    while true
        history = stock_history(symbol, duration)
        system('clear')
        if history["change_direction"] == "up"
            puts "#{symbol.upcase} history:".red
            puts "      Closing price on #{history["first_date"]}:".blue + " #{history["first_close"]}"
            puts "          Highest Price: " + "#{history["historical_high"]}".green + "    (#{history["historical_high_date"]})".blue
            puts "          Lowest Price:  " + "#{history["historical_low"]}".red + "   (#{history["historical_low_date"]})".blue
            puts "          Total Growth:  " + "#{history["total_change"]}".green
            puts "          Change Percent:" + "#{history["change_percent"]}".blue
            puts "      Close price on #{history["current_date"]}: #{history["current_close"]}"
        elsif history["change_direction"] == "down"
            puts "#{symbol} history:".red
            puts "      Closing price on #{history["first_date"]}: #{history["first_close"]}"
            puts "          Highest Price: " + "#{history["historical_high"]}".green + "    (#{history["historical_high_date"]})".blue
            puts "          Lowest Price:  " + "#{history["historical_low"]}".red + "   (#{history["historical_low_date"]})".blue
            puts "          Total Growth:  " + "#{history["total_change"]}".red
            puts "          Change Percent:" + "#{history["change_percent"]}".blue
            puts "      Close price on #{history["current_date"]}:".blue + " $#{history["current_close"]}"
        end
        puts
        puts "-----------------------------------------"
        puts "1) Change history duration  2) New search"
        puts "3) Add to portfolio         4) Main Menu"
        puts
        input= gets.chomp.to_i
        case input
        when 1
            user_history_menu(symbol)
        when 2
            user_stock_research_menu
        when 3

        when 4
            show_menu
        else
            puts "Please enter a valid command"
        end
    end
end


