def user_stock_profile_menu(symbol, cache = {}, add_status = 0)
    if cache.count == 0
        profile = stock_full_profile(symbol)
    else 
        profile = cache
    end
    begin
    status = $CurrentUser.stocks.find_by symbol: symbol
    if status
        add_status = 2
    end
    rescue
    end
    system('clear')
    puts "#{stock_attributes(symbol).name}".blue
    puts
    puts "Rating".red
    if profile["recommendation"].empty?
        puts "  No rating available for #{symbol}".magenta
    else
        puts "  Score:".red + "              #{profile['score']}".blue
        puts "  Recommendation:".red + "     #{profile['recommendation']}".blue
        puts "  Grade:".red + "              #{profile['rating']}".blue
    end
    puts
    puts "Prices".red
    if profile["change_percent"] > 0
        puts "  Current Price:".red + "      #{profile['price']}".green
        puts "  Day Change:".red + "         #{profile['change'].round(4)}".green
        puts "  Percent Change:".red + "     #{((profile['change_percent']).round(4))}%".green
        puts "  Day Open:".red + "           #{profile['open_price']}".blue
        puts "  Day Close:".red + "          #{profile['close_price']}".blue
        puts "  Day High:".red + "           #{profile['high_price']}".blue
        puts "  Day Open:".red + "           #{profile['low_price']}".blue
    else
        puts "  Current Price:".red + "      #{profile['price']}".red
        puts "  Day Change:".red + "         #{profile['change'].round(4)}".red
        puts "  Percent Change:".red + "     #{((profile['change_percent']).round(4))}%".red
        puts "  Day Open:".red + "           #{profile['open_price']}".blue
        puts "  Day Close:".red + "          #{profile['close_price']}".blue
        puts "  Day High:".red + "           #{profile['high_price']}".blue
        puts "  Day Open:".red + "           #{profile['low_price']}".blue
    end
    # puts "  Recommendation:".red + "     #{profile['recommendation']}".blue
    # puts "  Grade:".red + "     #{profile['rating']}".blue
    puts
    if add_status == 1
        puts "Added!"
        puts "-----------------------------------------"
        puts "1) See History        2) Remove from portfolio"
        puts "3) New Search         4) Main Menu"
        puts
    elsif add_status == 2
        puts 
        puts "-----------------------------------------"
        puts "1) See History        2) Remove from portfolio"
        puts "3) New Search         4) Main Menu"
        puts
    else
        puts 
        puts "-----------------------------------------"
        puts "1) See History        2) Add to portfolio"
        puts "3) New Search         4) Main Menu"
        puts
    end
        input = gets.chomp.to_i
        case input
        when 1
            user_history_menu(symbol, profile)
        when 2
            if add_status == 0
                add_status = 1
                add_to_portfolio(symbol)
                user_stock_profile_menu(symbol, profile)
            elsif add_status == 1 || add_status == 2
                add_status = 0
                remove_from_portfolio(symbol)
                user_stock_profile_menu(symbol, profile)
            end
        when 3
            user_stock_research_menu
        when 4
            show_menu
        else
            puts "Please enter a valid command"
        end
end

