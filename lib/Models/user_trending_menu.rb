class UserTrendingMenu

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
  
end
