def add_to_portfolio(symbol)
    $CurrentUser.stocks << StockBySymbol(symbol)
end