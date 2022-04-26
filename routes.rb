require 'sinatra'
require './email_analytics_service.rb'

get '/' do
  erb :index
end

post '/get_data' do
  p params
  start_date = params["start_date"]
  end_date = params["end_date"]
  text = EmailAnalyticsService.new(start_date, end_date).run
  erb :results, :locals => { :text => text }
end