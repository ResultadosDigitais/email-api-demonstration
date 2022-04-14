require 'uri'
require 'net/http'
require 'openssl'



class EmailApiClient
	def initialize
		@url = URI("https://api.rd.services/platform/analytics/emails?start_date=01-01-2022&end_date=2022-04-07")
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true

	end

	def get_data
		request = Net::HTTP::Get.new(@url)
		request["Accept"] = 'application/json'
		request["Authorization"] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwaS5yZC5zZXJ2aWNlcyIsInN1YiI6ImtOUFVUSURaYkxicF9MT19oempKbkg1NlR5TXp6bTBFVno3eDcxVTk3YllAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vYXBwLnJkc3RhdGlvbi5jb20uYnIvYXBpL3YyLyIsImFwcF9uYW1lIjpudWxsLCJleHAiOjE2NDk4NTYzNTIsImlhdCI6MTY0OTc2OTk1Miwic2NvcGUiOiIifQ.HMGrDRFy7rAKCDebcdsJmZg3QsbUtxnSG9oL77F-0rSWRfT66ufx7jj-WD3v-njKOfEMd13c1xkgNR9vi-EXpeuFjigmjXkJlcVBogORobr5mYe0OgfVHoG8B5CMWl0sj3IMaqr52Icv5ceMoon2SxnwhNNA4E_tCv1Ho573F2U6D5kLWw0b2oDl13mHa9evQeV6rLRX8r0EPFxTGkU-CKfK5Gg-jVNBFtoMMtUIzjWN9a2y6PuGBkIK_ZLq3lcm0tsZx6NDRrZ_iCsBV9somPYBSBeqgrE0txiYkJJfg8DEHnqEViM747i7VOMnldIp2pv8Z5SGBAszSOCerhqkaw'
		@http.request(request)
	end

	def mock_data
		data = []
		id = 1

		100_000.times do
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




