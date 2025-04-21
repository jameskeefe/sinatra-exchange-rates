require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

require "http"
require "json"

fxkey = ENV.fetch("EXCHANGE_RATE_KEY")

get("/") do
  fx_url = "https://api.exchangerate.host/list?access_key=#{fxkey}"
  data = HTTP.get(fx_url)
  data = JSON.parse(data)


  @currencies = data['currencies'].keys()
  
  erb(:home)

end

get("/:base") do
  fx_url = "https://api.exchangerate.host/list?access_key=#{fxkey}"
  data = HTTP.get(fx_url)
  data = JSON.parse(data)

  @currencies = data['currencies'].keys()

  @base = params[:base]
  
  erb(:select)
end 

get("/:base/:quote") do
  fxkey = ENV.fetch("EXCHANGE_RATE_KEY")

  # in the final version I'll need to only do the API call
  @base = params[:base]
  @quote = params[:quote]
  
  fx_url = "https://api.exchangerate.host/convert?from=#{@base}&to=#{@quote}&amount=1&access_key=#{fxkey}"
  data = HTTP.get(fx_url)
  data = JSON.parse(data)

  @rate = data['result'].to_f

  erb(:convert)
  
end
