require 'net/http'
require 'openssl'
require 'date'

class EmailApiClient
	def initialize(start_date, end_date)
		@start_date = Date.parse(start_date)
		@end_date = Date.parse(end_date)
		@url = URI("https://api.rd.services/platform/analytics/emails?start_date=#{start_date}&end_date=#{end_date}")
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

	def generate_mock
        mock_emails.map do |email|
          generate_statistics(email)
        end
    end


    def mock_emails
    	[ "Nutrição 1", "Nutrição 2", "Nutrição 3", "Nutrição 4", "Nutrição 5", "Nutrição 6",      
          "Oportunidade - Perdida 1", "Oportunidade - Perdida 2", "Oportunidade - Perdida 3",
          "Leads Desengajados 1", "Leads Desengajados 2", "Leads Desengajados 3", "Leads Desengajados 4",
          "Oportunidade - MQL 1", "Oportunidade - MQL 2", "Oportunidade - MQL 3", "Oportunidade - MQL 4",
          "Pós-vendas 1", "Pós-vendas 2", "Pós-vendas 3", "Pós-vendas 4", "Pós-vendas 5"
        ]
    end

    def generate_statistics(email)
        contacts = rand(100..1000)
        delivered = contacts - rand(1..50)
        opened = (delivered * rand).to_i
        clicked = opened / rand(1..10)
        spam_reported = opened / rand(20..30)
        range = (@start_date..@end_date).to_a
        {
          campaign_name: email,
          send_at: range.sample,
          contacts_count: contacts,
          email_dropped_count: contacts - delivered,
          email_delivered_count: delivered,
          email_bounced_unique_count: (delivered / rand(1..100)).to_i,
          email_opened_unique_count: opened,
          email_clicked_unique_count: clicked,
          email_unsubscribed_count: (opened / rand(10..20)).to_i,
          email_spam_reported_count: spam_reported,
          email_delivered_rate: (delivered * 100) / contacts.to_f,
          email_opened_rate: (opened * 100) / delivered.to_f,
          email_clicked_rate: (clicked * 100) / delivered.to_f,
          email_spam_reported_rate: (spam_reported * 100) / delivered.to_f,
        }
    end	
end




