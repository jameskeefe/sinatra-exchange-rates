require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

require "http"
require "json"

fxkey = ENV.fetch("EXCHANGE_RATE_KEY")

currs = ["USD","EUR","GBP","JPY"]

get("/") do
  @currencies = currs

  erb(:home)
end

get("/USD") do
  @base = "USD"
  @currencies = currs

  erb(:select)
end 

get("/USD/EUR") do
  fxkey = ENV.fetch("EXCHANGE_RATE_KEY")

  # IRB for interactive console
  
  # in the final version I'll need to only do the API call
  @convert_from = "USD"
  @convert_to = "EUR"
  
  fx_url = "https://api.exchangerate.host/convert?from=#{@convert_from}&to=#{@convert_to}&amount=1&access_key=#{fxkey}"
  
  data = HTTP.get(fx_url)
  data = JSON.parse(data)
  @rate = data['result'].to_f

  erb(:convert)
  
end
