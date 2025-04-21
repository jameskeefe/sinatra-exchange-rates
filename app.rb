require "sinatra"
require "sinatra/reloader"
require "dotenv/load"

require "http"
require "json"

fxkey = ENV.fetch("EXCHANGE_RATE_KEY")

currs = ['AED','AFN','ALL','AMD','ANG','AOA','ARS','AUD','AWG','AZN','BAM','BBD','BDT','BGN','BHD','BIF','BMD','BND','BOB','BRL','BSD','BTC','BTN','BWP','BYN','BYR','BZD','CAD','CDF','CHF','CLF','CLP','CNY','CNH','COP','CRC','CUC','CUP','CVE','CZK','DJF','DKK','DOP','DZD','EGP','ERN','ETB','EUR','FJD','FKP','GBP','GEL','GGP','GHS','GIP','GMD','GNF','GTQ','GYD','HKD','HNL','HRK','HTG','HUF','IDR','ILS','IMP','INR','IQD','IRR','ISK','JEP','JMD','JOD','JPY','KES','KGS','KHR','KMF','KPW','KRW','KWD','KYD','KZT','LAK','LBP','LKR','LRD','LSL','LTL','LVL','LYD','MAD','MDL','MGA','MKD','MMK','MNT','MOP','MRU','MUR','MVR','MWK','MXN','MYR','MZN','NAD','NGN','NIO','NOK','NPR','NZD','OMR','PAB','PEN','PGK','PHP','PKR','PLN','PYG','QAR','RON','RSD','RUB','RWF','SAR','SBD','SCR','SDG','SEK','SGD','SHP','SLE','SLL','SOS','SRD','STD','SVC','SYP','SZL','THB','TJS','TMT','TND','TOP','TRY','TTD','TWD','TZS','UAH','UGX','USD','UYU','UZS','VEF','VES','VND','VUV','WST','XAF','XAG','XAU','XCD','XDR','XOF','XPF','YER','ZAR','ZMK','ZMW','ZWL']

get("/") do
  @currencies = currs

  erb(:home)
end

get("/:base") do
  @base = params[:base]
  @currencies = currs

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
