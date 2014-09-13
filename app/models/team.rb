class Team < ActiveRecord::Base
	has_many :players

	def self.import(data)
		#loop through each team in data, create a team object for them
		for team in data
			@newTeam = Team.create(:name => team["name"])

			#loop through all the players in a team (assuming they get returned and add them)
			for player in team
				@player = @newTeam.players.create(:name => player["name"])
			end
		end
	end
end
