require 'sinatra'
require './email_analytics_service.rb'

get '/' do
  text = EmailAnalyticsService.new.index
  erb :index, :locals => { :text => text }
end

get '/get_data' do
  start_date = params["start_date"]
  end_date = params["end_date"]
  text = EmailAnalyticsService.new(start_date, end_date).run
  erb :results, :locals => { :text => text }
end