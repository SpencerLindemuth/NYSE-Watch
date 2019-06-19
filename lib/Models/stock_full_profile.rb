def stock_full_profile(symbol)
    profile_hash = {}
    get_rating(symbol, profile_hash)
    get_prices(symbol, profile_hash)
    get_current_price(symbol, profile_hash)
    profile_hash
end

def get_rating(symbol, profile_hash)
    url = "https://financialmodelingprep.com/api/v3/company/rating/#{symbol}"
    response_string = RestClient.get(url)
    response_hash = JSON.parse(response_string)
    score = response_hash["rating"]["score"]
    recommendation = response_hash["rating"]["recommendation"]
    rating = response_hash["rating"]["rating"]
    profile_hash["score"] = score
    profile_hash["recommendation"] = recommendation
    profile_hash["rating"] = rating
    profile_hash
end

    def get_prices(symbol, profile_hash)
        url = "https://financialmodelingprep.com/api/v3/historical-price-full/#{symbol}?timeseries=1"
        response_string = RestClient.get(url)
        response_hash = JSON.parse(response_string)
        open_price = response_hash["historical"][0]["open"]
        close_price = response_hash["historical"][0]["close"]
        high_price = response_hash["historical"][0]["high"]
        low_price = response_hash["historical"][0]["low"]
        change = response_hash["historical"][0]["change"]
        change_percent = response_hash["historical"][0]["changePercent"]
        profile_hash["open_price"] = open_price
        profile_hash["close_price"] = close_price
        profile_hash["high_price"] = high_price
        profile_hash["low_price"] = low_price
        profile_hash["change"] = change
        profile_hash["change_percent"] = change_percent
        profile_hash
    end

    def get_current_price(symbol, profile_hash)
        url = "https://financialmodelingprep.com/api/v3/stock/real-time-price/#{symbol}"
        response_string = RestClient.get(url)
        response_hash = JSON.parse(response_string)
        price = response_hash["price"]
        profile_hash["price"] = price
        profile_hash
    end
