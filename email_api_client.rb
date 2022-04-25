require 'net/http'
require 'openssl'

class EmailApiClient
	def initialize
		@url = URI("https://api.rd.services/platform/analytics/emails?start_date=01-01-2022&end_date=2022-04-07")
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true
		# @access_token = RDStationAPIAuthWrapper.new(ENV["CLIENT_ID"], ENV["CLIENT_SECRET"], ENV["CODE"]).generate_access_token

	end

	def get_data
		request = Net::HTTP::Get.new(@url)
		request["Accept"] = 'application/json'
		request["Authorization"] = "Bearer #{@access_token}"
		@http.request(request)
	end

	def mock_data
		data = []
		id = 1

		100.times do
			data << 
		 	{"send_at": (DateTime.now - (rand * 180)),
		 	"campaign_id": id,
		 	"campaign_name":"Email #{rand(1..1000) * rand(2123..30000)}",
		 	"email_dropped_count": rand(100),
		 	"email_delivered_count": rand(1000),
		 	"email_bounced_count": rand(10),
		 	"email_opened_count": rand(1000),
		 	"email_clicked_count": rand(1000),
		 	"email_unsubscribed_count": rand(1000),
		 	"email_spam_reported_count": rand(1000),
		 	"email_delivered_rate": rand() + rand(100),
		 	"email_opened_rate": rand() + rand(100),
		 	"email_clicked_rate": rand() + rand(100),
		 	"email_spam_reported_rate": rand() + rand(100),
		 	"contacts_count": rand(1000)}

		 	id += 1
		end
		data
	end

	
end




