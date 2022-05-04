require 'net/http'
require 'openssl'

class RDStationAPIAuthWrapper
  def initialize(client_id, client_secret, code)
  	@client_id = client_id
  	@client_secret = client_secret
  	@code = code
  	@url = URI("https://api.rd.services/auth/token?client_id=#{@client_id}&client_secret=#{@client_secret}&code=#{@code}")
		@http = Net::HTTP.new(@url.host, @url.port)
		@http.use_ssl = true
  end

  def generate_access_token
  	req = Net::HTTP::Post.new(@url)
    resp = @http.request(req)
    data = JSON.parse(resp.body)
    # CACHE_SERVICE(resp["refresh_token"])
    data["access_token"]
  end

  def refresh_access_token
  	## NOT IMPLEMENTED, the aplication must have a cache service to use this
  	# request = Net::HTTP.post URI('http://www.example.com/api/search'),
    #            { "client_id" => @client_id, "client_secret" => @client_secret, "refresh_token" => CACHE_TOKEN }.to_json
    # @http.request
  end
end