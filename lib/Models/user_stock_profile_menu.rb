def user_stock_profile_menu(symbol)
    system('clear')
    while true
        profile = stock_full_profile(symbol)
        puts "Rating".red
        if profile["recommendation"].empty?
            puts "  No rating available for #{symbol}".blue
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
        puts
        puts "-----------------------------------------"
        puts "1) See History        2) Add to portfolio"
        puts "3) New Search         4) Main Menu"
        puts
        input = gets.chomp.to_i
        case input
        when 1
            user_history_menu(symbol)
        when 2
        when 3
            user_stock_research_menu
        when 4
            show_menu
        else
            puts "Please enter a valid command"
        end
    end
end

