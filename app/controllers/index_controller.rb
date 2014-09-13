class IndexController < ApplicationController
  def login
  	@consumer_key = "dj0yJmk9d29mS1IyVDlQOXFHJmQ9WVdrOVEyeFRXbVY0TjJFbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD01Yw--"
	@consumer_secret = "86c4259ad8ac9bf6a36998eb01adac8147eb1184"
  	
  	session[:consumer_secret] = @consumer_secret
  	session[:consumer_key] = @consumer_key
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
  	verifier_code = params[:oauth_verifier]
  	@request_token = session[:request_token]
  	@consumer_key = session[:consumer_key]
  	@consumer_secret = session[:consumer_secret]
  	@access_token = @request_token.get_access_token(:oauth_verifier => verifier_code)
  end

  #method to import all of the data form the league into the database
  def import
    @leagueKey = getLeagueKey
    getTeams(@league_key)

    #make a call to the api to get a league, choose the first league and get all of the data
    #Team.import(stuff)

  end


  def getLeagueKey
    @urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games;game_keys=nfl/leagues?format=json"
    @json_response = @access_token.request(:get, @urlLeagueKey)
    @json_hash = JSON.parse(@json_response.body)
    @league_key = @json_hash["fantasy_content"]["users"]["0"]["user"][1]["games"]["0"]["game"][1]["leagues"]["0"]["league"][0]["league_key"]
  end

  def getTeams(key)
    @url = 'http://fantasysports.yahooapis.com/fantasy/v2/league/' + key + '/teams'
    @json_response = @access_token.request(:get, @url)
    @json_hash = JSON.parse(@json_response.body)
  end

  def retrieveYahoo
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
  end
end
