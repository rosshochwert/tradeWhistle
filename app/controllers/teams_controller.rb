class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end


  def importData
    @leagueKey = getLeagueKey
    @teams = getTeams(@league_key)
    @teamHash = @teams["fantasy_content"]["league"][1]["teams"]

    @counter = 0
    @teamHash.each do |key,value|
      puts key
      puts value["team"][0][0]["team_key"] #team key?
      puts value["team"][0][2]["name"] #team name?

     # Team.create!(:key => key, :name => name)
    end

    #make a call to the api to get a league, choose the first league and get all of the data
    #Team.import(stuff)
  end

  def getLeagueKey
    @urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games;game_keys=nfl/leagues?format=json"
    @json_response = $access_token.request(:get, @urlLeagueKey)
    @json_hash = JSON.parse(@json_response.body)
    @league_key = @json_hash["fantasy_content"]["users"]["0"]["user"][1]["games"]["0"]["game"][1]["leagues"]["0"]["league"][0]["league_key"]
  end

  def getTeams(key)
    @url = 'http://fantasysports.yahooapis.com/fantasy/v2/league/' + key + '/teams?format=json'
    @json_response = $access_token.request(:get, @url)
    @json_hash = JSON.parse(@json_response.body)
  end

  def andrewGetsTheTeam

  end


  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
