class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  #get all the stuff
  def downloadTBD
    @players = Player.all
    @players.each do |player|
      @playerHash = downloadStat(player.yahoo_pid)
    end 

  end

  def download
    @urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/league/223.l.431;out=settings/teams;team_keys=223.l.431.t.1/players/stats?format=json"
    #@urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/player/331.p.25711/stats?format=json"
    @json_response = $access_token.request(:get, @urlLeagueKey)
    @json_hash = JSON.parse(@json_response.body)
    puts @json_hash
  end

  def downloadStat(playerID)
    @urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/player/" + playerID + "/stats?format=json"
    @json_response = $access_token.request(:get, @urlLeagueKey)
    @json_hash = JSON.parse(@json_response.body)
    return @json_hash
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:first_name, :last_name, :number, :team_id)
    end
end
