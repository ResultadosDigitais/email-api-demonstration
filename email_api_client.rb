require 'net/http'
require 'openssl'
require 'date'
require 'json'
require 'dotenv/load'

class EmailApiClient
	def initialize(start_date, end_date)
		@start_date = Date.parse(start_date)
		@end_date = Date.parse(end_date)
		@url = URI("https://api.rd.services/platform/analytics/emails?start_date=#{start_date}&end_date=#{end_date}")
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true
		@access_token = ENV['TOKEN']
  end

	def get_data
		request = Net::HTTP::Get.new(@url)
		request["Accept"] = 'application/json'
		request["Authorization"] = "Bearer #{@access_token}"
		response = @http.request(request)
    data = JSON.parse(response.body)
    data["emails"]
	end
end




