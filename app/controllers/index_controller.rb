class IndexController < ApplicationController
  def login
  	@consumer_key = "dj0yJmk9d29mS1IyVDlQOXFHJmQ9WVdrOVEyeFRXbVY0TjJFbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD01Yw--"
	@consumer_secret = "86c4259ad8ac9bf6a36998eb01adac8147eb1184"
	# DO NOT EDIT THESE VALUES
	# Oauth variables
	# Yahoo Oauth Request Token Path
	@callback_url = "http://tradewhistle.herokuapp.com/oauth/callback"

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

  def confirmed
  	#verifier_code = params[:oauth_verifier]
  	@request_token = session[:request_token]
  	@access_token = @request_token.get_access_token

  	@json_response = @access_token.request(:get, "http://fantasysports.yahooapis.com/fantasy/v2/league/223.l.431/teams") # returns a Net::HTTPOK object, which needs to be converted to a JSON hash to be imported into Mongo

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
	@request_token = @auth_consumer.get_request_token(:oauth_callback => @callback_url)
	session[:request_token] = @request_token

	puts @request_token
  end
end
