require_relative './game_models/player_model'
require_relative './game_models/play_game_model'
require_relative './game_controllers/play_game'

players = []
2.times do |n|
	loop do
		puts "Player #{n+1}, what is your name?"
		name = gets.chomp
		if name == ""
			puts "not a valid response"
		else 
			players.push(PlayerModel.new(name))
			break
		end
	end
end

game_model = PlayGameModel.new(players)
Game = PlayGame.new(game_model)
Game.start
