def update_portfolio_prices(user)
    user.stocks.each do |stock|
        url = "https://financialmodelingprep.com/api/v3/stock/real-time-price/#{stock.symbol}"
        response_string = RestClient.get(url)
        response_hash = JSON.parse(response_string)
        if response_hash["price"]
            updated_price = response_hash["price"]
        end
        stock.price = updated_price
        stock.save
    end
end