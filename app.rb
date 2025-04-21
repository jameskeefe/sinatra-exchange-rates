require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

require "http"
require "json"

fxkey = ENV.fetch("EXCHANGE_RATE_KEY")

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end




# in the final version I'll need to only do the API call
convert_from = "USD"
convert_to = "EUR"

fx_url = "https://api.exchangerate.host/convert?from=#{convert_from}&to=#{convert_to}&amount=1&access_key=#{fxkey}"

data = HTTP.get(fx_url)
rate = data['result'].to_f

pp rate
