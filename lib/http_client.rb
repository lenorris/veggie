require 'rest_client'

class HttpClient
	def get(base_url, parameters = {})
		RestClient.get base_url, :params => parameters
	end
end