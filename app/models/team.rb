class Team < ActiveRecord::Base
	has_many :players


	def self.import(data)
		data.each do |key, value|
		  alert key
		  value.each do |k,v|
		    alert k
		    alert v
		  end
		end

	end


	# def self.import(data)
	# 	#loop through each team in data, create a team object for them
	# 	for team in data

	# 		puts team
	# 		puts team["name"]
	# 		@newTeam = Team.create(:name => team["name"])

	# 		#loop through all the players in a team (assuming they get returned and add them)
	# 		for player in team
	# 			@player = @newTeam.players.create(:name => player["name"])
	# 		end
	# 	end
	# end
end
