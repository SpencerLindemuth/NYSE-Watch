def edit_portfolio(rerun = 0)
    system('clear')
    if rerun == 1
        puts "Please enter a valid command."
    elsif rerun == 2
        puts "Please pick a valid symbol and try again"
    end
    if $CurrentUser.stocks
        puts "#{$CurrentUser.name}'s current portfolio:"
        puts
        x = $CurrentUser.stocks
        puts "Name / (symbol) / Current Price / Day change"
        x.each do |stock|
            if stock.day_change >= 0
            puts "#{stock.name} ".blue + "    (#{stock.symbol})   ".red + "    #{stock.price}     ".green + "     #{stock.day_change} ".green
            else
                puts "#{stock.name} ".blue + "    (#{stock.symbol})   ".red + "    #{stock.price}     ".red + "     #{stock.day_change} ".red
            end
        end
        puts
        puts "What would you like to do next?"
        puts
        puts "1) Remove stock       2)Search Stocks"
        puts "3) Main Menu"
        input = gets.chomp.to_i
        case input
        when 1
            delete_stock_from_portfolio
        when 2
            user_stock_research_menu
        when 3
            show_menu
        else
            edit_portfolio(1)
        end
    else
          puts "You currently have no stocks, please add through the search tab."
          puts "1)Search Stocks       2)Main Menu"
          input = gets.chomp.to_i
          case input
          when 1
            user_stock_research_menu
          when 2
            show_menu
          else
            edit_portfolio(1)
          end
    end
end

def delete_stock_from_portfolio
    puts "Please enter symbol of stock to remove:"
    input = gets.chomp.upcase
    if valid_symbol?(input)
        remove_from_portfolio(input)
        edit_portfolio
    else
        edit_portfolio(2)
    end
end
        