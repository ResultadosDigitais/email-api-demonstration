require 'net/http'
require 'openssl'
require 'date'
require 'json'
require './rdstation_api_auth_wrapper.rb'

class EmailApiClient
	def initialize(start_date, end_date)
		@start_date = Date.parse(start_date)
		@end_date = Date.parse(end_date)
		@url = URI("https://api.rd.services/platform/analytics/emails?start_date=#{start_date}&end_date=#{end_date}")
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true
		@access_token = RDStationAPIAuthWrapper.new('18bc90d9-93ed-46db-b9ba-7bb03ea8e68c', '3b95fab001de4695a6f33f1877037e4f', '64670538c2ec62f5ca163efbd80c4c02').generate_access_token
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




