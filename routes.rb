require 'sinatra'
require './email_analytics_service.rb'

get '/' do
  erb :index
end

get '/auth/callback' do
  erb :index
end

post '/get_data' do
  start_date = params["start_date"]
  end_date = params["end_date"]
  key = params["key"]
  token = params["token"]
  service = EmailAnalyticsService.new(start_date, end_date, key)
  text = service.run
  erb :results, :locals => { :text => text }
end