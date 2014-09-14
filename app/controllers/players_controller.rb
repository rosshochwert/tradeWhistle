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

    #just do a collection!

    @players = Player.all
    @players.each do |player|
      @playerHash = downloadStat(player.yahoo_pid)
    end 

  end

  def download

    for i in 0..5
      working = false

      while !working do
        begin
          low = i * 25
          high = (i + 1) * 25 - 1
          @urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/league/" + $league_key + "/players;status=T;start=" + low.to_s + ";count=" + high.to_s + "/percent_owned?format=json"
          @json_response = $access_token.request(:get, @urlLeagueKey)
          working = true;
        rescue
          puts "Error!"
        end
      end

        @json_hash = JSON.parse(@json_response.body)
        @playersStatHash = @json_hash["fantasy_content"]["league"][1]["players"]
        @playersStatHash.each do |key,value|
        if key === "count"
          next
        end

        playerkey = value["player"][0][0]["player_key"]
        
        full_name = value["player"][0][2]["name"]["full"]

        percent = value["player"][1]["percent_owned"][1]["value"].to_i

        puts playerkey

        @player = Player.find_by(first_name: full_name)

        unless @player.nil?
          @player.update_attributes(:percentOwned => percent)
        end
      end
    end

  end

  def downloadStat(playerID)
    @urlLeagueKey = "http://fantasysports.yahooapis.com/fantasy/v2/player/" + playerID + "/percent_owned?format=json"
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
