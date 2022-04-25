require 'net/http'
require 'openssl'

class RDStationAPIAuthWrapper
  def initialize(client_id, client_secret, code)
  	@client_id = client_id
  	@client_secret = client_secret
  	@code = code
  	@url = URI("https://api.rd.services/auth/token")
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true
  end

  def generate_access_token
  	request = Net::HTTP.post URI('http://www.example.com/api/search'),
               { "client_id" => @client_id, "client_secret" => @client_secret, "code" => @code }.to_json
    resp = @http.request
    # CACHE_SERVICE(resp["refresh_token"])
    resp["access_token"]
  end

  def refresh_access_token
  	## NOT IMPLEMENTED, the aplication must have a cache service to use this
  	# request = Net::HTTP.post URI('http://www.example.com/api/search'),
    #            { "client_id" => @client_id, "client_secret" => @client_secret, "refresh_token" => CACHE_TOKEN }.to_json
    # @http.request
  end
end