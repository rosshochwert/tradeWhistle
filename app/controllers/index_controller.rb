class IndexController < ApplicationController
  def login
  	@consumer_key = "dj0yJmk9MEI3TUJTY2p4ejd0JmQ9WVdrOWMxVnBibmh4TldjbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD00Yg--"
	@consumer_secret = "1d72c082a87b6ac66fa9e02fb33efe215da500af"
	# DO NOT EDIT THESE VALUES
	# Oauth variables
	# Yahoo Oauth Request Token Path
	@callback_url = "http://localhost:3000/oauth/callback"

	@yahoo_oauth_request_token_path = '/oauth/v2/get_request_token'
	# Yahoo Oauth Access Token Path
	@yahoo_oauth_access_token_path = '/oauth/v2/get_token'
	# Yahoo Oauth Authorize Path
	@yahoo_oauth_authorize_path = '/oauth/v2/request_auth'
	# Eng Yahoo Oauth Variables
	@yahoo_oauth_url = "https://api.login.yahoo.com"
	
	retrieveYahoo

	@link = @request_token.authorize_url(:oauth_callback => @callback_url)
  end

  def authorize

  	verifier_code = params[:code]

  	puts verifier_code

	@request_token = session[:request_token]

  	puts "here she is"
  	puts @request_token
  	puts "that was the request token"
  	@access_token = @request_token.get_access_token(:oauth_verifier => verifier_code)

  	@json_response = @access_token.request(:get, "http://fantasysports.yahooapis.com/fantasy/v2/league/223.l.431/teams") # returns a Net::HTTPOK object, which needs to be converted to a JSON hash to be imported into Mongo
	#@json_hash = JSON.parse(@json_response.body) # converts the Net object to a Hash
	puts @json_response
  end

  def register
  end

  def retrieveYahoo
  	puts "im being called!!!!"

	@auth_consumer=OAuth::Consumer.new @consumer_key, 
								  @consumer_secret, {
								  :site					=> @yahoo_oauth_url,
								  :scheme               => :query_string,
								  :http_method			=> :get,
								  :request_token_path   => @yahoo_oauth_request_token_path,
								  :access_token_path    => @yahoo_oauth_access_token_path,
								  :authorize_path       => @yahoo_oauth_authorize_path
								   }
 
	# Set request token 
	@request_token = @auth_consumer.get_request_token(:oauth_callback => '')
	session[:request_token] = @request_token

	puts @request_token
  end
end
