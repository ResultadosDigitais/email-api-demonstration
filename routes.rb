require 'sinatra'
require './email_analytics_service.rb'

get '/' do
  erb :index
end

post '/get_data' do
  start_date = params["start_date"]
  end_date = params["end_date"]
  key = params["key"]
  service = EmailAnalyticsService.new(start_date, end_date, key)
  text = service.run
  erb :results, :locals => { :text => text }
end