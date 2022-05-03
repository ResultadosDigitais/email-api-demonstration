require 'date'
require './email_api_client.rb'

class EmailAnalyticsService
	def initialize(start_date, end_date, key)
		@key = key
		@email_data = EmailApiClient.new(start_date, end_date).get_data
	end

	def run
		if @email_data.length == 1
			average_rate = @email_data.first[:"#{@key}"]
			median_rate = @email_data.first[:"#{@key}"]
		else 
			@email_data.sort_by! { |email| email[:"#{@key}"]}
		    average_rate = average(@email_data)
		    median_rate = median(@email_data)
		end
		print_results(average_rate, median_rate)
	end

	private

	def median(email_data)
		return email_data[(email_data.length - 1) / 2] if email_data.length.odd?

	    first = (email_data.length - 1) / 2
	    second = email_data.length / 2
	    (email_data[first][:"#{@key}"] + email_data[second][:"#{@key}"]) / 2
	end

	def average(email_data)
		email_data.map { |e| e[:"#{@key}"]}.sum / email_data.length
	end

	def tendancy(email_data)
		grouped = email_data.group_by { |email| email[:send_at].month }
		results = grouped.map { |key, data| [key, average(data)] }
		results
	end

	def print_results(average_rate, median_rate)
		 [{ 
		 	emails_analisados: "#{@email_data.length}",
		 	media: "#{average_rate}",
		 	mediana: "#{median_rate}",
		 	melhor_rate: @email_data.last,
		 	pior_rate: @email_data.first,
		 	melhor_mes: tendancy(@email_data).last,
		 	pior_mes: tendancy(@email_data).first,
		 	tendancy: tendancy(@email_data),
		 	key: @key
		 }]
	end
end
