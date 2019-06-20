def remove_from_portfolio(symbol)
    stock = $CurrentUser.stocks.find_by symbol: symbol
    id = stock.id
    $CurrentUser.stocks.delete(id)
end