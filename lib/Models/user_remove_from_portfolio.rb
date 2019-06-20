def remove_from_portfolio(symbol)
    $CurrentUser.stocks.where(symbol: symbol).destroy_all
end