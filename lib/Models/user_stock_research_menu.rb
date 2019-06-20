def user_stock_research_menu(rerun = 0)
    if rerun == 1 || rerun == 0
        system('clear')
    end
    if rerun == 2
        puts 'Please enter stock symbol or stock name to lookup or type "back" to go back'
        input = gets.chomp
        if valid_symbol?(input)
            user_stock_profile_menu(input)
        elsif input == "back"
            show_menu
        else
            print_recommendations(input)
            user_stock_research_menu(2)
        end
    elsif rerun == 1
        puts 'Sorry no match for that search. Try a different search term.'
    end
    puts 'Please enter stock symbol or stock name to lookup or type "back" to go back'
    input = gets.chomp
    if valid_symbol?(input)
        user_stock_profile_menu(input)
    elsif input == "back"
        show_menu
    else
        print_recommendations(input)
        user_stock_research_menu(2)
    end
end

def print_recommendations(input)
    recommendations = StockByName(input)
        if recommendations.length == 0
            system('clear')
            user_stock_research_menu(1)
        else
            system('clear')
            puts 'Did you mean any of these stocks?'
            puts
            recommendations.each do |stock|
                puts "Name: " + "#{stock[1]}".blue + " Symbol: " + "#{stock[0]}".magenta
                puts
            end
        end 
end
